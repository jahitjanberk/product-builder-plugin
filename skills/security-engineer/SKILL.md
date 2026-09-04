---
name: security-engineer
description: Apply this skill any time a database schema, data model, storage design, API, auth flow, IAM/access policy, or piece of infrastructure is being written, reviewed, or planned — including inside a larger feature request where security isn't the stated topic, such as "add a transactions table," "store this in IndexedDB/localStorage," "set up login," or "add an S3 bucket." Also trigger on explicit security questions. Don't wait to be asked — proactively flag hardcoded secrets, unencrypted storage of sensitive data (financial, health, credential, or personal data), overly broad permissions, missing input validation, or other security gaps the moment they appear, and state the hardened alternative.
---

# Security Engineer

A continuous lens applied across every other skill's output, not a separate review step invoked only when asked. If code, infrastructure, or an access decision is being produced anywhere in the conversation, this skill's checks run alongside it.

## How to use this skill

1. Treat this as always-on: when the `developer` or `product-management` skills produce an artifact (code, architecture, IAM policy, deployment plan), pass it through the checks below before considering the task done.
2. Flag issues as they're found, plainly and without alarmism — name the risk, its severity, and the concrete fix, not just "this is insecure."
3. When the human is about to make a decision that overlooks a security principle (e.g. a wildcard permission "just for now," a secret pasted into a config file), say so before proceeding, and offer the hardened alternative that doesn't meaningfully slow them down.
4. Calibrate severity honestly — not everything is critical; reserve strong warnings for issues with real exploitability or data-exposure impact, so the warnings that matter don't get lost in noise.

## The CIA Triad as the core lens

Apply this quick check to any artifact under review:

- **Confidentiality** — could this leak data to someone who shouldn't see it? (overly broad access, unencrypted data at rest/in transit, verbose error messages exposing internals, secrets in logs)
- **Integrity** — could this be tampered with in a way that isn't detected? (missing input validation, no signature/checksum verification, mutable audit logs, unauthenticated write paths)
- **Availability** — could this be taken down or degraded easily? (no rate limiting, single points of failure, unbounded resource consumption, no backup/recovery plan)

Any artifact that fails one of these silently is a finding, even if nothing was technically "broken."

## NIST CSF mapped to the development lifecycle

Use the five NIST Cybersecurity Framework functions as a stage-by-stage checklist rather than an end-of-project audit:

| Lifecycle stage | NIST function | Concrete practice |
|---|---|---|
| Design / architecture | **Identify** | Inventory what data and assets exist, classify sensitivity, threat-model the design (what could an attacker do here, and what would it cost them?) |
| Build / implementation | **Protect** | Secure coding practices, least-privilege IAM, encryption in transit and at rest, secrets management, dependency vetting |
| CI/CD and runtime | **Detect** | Logging of security-relevant events, dependency/vulnerability scanning in the pipeline, monitoring and alerting on anomalies |
| Incident handling | **Respond** | A documented, even if lightweight, incident playbook — who's notified, what's the first containment step, before an incident happens |
| Post-incident / resilience | **Recover** | Backups that are actually tested for restore, a rollback path, a post-incident review that feeds back into Identify |

Security work concentrated only in "Protect" (write secure code) while skipping Identify (threat model) and Detect (monitoring) leaves the two ends of the lifecycle uncovered — flag this pattern when a plan only mentions secure coding.

## IAM and least privilege

- **Least privilege by default**: every role/policy starts from zero access and adds only what's needed, never starts broad and narrows later. A wildcard resource or action (`*:*`, `s3:*` on all buckets) is a finding unless there's a stated reason it's genuinely needed.
- **Role-based, not person-based**: access is granted to roles tied to function, not accumulated permissions on individual accounts — this is what makes offboarding and audits tractable.
- **Short-lived over static**: prefer temporary/rotating credentials (assumed roles, short-lived tokens) over long-lived static API keys wherever the platform supports it.
- **MFA on anything privileged**: any account with write access to production, billing, or IAM itself should require MFA, not just a password.
- **Secrets management, not secrets storage**: credentials come from a secrets manager or vault with access logging, never from a config file, environment file committed to git, or a value pasted directly into code or chat.

## Secure coding checklist

- **Input validation** at every trust boundary — validate type, range, and format before use, not just at the outermost layer.
- **Parameterized queries**, never string-concatenated SQL or command construction from user input.
- **Output encoding** matched to context (HTML, URL, shell) to prevent injection into the next system that consumes the output.
- **Dependency hygiene**: pin versions, run automated vulnerability scanning in CI, and don't add a dependency for something a few lines of code would do without one.
- **Secure defaults**: new features should default to the more restrictive/private setting, requiring explicit action to loosen — not the reverse.
- **No security through obscurity as the only control**: hiding an endpoint or field name is not a substitute for actual authorization checks on it.

## Red flags to surface proactively, with fixes

| Finding | Why it matters | Fix |
|---|---|---|
| Hardcoded API key or credential in code | Confidentiality — leaks on any code exposure, including a public repo or a screenshot | Move to a secrets manager, rotate the exposed credential |
| Wildcard IAM permission (`*`) | Confidentiality/Integrity — one compromised credential gets broad blast radius | Scope to the specific resources and actions actually needed |
| No rate limiting on a public endpoint | Availability — trivially exhausted by one client | Add rate limiting/throttling at the gateway or app layer |
| Data stored unencrypted at rest | Confidentiality — a storage-layer breach exposes plaintext | Enable encryption at rest (most managed datastores make this a config flag) |
| Verbose error messages exposing stack traces/internals to users | Confidentiality — reveals architecture detail useful to an attacker | Return generic errors externally, log full detail server-side only |
| No MFA on an account with production or IAM access | Confidentiality/Integrity — a leaked password alone grants full access | Enforce MFA for any privileged role |
| Overly permissive CORS (`*` origin with credentials) | Confidentiality — allows any site to make authenticated requests on a user's behalf | Restrict to known origins explicitly |
| No backup/restore ever tested | Availability — a backup that can't be restored isn't a backup | Test a full restore on a schedule, not just confirm the backup job ran |
