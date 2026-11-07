#!/usr/bin/env bash
# product-builder: PostToolUse security scan for Write/Edit.
#
# Scans the file Claude just wrote or edited (as it now is on disk) for:
#   A. high-confidence secrets          -> every text file, docs included
#   B. risky security configuration     -> code and config files only
# Findings go back to Claude through hookSpecificOutput.additionalContext.
# Only the rule name, line numbers, and a fix hint are reported. The matched
# text is never echoed, so a real secret is not copied into the transcript.
#
# To suppress a deliberate line (test fixture, documented example), put
#   security-scan: ignore
# in a comment on that line.
#
# Portable: bash 3.2+, POSIX grep -E / sed / awk / tr. No jq, no grep -P.
# Fails open: any problem (bad input, unreadable file) -> print nothing, exit 0.
# Fast path: one combined grep; clean files cost only a few processes.

MAX_BYTES=1048576
MAX_RULES_SHOWN=10
MAX_LINES_PER_RULE=5
IGNORE_MARK='security-scan: ignore'
NL='
'

input=$(cat 2>/dev/null) || exit 0
[ -n "$input" ] || exit 0

# First "key": "value" pair in the payload -> $REPLY (value still JSON-escaped).
json_str_field() {
  REPLY=""
  local re="\"$1\"[[:space:]]*:[[:space:]]*\"([^\"]*)\""
  if [[ $input =~ $re ]]; then REPLY="${BASH_REMATCH[1]}"; fi
}

# JSON-escaped path -> usable path. Windows "C:\\Users\\x" becomes "C:/Users/x".
BS2='\\'
BSL='\/'
SL='/'
unescape_path() {
  REPLY="${1//"$BS2"/$SL}"
  REPLY="${REPLY//"$BSL"/$SL}"
}

json_str_field file_path; unescape_path "$REPLY"; path=$REPLY
[ -n "$path" ] || exit 0
json_str_field cwd; unescape_path "$REPLY"; cwd=${REPLY%/}

case "$path" in
  /*|[A-Za-z]:/*) ;;
  *) [ -n "$cwd" ] && path="$cwd/$path" ;;
esac
[ -f "$path" ] || exit 0

# Path relative to the project, for display and for skip rules (so a parent
# directory that happens to be called "build" doesn't hide the whole project).
rel="$path"
if [ -n "$cwd" ]; then
  case "$path" in "$cwd"/*) rel="${path#"$cwd"/}" ;; esac
fi

shopt -s nocasematch
case "/$rel" in
  */node_modules/*|*/vendor/*|*/dist/*|*/build/*|*/.git/*) exit 0 ;;
  *.min.js|*.min.css|*.map) exit 0 ;;
  */package-lock.json|*/npm-shrinkwrap.json|*/yarn.lock|*/pnpm-lock.yaml|*/bun.lock|*/bun.lockb) exit 0 ;;
  */cargo.lock|*/poetry.lock|*/uv.lock|*/pipfile.lock|*/gemfile.lock|*/composer.lock|*/go.sum) exit 0 ;;
  */packages.lock.json|*/flake.lock|*/podfile.lock|*/pubspec.lock|*/mix.lock) exit 0 ;;
esac
is_doc=0
case "$rel" in *.md|*.mdx|*.markdown|*.txt|*.rst|*.adoc) is_doc=1 ;; esac
shopt -u nocasematch

size=$(wc -c < "$path" 2>/dev/null)
size=${size//[[:space:]]/}
case "$size" in ''|*[!0-9]*) exit 0 ;; esac
[ "$size" -le "$MAX_BYTES" ] || exit 0
grep -Iq . "$path" 2>/dev/null || exit 0   # binary or empty

# ---- Rules ---------------------------------------------------------------------
# rule NAME SEVERITY GREP_FLAGS ERE EXCLUDE_ERE FIX DOCS(1 = also scan docs)
R_NAME=(); R_SEV=(); R_FLAGS=(); R_ERE=(); R_EXCL=(); R_FIX=(); R_DOCS=()
rule() {
  local i=${#R_NAME[@]}
  R_NAME[i]=$1; R_SEV[i]=$2; R_FLAGS[i]=$3; R_ERE[i]=$4; R_EXCL[i]=$5; R_FIX[i]=$6; R_DOCS[i]=$7
}

Q="[\"'\`]"     # any quote character
QQ="[\"']"      # single or double quote

# Set A: high-confidence secrets (all text files).
rule "Private key material" "Critical" "" \
  '-----BEGIN ([A-Z0-9]+ )*PRIVATE KEY( BLOCK)?-----' "" \
  "remove it from the file, load it from a secrets manager or key store, and rotate the key pair." 1

rule "AWS access key ID" "Critical" "" \
  '(^|[^A-Z0-9])(AKIA|ASIA)[A-Z0-9]{16}([^A-Z0-9]|$)' 'AKIA[A-Z0-9]*EXAMPLE' \
  "use an IAM role or a secrets manager instead of a static key, and deactivate this key in IAM." 1

rule "GitHub token" "Critical" "" \
  '(gh[pousr]_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{40,})' "" \
  "revoke it in GitHub settings and inject it from CI secrets or a secrets manager." 1

rule "Slack token or webhook URL" "High" "" \
  '(xox[abposr]-[A-Za-z0-9-]{10,}|hooks\.slack\.com/services/T[A-Za-z0-9]+/B[A-Za-z0-9]+/[A-Za-z0-9]+)' "" \
  "regenerate it in Slack and load it from the environment or a secrets manager." 1

rule "Stripe live secret key" "Critical" "" \
  '(sk|rk)_live_[A-Za-z0-9]{20,}' "" \
  "roll the key in the Stripe dashboard and load it server-side from a secrets manager." 1

rule "Anthropic API key" "Critical" "" \
  'sk-ant-[A-Za-z0-9_-]{20,}' "" \
  "revoke the key where it was issued and load it from the environment or a secrets manager." 1

rule "OpenAI API key" "Critical" "" \
  'sk-((proj|svcacct|admin)-[A-Za-z0-9_-]{40,}|[A-Za-z0-9]{20}T3BlbkFJ[A-Za-z0-9]{20})' "" \
  "revoke the key where it was issued and load it from the environment or a secrets manager." 1

rule "Google API key" "High" "" \
  'AIza[0-9A-Za-z_-]{35}' "" \
  "regenerate or restrict it in Google Cloud and keep it out of source; browser keys need API and referrer restrictions." 1

rule "Hardcoded JWT" "High" "" \
  "[=:][[:space:]]*${Q}?(Bearer[[:space:]]+)?eyJ[A-Za-z0-9_-]{10,}\\.eyJ[A-Za-z0-9_-]{10,}\\.[A-Za-z0-9_-]{10,}" "" \
  "don't embed tokens; obtain them at runtime, and revoke this one if it is real." 1

KEYNAMES='(password|passwd|pwd|secret|api[_-]?key|apikey|access[_-]?key|access[_-]?token|auth[_-]?token|bearer[_-]?token|private[_-]?key)'
rule "Hardcoded credential assignment" "High" "-i" \
  "${KEYNAMES}${QQ}?[[:space:]]*(:|=|:=|=>)[[:space:]]*${QQ}[^\"'[:space:]]{8,}${QQ}" \
  '(changeme|change_me|placeholder|xxx|\*\*\*|<[^>]*>|\$\{|\{\{|process\.env|os\.environ|getenv|import\.meta\.env|env\[|secrets\.|redacted|(^|[^a-z])(test|fake|mock|dummy|sample|example|your))' \
  "move the value to environment injection or a secrets manager, and rotate it if it was ever committed." 1

# Set B: risky configuration (code and config files only).
rule "Wildcard IAM action or resource" "High" "" \
  "(Action|NotAction|Resource|actions|resources)${QQ}?[[:space:]]*[:=][[:space:]]*\\[?[[:space:]]*${QQ}\\*${QQ}" "" \
  "scope the policy to the specific actions and resource ARNs needed; a wildcard gives one leaked credential a broad blast radius." 0

rule "Service-wide IAM wildcard" "High" "" \
  "${QQ}(\\*|[a-z0-9-]+):\\*${QQ}" "" \
  "list the specific actions needed instead of granting every action in the service." 0

rule "Wildcard CORS origin" "Medium (High with credentials)" "-i" \
  "(access-control-allow-origin${QQ}?[[:space:]]*[:,=][[:space:]]*${QQ}?\\*|(^|[^a-z_])origins?${QQ}?[[:space:]]*[:=][[:space:]]*\\[?[[:space:]]*${QQ}\\*${QQ}|allow_origins[[:space:]]*=[[:space:]]*\\[[[:space:]]*${QQ}\\*${QQ})" "" \
  "allow only the known front-end origins; with credentials, a wildcard or reflected origin lets any site make authenticated requests." 0

rule "TLS certificate verification disabled" "High" "" \
  "(verify[[:space:]]*=[[:space:]]*False|rejectUnauthorized${QQ}?[[:space:]]*:[[:space:]]*false|InsecureSkipVerify[[:space:]]*:[[:space:]]*true|NODE_TLS_REJECT_UNAUTHORIZED${QQ}?[[:space:]]*[:=][[:space:]]*${QQ}?0|CURLOPT_SSL_VERIFYPEER[^;]*(false|0)|ssl_verify[[:space:]]*[:=][[:space:]]*(false|False|0)|curl[^|;]*[[:space:]](-k|--insecure)([[:space:]]|\$))" "" \
  "keep verification on; for an internal CA, configure the CA bundle instead of disabling the check." 0

sql_kw() {  # $1 = the character that ends the string literal
  printf '(SELECT[[:space:]][^%s]*FROM|INSERT[[:space:]]+INTO|UPDATE[[:space:]][^%s]*SET|DELETE[[:space:]]+FROM)' "$1" "$1"
}
DQ=$(sql_kw '"')
SQ=$(sql_kw "'")
BT=$(sql_kw '`')
CONCAT='[[:space:]]*(\+|\.[[:space:]]*\$|%[[:space:]]*[(A-Za-z_]|\.format\()'
rule "SQL built by string concatenation or interpolation" "High if any part is user input" "" \
  "\"${DQ}[^\"]*\"${CONCAT}|'${SQ}[^']*'${CONCAT}|\`${BT}[^\`]*\\\$\\{|f\"${DQ}[^\"]*\\{|f'${SQ}[^']*\\{" \
  '(sql|SQL|Sql|queryRaw|executeRaw)`' \
  "use parameterized queries or the ORM's bound parameters; never splice request data into SQL text." 0

rule "eval/exec on request data" "High" "" \
  '(^|[^A-Za-z0-9_.])(eval|exec|new[[:space:]]+Function)[[:space:]]*\([^)]*(req\.|request\.|params|query|body|\$_(GET|POST|REQUEST|COOKIE)|input\()' "" \
  "never evaluate request data as code; parse it as data (JSON, a schema) or map it to an allowlisted action." 0

rule "Shell command built from strings" "High if any part is user input" "" \
  "(shell[[:space:]]*=[[:space:]]*True|(^|[^A-Za-z0-9_])(exec|execSync|system|popen|shell_exec|passthru)[[:space:]]*\\(([^)]*(\\\$\\{|${Q}[[:space:]]*\\+|\\.format\\()|([^)]*[,[:space:]])?f${QQ}))" "" \
  "pass arguments as an array (execFile/spawn, subprocess with shell=False) and validate them against an allowlist." 0

PUBLIC_ACL='(public-read(-write)?|PublicRead(Write)?|block_public_acls[[:space:]]*=[[:space:]]*false|block_public_policy[[:space:]]*=[[:space:]]*false|BlockPublic(Acls|Policy)["'"'"']?[[:space:]]*:[[:space:]]*false|"allUsers"|"allAuthenticatedUsers")'  # security-scan: ignore
rule "Public storage bucket or object ACL" "High" "" "$PUBLIC_ACL" "" \
  "keep buckets private; serve public assets through a CDN with origin access control, or use signed URLs." 0

OPEN_NET='0\.0\.0\.0/0|::/0'

# ---- Fast path: one combined, case-insensitive pass (a superset of all rules) ---
pre=()
for ((i = 0; i < ${#R_NAME[@]}; i++)); do
  [ "$is_doc" -eq 1 ] && [ "${R_DOCS[i]}" -eq 0 ] && continue
  pre+=(-e "${R_ERE[i]}")
done
[ "$is_doc" -eq 0 ] && pre+=(-e "$OPEN_NET")
cand=$(grep -n -i -E "${pre[@]}" "$path" 2>/dev/null) || exit 0

lines=""
while IFS= read -r l; do
  case "$l" in *"$IGNORE_MARK"*) continue ;; esac
  lines="$lines$l$NL"
done <<EOF
$cand
EOF
[ -n "$lines" ] || exit 0

# ---- Per-rule matching on the candidate lines only ------------------------------
report=""
rules_hit=0
rules_hidden=0
total=0

# add_finding NAME SEVERITY FIX MATCHED_LINES("N:content" per line)
add_finding() {
  local n=0 shown="" l
  while IFS= read -r l; do
    [ -n "$l" ] || continue
    n=$((n + 1))
    [ "$n" -le "$MAX_LINES_PER_RULE" ] && shown="$shown${shown:+, }${l%%:*}"
  done <<EOF
$4
EOF
  [ "$n" -gt 0 ] || return 0
  total=$((total + n))
  rules_hit=$((rules_hit + 1))
  if [ "$rules_hit" -gt "$MAX_RULES_SHOWN" ]; then
    rules_hidden=$((rules_hidden + 1))
    return 0
  fi
  local label="line" more=""
  [ "$n" -gt 1 ] && label="lines"
  [ "$n" -gt "$MAX_LINES_PER_RULE" ] && more=" (+$((n - MAX_LINES_PER_RULE)) more)"
  report="$report$NL- $1 [suggested: $2] at $label $shown$more. Fix: $3"
}

for ((i = 0; i < ${#R_NAME[@]}; i++)); do
  [ "$is_doc" -eq 1 ] && [ "${R_DOCS[i]}" -eq 0 ] && continue
  m=$(grep ${R_FLAGS[i]} -E -e "${R_ERE[i]}" 2>/dev/null <<EOF
$lines
EOF
) || continue
  if [ -n "${R_EXCL[i]}" ]; then
    m=$(grep -v ${R_FLAGS[i]} -E -e "${R_EXCL[i]}" 2>/dev/null <<EOF
$m
EOF
) || continue
  fi
  add_finding "${R_NAME[i]}" "${R_SEV[i]}" "${R_FIX[i]}" "$m"
done

# 0.0.0.0/0 (or ::/0) within a few lines of port 22 or 3389. Needs the whole  (security-scan: ignore)
# file, because the port is usually on a different line from the CIDR.
if [ "$is_doc" -eq 0 ]; then
  case "$lines" in
    *0.0.0.0/0*|*::/0*)  # security-scan: ignore
      open_admin=$(awk -v ign="$IGNORE_MARK" '
        { l[NR] = $0 }
        END {
          for (i = 1; i <= NR; i++) {
            if (index(l[i], ign)) continue
            if (!(index(l[i], "0.0.0.0/0") || index(l[i], "::/0"))) continue
            lo = i - 8; if (lo < 1) lo = 1
            hi = i + 8; if (hi > NR) hi = NR
            for (j = lo; j <= hi; j++) {
              if (l[j] ~ /[Pp][Oo][Rr][Tt][^0-9]*(22|3389)([^0-9]|$)/ || l[j] ~ /(^|[^0-9])(22|3389)[ \t]*-[ \t]*(22|3389)([^0-9]|$)/) { print i ":"; break }
            }
          }
        }' "$path" 2>/dev/null)
      [ -n "$open_admin" ] && add_finding "SSH/RDP open to the internet (0.0.0.0/0)" "High" \
        "restrict ingress to known IP ranges or a VPN/bastion, or use a session manager instead of open admin ports." \
        "$open_admin"
      ;;
  esac
fi

[ "$rules_hit" -gt 0 ] || exit 0

plural="issue"
[ "$total" -gt 1 ] && plural="issues"
msg="product-builder security scan: $total possible security $plural in $rel (matched text withheld in case it is a live secret).$report"
[ "$rules_hidden" -gt 0 ] && msg="$msg$NL- +$rules_hidden more rule(s) matched; re-read the file to find them."
msg="$msg${NL}For each item: fix it now, or tell the user in one line why it is a false positive. Rate real findings with the security-engineer severity scale (Critical/High/Medium/Low plus a one-line reason); the suggested level assumes the value is real and reachable. If a secret was real, say it must be rotated, because deleting it does not remove it from git history. Add a 'security-scan: ignore' comment to a line only when the user confirms it is a deliberate fixture or example."

esc=$(printf '%s' "$msg" \
  | tr -d '\000-\011\013-\037' \
  | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' \
  | awk 'NR > 1 { printf "\\n" } { printf "%s", $0 }')
[ -n "$esc" ] || exit 0

printf '{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"%s"}}\n' "$esc"
exit 0
