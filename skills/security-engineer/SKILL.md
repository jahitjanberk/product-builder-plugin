---
name: security-engineer
description: Apply this skill any time a database schema, data model, storage design, API, login/session/auth flow, authorization rule, IAM/access policy, file upload, server-side fetch, piece of infrastructure, or AI/LLM feature (prompts, tool use, agents, RAG) is being written, reviewed, or planned — including inside a larger feature request where security isn't the stated topic, such as "add a transactions table," "store this in localStorage," "set up login," "add an S3 bucket," or "let the agent call this API." Also trigger on explicit security, privacy, OWASP, threat-modeling, or prompt-injection questions. Don't wait to be asked — proactively flag hardcoded secrets, unencrypted sensitive data, missing object-level authorization (IDOR/BOLA), overly broad permissions, missing input validation, PII in logs, or untrusted content treated as model instructions the moment they appear, rate each with the severity scale, and state the hardened alternative.
---

# Security Engineer

A security lens applied across every other skill's output, not a separate review step invoked only when asked. Two parts of this plugin make that real: a **PostToolUse hook** that is always on and scans every file Claude writes or edits for secrets and risky config, and **this skill**, which loads whenever the work touches code, data, access, infrastructure, or AI features. For a review with fresh eyes, there is also the **`product-builder:security-reviewer` subagent**.

## How to use this skill

1. When the `developer`, `ui-ux-design`, or `product-management` skills produce an artifact (code, schema, IAM policy, deployment plan, prompt/tool design), pass it through the checks below before calling the task done.
2. Rate every finding with the **severity scale** below plus a one-line reason for that level, name the concrete fix, and skip the alarmism.
3. When the human is about to make a decision that overlooks a security principle (a wildcard permission "just for now," a secret pasted into a config file), say so before proceeding and offer the hardened alternative that doesn't meaningfully slow them down.
4. **Hook messages are findings, not noise.** When a `product-builder security scan` note appears after a Write or Edit, address every item: fix it, or say in one line why it's a false positive. Only add a `security-scan: ignore` comment to the line when the user agrees it's deliberate (a test fixture, a documented example). Never carry on silently.
5. **Don't self-review a finished change in the same context that wrote it.** Before merging or launching a non-trivial change, delegate to the `product-builder:security-reviewer` subagent. The author's context carries the author's blind spots.
6. Load references when they apply:
   - `references/owasp-checklist.md` for a full review or audit, or when the user asks for OWASP/ASVS coverage.
   - `references/llm-security.md` whenever the change calls a model, builds a prompt, gives a model tools, or retrieves documents into context.
   - `templates/threat-model.md` at design time for a new system, or for any feature that adds a trust boundary.

## Severity scale

This is the shared scale. The other skills, the hook, and the security-reviewer subagent all use it.

| Level | Meaning | Examples | Action |
|---|---|---|---|
| **Critical** | Exploitable now by an unauthenticated user or any logged-in user, with direct impact on sensitive data, money, or account takeover | Live secret in the repo; SQL injection on a public endpoint; any user can read other users' records | Blocks merge and launch; fix first |
| **High** | Exploitable with modest effort or a precondition that's commonly met | IDOR with guessable IDs; stored XSS; wildcard IAM on a production role; unauthenticated internal admin route | Fix before launch |
| **Medium** | Needs an unusual precondition, or the impact is limited | No rate limit on a low-value endpoint; verbose error messages; missing security headers | Backlog with a date |
| **Low** | Defense-in-depth or hygiene, no direct exploit path | Missing `Referrer-Policy`; an outdated but unexploitable dependency | Fix opportunistically |

Always state the level with the reason, e.g. "High: any logged-in user can read other users' invoices by changing the ID in the URL." A bare label isn't enough. Calibrate honestly: inflated severity teaches people to ignore warnings, and then the Critical one gets lost.

## Data classification

This is the shared scale for the PRD's data table, the tech spec's data model, and the threat model's asset inventory. Classify every stored item; when in doubt, pick the higher class.

| Class | What it covers | Minimum handling |
|---|---|---|
| **Public** | Meant to be published: marketing copy, public profiles the user chose to make public | Integrity only (no unauthorized edits) |
| **Internal** | Not personal, but not for outsiders: business metrics, internal configs, non-secret operational data | Authenticated access, no public listing |
| **Personal** | Identifies or relates to a person: name, email, IP address, device IDs, usage history | Scoped to its owner at the query layer; in the retention and deletion/export path; kept out of logs and analytics |
| **Sensitive** | Harm if exposed: credentials and tokens, financial and payment data, health data, government IDs, precise location, children's data, private messages | Everything for Personal, plus encryption at rest, access logging, and a named owner. Credentials are stored only as hashes, or held in a secrets manager. |

Financial, health, credential, and government-ID data are always **Sensitive**, whatever the product's size or stage.

## Inputs and handoffs

**Reads:**
- **PRD** (`docs/product/prd.md`): the data-collected list and its sensitivity classification. If there's no PRD, classify the data yourself from the schema or feature and state the classification in one line.
- **Tech spec** (`docs/tech/spec.md`): the data model, API surface, infrastructure, and third-party services. If it's absent, read the code and config directly.
- **Design brief** (`docs/design/brief.md`): screens that collect credentials, payment details, or PII. These need the auth, privacy, and input-validation checks below.

**Hands off:**
- **Threat model** (`docs/security/threat-model.md`). Each mitigation becomes a developer task with an owner. Small changes don't need the file: state the threats and mitigations in chat.
- **Launch blockers.** Every open Critical or High finding goes in the Security section of `docs/launch-checklist.md`. A launch with an open Critical or High finding needs a named person to accept the risk explicitly.

## The CIA Triad as the core lens

Apply this quick check to any artifact under review:

- **Confidentiality**: could this leak data to someone who shouldn't see it? (overly broad access, unencrypted data at rest or in transit, verbose error messages exposing internals, secrets in logs)
- **Integrity**: could this be tampered with in a way that isn't detected? (missing input validation, no signature or checksum verification, mutable audit logs, unauthenticated write paths)
- **Availability**: could this be taken down or degraded easily? (no rate limiting, single points of failure, unbounded resource consumption, no backup/recovery plan)

Any artifact that fails one of these silently is a finding, even if nothing was technically "broken."

## NIST CSF 2.0 mapped to the development lifecycle

Use the six functions of the NIST Cybersecurity Framework 2.0 as a stage-by-stage checklist, not an end-of-project audit:

| Lifecycle stage | NIST function | Concrete practice |
|---|---|---|
| Before design, then ongoing | **Govern** | Name an owner for security decisions, state the risk appetite (what's acceptable to ship with), set minimal policy (who approves production access, how secrets are handled), and assess third-party risk: SaaS vendors, dependencies, model providers |
| Design / architecture | **Identify** | Inventory what data and assets exist, classify sensitivity, threat-model the design (see below) |
| Build / implementation | **Protect** | Secure coding, least-privilege IAM, encryption in transit and at rest, secrets management, dependency vetting |
| CI/CD and runtime | **Detect** | Log security-relevant events, scan dependencies and secrets in the pipeline, monitor and alert on anomalies |
| Incident handling | **Respond** | A documented playbook, even a lightweight one, written before an incident: who's notified, what's the first containment step |
| Post-incident / resilience | **Recover** | Backups that are actually tested by restoring them, a rollback path, and a post-incident review that feeds back into Identify |

Security work concentrated in Protect alone leaves both ends of the lifecycle uncovered: Govern and Identify (no owner, no threat model) at the start, Detect (no monitoring) at the end. Flag that pattern when a plan only mentions secure coding.

## Threat modeling (STRIDE)

Do this at design time for a new system, or for any feature that adds a trust boundary: a new external input, a third-party integration, a new role, or a new store of sensitive data.

1. **Assets**: list the data and capabilities worth protecting, classified by sensitivity.
2. **Trust boundaries**: mark where data crosses from less trusted to more trusted. Examples: browser → API, API → database, your service → third party, retrieved document → model context.
3. **STRIDE each component on a boundary**:
   - **S**poofing (authentication)
   - **T**ampering (integrity)
   - **R**epudiation (audit logging)
   - **I**nformation disclosure (confidentiality)
   - **D**enial of service (availability)
   - **E**levation of privilege (authorization)
4. **Rate and assign**: give each credible threat a severity, a mitigation, an owner, and a status.

Keep it proportionate. A weekend prototype gets five lines in chat, while a system handling payments gets the full `templates/threat-model.md`.

## Authentication and sessions

- **Prefer managed auth** (an identity provider or a well-maintained auth library) over hand-rolled login. Reset flows, MFA, and session handling are where custom auth code most often breaks.
- **Hash passwords with argon2id.** Use bcrypt only where argon2id isn't available. Never MD5/SHA-family or unsalted hashes: fast hashes are cracked at billions of guesses per second once a database leaks.
- **Session cookies:** `HttpOnly`, `Secure`, and `SameSite=Lax` (or `Strict`).
  - Rotate the session ID on login and on any privilege change.
  - Enforce both an idle and an absolute expiry.
  - Revoke sessions server-side on logout and on password change.
- **CSRF:** state-changing requests authenticated by cookie need a CSRF token or an Origin/`Sec-Fetch-Site` check. `SameSite=Lax` is a baseline, not a complete defense.
- **OAuth/OIDC:** use the authorization-code flow with PKCE. Validate `state` (and `nonce` for OIDC), and register exact-match redirect URIs, never wildcards.
- **JWTs:**
  - Pin the algorithm server-side and reject `none` or algorithm switching.
  - Validate `iss`, `aud`, and `exp`.
  - Keep access tokens short-lived (minutes) and rotate refresh tokens.
  - Don't keep session tokens in `localStorage`, because any XSS can read them. Use an HttpOnly cookie instead.
- **Password reset and magic links:** random tokens of at least 128 bits, single-use, expiring within an hour, and invalidated once the password changes.
- **No account enumeration:** login, signup, and reset return the same response, with similar timing, whether or not the account exists.
- **Brute force and MFA:**
  - Rate-limit login attempts and lock out progressively.
  - Offer MFA to everyone and require it for privileged accounts.
  - Prefer passkeys/WebAuthn or TOTP over SMS.

## Authorization

- **BOLA / IDOR is the #1 API vulnerability** (OWASP API1:2023). Every read and write checks that the caller may access *that specific object*. Enforce it in the query (`WHERE id = ? AND owner_id = ?`, or row-level security), not by hiding things in the UI. Unguessable IDs make objects harder to find, but they are not an authorization check.
- **Deny by default.** New routes and resolvers start inaccessible and get access granted explicitly. Put the check in one place (middleware or a policy layer) so a new endpoint can't forget it.
- **Function-level authorization** (API5:2023): admin and internal actions check the caller's role server-side on every request. Hiding the button isn't enough.
- **Property-level authorization** (API3:2023): never mass-assign a request body onto a model, or a user can set `role: "admin"` or `price: 0`. Never return fields the caller shouldn't see. Use explicit allowlists in both directions.
- **Fail closed** (OWASP A10:2025): an exception or timeout inside an auth or authorization check must deny access, not fall through and allow it.

## IAM and least privilege

- **Least privilege by default**: every role or policy starts from zero access and adds only what's needed. It never starts broad and gets narrowed later. A wildcard resource or action (`*:*`, `s3:*` on all buckets) is a finding unless there's a stated reason it's genuinely needed.
- **Role-based, not person-based**: grant access to roles tied to a function, not as permissions accumulated on individual accounts. This is what makes offboarding and audits tractable.
- **Short-lived over static**: prefer temporary or rotating credentials (assumed roles, short-lived tokens) over long-lived static API keys wherever the platform supports it.
- **MFA on anything privileged**: any account with write access to production, billing, or IAM itself should require MFA, not just a password.
- **Secrets management, not secrets storage**: credentials come from a secrets manager or vault with access logging. Never from a config file, an environment file committed to git, or a value pasted directly into code or chat.

## Secure coding checklist

- **Input validation** at every trust boundary: validate type, range, and format before use, not just at the outermost layer.
- **Parameterized queries**: never build SQL or shell commands by concatenating user input. Pass commands as argument arrays, never as a shell string.
- **Output encoding** matched to context (HTML, URL, shell) so injection can't reach the next system that consumes the output. Treat raw-HTML escape hatches (`dangerouslySetInnerHTML`, `v-html`) as findings unless the input is sanitized.
- **SSRF**: when the server fetches a URL the user supplied (webhooks, link previews, imports):
  - Allowlist schemes and destinations.
  - Resolve the hostname and block private, loopback, and link-local ranges, including cloud metadata (`169.254.169.254`).
  - Re-check after every redirect.
- **File uploads**:
  - Validate the type from the file's content (magic bytes), not its extension or `Content-Type`.
  - Cap the size and rename the file on storage.
  - Store it in object storage or outside the web root, and never execute it.
  - Serve user-viewable files from a separate domain.
  - Malware-scan files that other users will download.
- **Security headers**:
  - `Content-Security-Policy`: start strict, with no `unsafe-inline` scripts, and use `frame-ancestors` against clickjacking.
  - `Strict-Transport-Security`
  - `X-Content-Type-Options: nosniff`
  - `Referrer-Policy: strict-origin-when-cross-origin`
- **Dependency hygiene**: commit lockfiles, run automated vulnerability scanning in CI, pin CI actions by commit SHA, and don't add a dependency for something a few lines of code would do.
- **Secure defaults**: new features default to the more restrictive or private setting, and loosening it takes explicit action. Never the reverse.
- **No security through obscurity as the only control**: hiding an endpoint or a field name is not a substitute for real authorization checks on it.

## Privacy and data handling

- **Collect the minimum.** Every field in the PRD's data list needs a purpose. If it has no purpose, don't collect it: data you never stored can't leak.
- **Set a retention period per data class**, plus a job that enforces it. Keeping data "forever" is a decision too, so make it explicitly.
- **Build the deletion and export path early.** Users need to be able to delete their account and data and to export it, and that includes data held by third-party processors. Retrofitting deletion into a schema is expensive.
- **Keep PII and secrets out of logs, analytics, error trackers, and prompts sent to third-party models.** Redact at the logger or SDK level, not by convention, because logs usually have broader access and longer retention than the database.
- **Consent:** non-essential analytics and marketing cookies need opt-in consent in many jurisdictions. Keep essential and optional tracking separate.
- **Flag regulatory triggers, but don't adjudicate them:**
  - EU/UK users: GDPR (lawful basis, processor agreements, breach notification).
  - California residents: CCPA/CPRA.
  - US health data: HIPAA.
  - Card data: PCI DSS (stay out of scope with the payment processor's hosted fields).
  - Children: COPPA or age-appropriate design codes.
  
  Say which one likely applies and recommend confirming with counsel. Don't state legal conclusions.

## AI / LLM features

These checks follow the OWASP Top 10 for LLM Applications (2025). Load `references/llm-security.md` for the full detail and test cases.

- **Retrieved content is data, never instructions** (LLM01 Prompt Injection). Documents, web pages, emails, tool results, and retrieved chunks can all carry instructions, and the model will sometimes follow them. Design so a successful injection can't do damage. Rely on limiting what the model can do, not on the model resisting.
- **Least-privilege tools** (LLM06 Excessive Agency): give the model the narrowest tools and scopes. Run them with the end user's permissions, not a service superuser's. Require human confirmation for destructive, financial, or external-facing actions: sending, deleting, paying, publishing.
- **Model output is untrusted input to the next system** (LLM05 Improper Output Handling). Encode it before rendering, parameterize it before querying, never pass it to a shell or `eval`, and validate structured output against a schema.
- **No secrets or authorization logic in system prompts** (LLM07 System Prompt Leakage). Assume the prompt can be extracted, and enforce access in code.
- **Sensitive data** (LLM02): send the provider only the PII the task needs, check the provider's retention and training terms, and scrub prompts and completions before logging them.
- **Unbounded consumption** (LLM10): set per-user rate limits, a maximum token count per request, and per-tenant spend caps with alerts.
- **RAG access control** (LLM08): filter retrieval by the caller's tenant and permissions at query time. A shared vector index without per-tenant filtering is a cross-tenant data leak.
- **Supply chain** (LLM03): pin model versions, and vet MCP servers and plugins the way you'd vet dependencies (who maintains it, what it can reach). Never load untrusted model weights or pickles.

## Red flags to surface proactively, with fixes

| Finding | Why it matters | Fix |
|---|---|---|
| Hardcoded API key or credential in code | Confidentiality: leaks on any code exposure, including a public repo or a screenshot | Move to a secrets manager and rotate the exposed credential. Deleting it from the code isn't enough, because it stays in git history |
| Object fetched or updated by ID with no ownership check | Confidentiality/Integrity: any user can read or change other users' records (BOLA) | Scope the query by owner or tenant, and centralize the authorization check |
| Wildcard IAM permission (`*`) | Confidentiality/Integrity: one compromised credential has a broad blast radius | Scope to the specific resources and actions actually needed |
| Session token or JWT in `localStorage` | Confidentiality: any XSS steals the session | Use an `HttpOnly` `Secure` cookie |
| No rate limiting on a public endpoint | Availability: one client can exhaust it trivially | Add rate limiting or throttling at the gateway or app layer |
| Data stored unencrypted at rest | Confidentiality: a storage-layer breach exposes plaintext | Enable encryption at rest (most managed datastores make this a config flag) |
| PII, tokens, or full request bodies in logs or analytics | Confidentiality: logs are widely readable and retained long | Redact at the logger, and log allowlisted fields only |
| Verbose error messages exposing stack traces or internals to users | Confidentiality: reveals architecture detail useful to an attacker | Return generic errors externally, and log the full detail server-side only |
| Auth or authorization check that allows access on exception | Integrity: fails open under error or load | Fail closed. Deny on any error in a security check |
| No MFA on an account with production or IAM access | Confidentiality/Integrity: a leaked password alone grants full access | Enforce MFA for every privileged role |
| Overly permissive CORS (`*` origin with credentials) | Confidentiality: lets any site make authenticated requests on a user's behalf | Restrict to known origins explicitly |
| Retrieved or tool content placed in the prompt of a model that has write or send tools | Integrity: indirect prompt injection can trigger real actions | Use least-privilege tools, and require confirmation for consequential actions |
| No backup restore ever tested | Availability: a backup that can't be restored isn't a backup | Test a full restore on a schedule, not just confirm the backup job ran |
