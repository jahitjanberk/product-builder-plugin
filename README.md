<div align="center">

# Product Builder

**A Claude Code plugin that takes a product from idea to launch.** Product management, UI/UX design, development, and security, connected into one process instead of four separate checklists.

[![GitHub stars](https://img.shields.io/github/stars/jahitjanberk/product-builder-plugin?style=social)](https://github.com/jahitjanberk/product-builder-plugin/stargazers) [![license](https://img.shields.io/github/license/jahitjanberk/product-builder-plugin)](LICENSE) [![version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Fjahitjanberk%2Fproduct-builder-plugin%2Fmain%2F.claude-plugin%2Fplugin.json&query=%24.version&label=version&color=blue)](.claude-plugin/plugin.json) [![last commit](https://img.shields.io/github/last-commit/jahitjanberk/product-builder-plugin)](https://github.com/jahitjanberk/product-builder-plugin/commits/main) [![skills: 5](https://img.shields.io/static/v1?label=skills&message=5&color=8250DF)](skills/) [![design styles: 6](https://img.shields.io/static/v1?label=design%20styles&message=6&color=BF3989)](skills/ui-ux-design/references/) [![templates: 6](https://img.shields.io/static/v1?label=templates&message=6&color=0E7490)](#how-to-use-it)

[![Claude Code: Install the plugin](https://img.shields.io/static/v1?label=Claude%20Code&message=Install%20the%20plugin&color=B4532F&style=for-the-badge&labelColor=555555&logo=claude&logoColor=white)](#install) [![build-product: orchestrator](https://img.shields.io/static/v1?label=build-product&message=orchestrator&color=1F6FEB&style=for-the-badge&labelColor=555555)](skills/build-product/SKILL.md)

[![product-management: skill](https://img.shields.io/static/v1?label=product-management&message=skill&color=8250DF&style=for-the-badge&labelColor=555555)](skills/product-management/SKILL.md) [![ui-ux-design: skill](https://img.shields.io/static/v1?label=ui-ux-design&message=skill&color=BF3989&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/SKILL.md) [![developer: skill](https://img.shields.io/static/v1?label=developer&message=skill&color=1A7F37&style=for-the-badge&labelColor=555555)](skills/developer/SKILL.md)

[![security-engineer: skill](https://img.shields.io/static/v1?label=security-engineer&message=skill&color=CF222E&style=for-the-badge&labelColor=555555)](skills/security-engineer/SKILL.md) [![security-reviewer: subagent](https://img.shields.io/static/v1?label=security-reviewer&message=subagent&color=BC4C00&style=for-the-badge&labelColor=555555)](agents/security-reviewer.md) [![security scan: hook](https://img.shields.io/static/v1?label=security%20scan&message=hook&color=9A6700&style=for-the-badge&labelColor=555555)](#the-security-scan-hook)

[![Modern SaaS Light: default](https://img.shields.io/static/v1?label=Modern%20SaaS%20Light&message=default&color=4F46E5&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/modern-saas-light.md) [![Soft Minimal Dashboard: ops tools](https://img.shields.io/static/v1?label=Soft%20Minimal%20Dashboard&message=ops%20tools&color=2563EB&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/soft-minimal-dashboard.md) [![Bold Flat Blocks: bold brands](https://img.shields.io/static/v1?label=Bold%20Flat%20Blocks&message=bold%20brands&color=C6F24E&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/bold-flat-blocks.md)

[![Swiss Technical: dev tools](https://img.shields.io/static/v1?label=Swiss%20Technical&message=dev%20tools&color=2E4BFF&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/swiss-technical.md) [![Ambient Gradient: AI & fintech](https://img.shields.io/static/v1?label=Ambient%20Gradient&message=AI%20%26%20fintech&color=DB2777&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/ambient-gradient.md) [![Moody Editorial: wellness](https://img.shields.io/static/v1?label=Moody%20Editorial&message=wellness&color=EBC08A&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/references/moody-editorial.md)

[![Define: PRD](https://img.shields.io/static/v1?label=Define&message=PRD&color=0E7490&style=for-the-badge&labelColor=555555)](skills/product-management/templates/prd.md) [![Design: brief](https://img.shields.io/static/v1?label=Design&message=brief&color=0E7490&style=for-the-badge&labelColor=555555)](skills/ui-ux-design/templates/design-brief.md) [![Plan: tech spec](https://img.shields.io/static/v1?label=Plan&message=tech%20spec&color=0E7490&style=for-the-badge&labelColor=555555)](skills/developer/templates/tech-spec.md)

[![Plan: ADR](https://img.shields.io/static/v1?label=Plan&message=ADR&color=0E7490&style=for-the-badge&labelColor=555555)](skills/developer/templates/adr.md) [![Secure: threat model](https://img.shields.io/static/v1?label=Secure&message=threat%20model&color=0E7490&style=for-the-badge&labelColor=555555)](skills/security-engineer/templates/threat-model.md) [![Launch: checklist](https://img.shields.io/static/v1?label=Launch&message=checklist&color=0E7490&style=for-the-badge&labelColor=555555)](skills/build-product/templates/launch-checklist.md)

[![Download: everything (zip)](https://img.shields.io/static/v1?label=Download&message=everything%20%28zip%29&color=24292F&style=for-the-badge&labelColor=555555&logo=github&logoColor=white)](https://github.com/jahitjanberk/product-builder-plugin/archive/refs/heads/main.zip) [![Run locally: claude --plugin-dir](https://img.shields.io/static/v1?label=Run%20locally&message=claude%20--plugin-dir&color=1F883D&style=for-the-badge&labelColor=555555)](#developing-the-plugin) [![Evals: trigger tests](https://img.shields.io/static/v1?label=Evals&message=trigger%20tests&color=6E7781&style=for-the-badge&labelColor=555555)](evals/)

[How to use it](#how-to-use-it) · [Security scan hook](#the-security-scan-hook) · [Developing](#developing-the-plugin) · [Upgrading from 1.x](#upgrading-from-1x) · [License](LICENSE)

</div>

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="assets/screenshots/styles-overview-dark.png">
  <img src="assets/screenshots/styles-overview.png" alt="The same landlord repair-requests screen in six visual styles: Modern SaaS Light, Soft Minimal Dashboard, Bold Flat Blocks, Swiss Technical, Ambient Gradient, and Moody Editorial">
</picture>

*One repair-requests screen in each of the six `ui-ux-design` styles, built from the tokens in [`skills/ui-ux-design/references/`](skills/ui-ux-design/references/). Each style also has a light and a dark version, in [`assets/screenshots/styles/`](assets/screenshots/styles/).*

## Install

```text
/plugin marketplace add jahitjanberk/product-builder-plugin
/plugin install product-builder@jahit-plugins
```

Restart Claude Code (or run `/reload-plugins`) after installing.

## What's inside

| Component | Type | What it does |
|---|---|---|
| `build-product` | Skill (orchestrator) | Runs a build in phases: define → design → plan → secure → build → launch. Picks a lean or full track, writes one artifact per phase, and checks each phase's gate before moving on. |
| `product-management` | Skill | Goals and North Star, JTBD audience, market sizing, pricing, stakeholders, KPIs, PRDs with acceptance criteria, prioritization (RICE / MoSCoW / Kano), customer interviews, experiments, go-to-market |
| `ui-ux-design` | Skill | Six fully specified visual styles with light and dark tokens, accessibility (WCAG 2.2 AA), UI states and forms, dark mode, and design-to-code token handoff |
| `developer` | Skill | Stack selection with dated defaults, codebase structure, testing strategy, API design, observability, performance, deployment, AI-feature implementation, tech specs and ADRs |
| `security-engineer` | Skill | Severity scale, CIA triad, NIST CSF 2.0, OWASP Top 10 / API Top 10 / ASVS, auth and sessions, authorization (IDOR/BOLA), privacy, LLM/AI security, STRIDE threat modeling |
| `security-reviewer` | Subagent | Read-only security review of a diff or set of files, run in a fresh context so the reviewer isn't the one who wrote the code |
| Security scan | `PostToolUse` hook | After every `Write`/`Edit`, scans the file for hardcoded secrets and risky config and tells Claude what to fix |

## How to use it

**Start a build:**

```text
/product-builder:build-product I want to build an app that helps landlords track repair requests
```

![build-product picks the full track because the app stores tenant personal data, shows a phase status table, and asks its first questions, each with a suggested default](assets/screenshots/build-kickoff.png)

*Screenshots in this README show real output from the plugin in a simplified terminal frame. Cuts are marked ⋯.*

It works out which phases the request needs and writes artifacts into your project:

| Phase | Artifact | Gate before moving on |
|---|---|---|
| Define | `docs/product/prd.md` | Audience, metrics, stories with acceptance criteria, data-sensitivity list |
| Design | `docs/design/brief.md` + tokens | Style chosen for the audience, every screen's states, accessibility requirements |
| Plan | `docs/tech/spec.md` + `docs/tech/adr/` | Stack, classified data model, API, test plan, analytics events, rollback |
| Secure | `docs/security/threat-model.md` | STRIDE over every trust boundary, every threat mitigated or owned |
| Build | Code + tests | Tests pass, hook findings resolved, security review clean of Critical/High |
| Launch | `docs/launch-checklist.md` | Every item checked or waived with an owner; go/no-go recorded |

Small projects (prototypes, no real user data) get a **lean track**: one `docs/build-plan.md` with a short section per phase. Anything handling real personal or financial data gets the full Secure phase regardless of size. You can skip any gate; the skip is recorded so it stays visible. Ask *"where are we?"* at any point for a status table.

<details>
<summary>Screenshots: a generated PRD, a skipped gate, and "where are we?"</summary>

![Excerpt of the generated docs/product/prd.md: user stories with Given/When/Then acceptance criteria and a data-sensitivity table](assets/screenshots/artifact-prd.png)

![Asked to skip the spec and threat model, build-product allows the skip, records it, and says a threat model or a written risk acceptance is still due before real tenants use the app](assets/screenshots/build-skip-gate.png)

![In a new session, "where are we?" rebuilds the phase status table from the artifacts on disk](assets/screenshots/build-status.png)

</details>

**Use a single skill directly.** You don't need the orchestrator for one-off work. The skills load automatically from what you ask ("price this," "design this screen," "review this schema"), or you can call one by name, e.g. `/product-builder:ui-ux-design`.

**Run a security review** of your current changes:

```text
@agent-product-builder:security-reviewer review my current branch before I merge
```

![The security-reviewer subagent reports a SQL injection and a missing ownership check (IDOR) as Critical, with file, line, and fix for each](assets/screenshots/security-review.png)

## The security scan hook

After Claude writes or edits a file, `hooks/scripts/security-scan.sh` scans it and passes any findings back to Claude so it fixes them right away.

![After an edit that hardcodes a database password, the hook reports the rule and line number and a suggested High severity, without repeating the password](assets/screenshots/hook-security-scan.png)

- **Every text file, docs included:**
  - private keys
  - AWS, GitHub, Slack, Stripe live, Anthropic, OpenAI, and Google keys/tokens
  - hardcoded JWTs
  - `password` / `secret` / `api_key` assignments to literal values
- **Code and config files only:**
  - wildcard IAM actions/resources
  - wildcard CORS origins
  - disabled TLS verification
  - SQL or shell commands built from strings
  - `eval`/`exec` on request data
  - public bucket/object ACLs

Each finding includes a suggested severity on the security-engineer scale.

How it behaves:

- It reports the rule and line number only. It never echoes the matched secret back into the conversation.
- Add `security-scan: ignore` on a line to suppress a known false positive, e.g. a test fixture.
- It skips binaries, lockfiles, minified files, files over 1 MB, and `node_modules` / `vendor` / `dist` / `build`.
- It never blocks or fails a tool call. If it can't run, it stays silent.
- It only sees files changed through Claude's `Write`/`Edit` tools; files changed by shell commands aren't scanned.
- **Requires `bash`.** Built in on macOS and Linux. On Windows it uses Git Bash, which Claude Code picks up automatically when it's installed. Without Git Bash the hook errors harmlessly and never blocks anything.
- `hooks/.gitattributes` keeps the script's line endings LF, so a Windows clone with `autocrlf` doesn't break it.

The hook is a fast pattern scan, not a full review. For depth, use the `security-reviewer` subagent.

## Developing the plugin

Load your working copy for one session, without installing:

```bash
claude --plugin-dir /path/to/product-builder-plugin
```

Edit any `SKILL.md`, then run `/reload-plugins` to pick up the change.

Validate the manifests, skills, and agents:

```bash
claude plugin validate .
```

**Trigger tests** live in [`evals/`](evals/). Each case checks that a prompt loads the right skill, and that unrelated prompts load none. Run them after changing any skill description, because descriptions decide which skill fires:

```bash
claude plugin eval . --ablation none --runs 1      # quick check, plugin arm only
claude plugin eval . --tag trigger                 # full run: 3 runs per case + no-plugin baseline
```

Each run is a real Claude session billed to your account. A full suite is several dozen sessions, so use `--runs 1` while iterating.

New skills go in `skills/<name>/SKILL.md` and are discovered automatically. Add a trigger eval for each one.

## Upgrading from 1.x

- `mobile-web-design` was renamed to **`ui-ux-design`**. Update any `/product-builder:mobile-web-design` invocations. It was renamed because an identical standalone `mobile-web-design` skill exists; with both installed, two skills with the same description competed for every design request. If you have that standalone copy installed, consider removing it.
- New: the `build-product` orchestrator, the security scan hook, the `security-reviewer` subagent, and templates for the PRD, design brief, tech spec, ADR, threat model, and launch checklist.

## License

MIT. See [LICENSE](LICENSE).
