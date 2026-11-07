# OWASP checklist

Load this for a full security review or audit, or when the user asks for OWASP or ASVS coverage. It maps each OWASP category to checks you can verify in the code, so a review records "checked X, found Y" rather than just naming the category.

Editions used (verified November 2026):
- **OWASP Top 10:2025** for web applications
- **OWASP API Security Top 10:2023** for APIs
- **OWASP ASVS 5.0.0** (May 2025) as the verification standard when the user needs depth or a compliance-style audit

Re-check the editions before citing them in a formal report, because OWASP revises these lists every few years.

Rate every finding with the severity scale in `SKILL.md`.

## OWASP Top 10:2025 (web applications)

| ID | Category | Check in the code |
|---|---|---|
| A01:2025 | Broken Access Control | Every object read/write scoped to the caller (no IDOR); deny-by-default routing; role checks server-side on admin functions; no path traversal in file access (`../`); CORS restricted to known origins; **SSRF** (now part of this category): user-supplied URLs allowlisted, private/metadata IP ranges blocked, re-checked after redirects |
| A02:2025 | Security Misconfiguration | No default credentials; debug mode and stack traces off in production; unused features, ports, and sample apps removed; security headers present; cloud storage not publicly readable; XML parsers have external entities disabled; same hardening in every environment |
| A03:2025 | Software Supply Chain Failures | Lockfiles committed; dependencies pinned and scanned in CI (e.g. `npm audit`, `pip-audit`, Dependabot/Renovate); CI actions pinned by commit SHA; CI tokens least-privilege; new packages checked for typosquatting, maintenance, and install scripts; SBOM generated for shipped artifacts where customers ask for it |
| A04:2025 | Cryptographic Failures | TLS everywhere with HSTS; sensitive data encrypted at rest; no home-made crypto; modern AEAD ciphers (AES-GCM, ChaCha20-Poly1305); passwords hashed with argon2id/bcrypt; tokens from a CSPRNG; keys in a KMS or secrets manager, rotated, never in code |
| A05:2025 | Injection | Parameterized queries or ORM for SQL; NoSQL operators not accepted from raw input; shell commands built as argument arrays, never strings; template auto-escaping on; no raw-HTML sinks with untrusted data (XSS); no server-side template rendering of user input; LLM prompt injection handled per `llm-security.md` |
| A06:2025 | Insecure Design | Threat model exists for features crossing a trust boundary; business-logic limits on sensitive flows (signup, checkout, password reset, invites); tenant isolation designed into the data model; secure defaults |
| A07:2025 | Authentication Failures | Managed auth or a vetted library; argon2id; rate limiting and credential-stuffing protection on login; MFA available, required for privileged roles; session rotation, expiry, revocation; no account enumeration; reset tokens single-use and short-lived |
| A08:2025 | Software or Data Integrity Failures | Webhooks verify signatures and timestamps; no unsafe deserialization of untrusted data (Python `pickle`, Java native serialization, unsafe YAML loaders); third-party scripts from CDNs use Subresource Integrity; release artifacts built in CI, not on laptops; auto-update channels signed |
| A09:2025 | Security Logging & Alerting Failures | Logs record logins (success and failure), authorization failures, admin actions, and permission changes, with user ID, timestamp, and request ID; logs are append-only or shipped off-host; alerts fire on anomalies (spike in auth failures, privilege grants); no secrets or PII in logs |
| A10:2025 | Mishandling of Exceptional Conditions | Security checks fail closed on error or timeout; no stack traces or internal errors returned to users; partial failures roll back (transactions); resources released on error paths; no swallowed exceptions around auth, payment, or validation; unhandled promise rejections and panics are caught at the boundary and logged |

## OWASP API Security Top 10:2023

| ID | Category | Check in the code |
|---|---|---|
| API1:2023 | Broken Object Level Authorization | Each endpoint that takes an object ID verifies the caller owns it or has access to it, in the data-access layer; tests include "user A requests user B's object → 403/404" |
| API2:2023 | Broken Authentication | Token validation on every request (signature, `exp`, `aud`, `iss`); no API keys in URLs; login and token endpoints rate-limited |
| API3:2023 | Broken Object Property Level Authorization | Request bodies bound through an allowlist (no mass assignment of `role`, `owner_id`, `price`); responses serialized through an allowlist (no leaking internal or other users' fields) |
| API4:2023 | Unrestricted Resource Consumption | Pagination with a maximum page size; request size limits; timeouts; rate limits per user and per IP; limits on costly operations (exports, AI calls, SMS/email sends) |
| API5:2023 | Broken Function Level Authorization | Admin/internal routes check role server-side; no reliance on the route being "hidden"; HTTP method checks (a `GET`-only role can't `DELETE`) |
| API6:2023 | Unrestricted Access to Sensitive Business Flows | Abuse-prone flows (purchases, signups, referrals, reservations) have bot/velocity limits, not just per-request auth |
| API7:2023 | Server Side Request Forgery | Same SSRF controls as A01 above |
| API8:2023 | Security Misconfiguration | CORS, headers, verbose errors, unnecessary HTTP methods, TLS settings |
| API9:2023 | Improper Inventory Management | Every deployed API version and environment is listed; old versions and staging hosts are retired or protected as strictly as production |
| API10:2023 | Unsafe Consumption of APIs | Responses from third-party APIs are validated like user input; timeouts and size limits on outbound calls; TLS verified; redirects not followed blindly |

## Using ASVS 5.0

ASVS is a requirements catalogue, not a top-N list. Use it when:
- the user needs an audit trail,
- a customer's security questionnaire asks for it, or
- the product handles high-value data.

| Level | Use for |
|---|---|
| **L1** | The baseline every internet-facing app should meet |
| **L2** | The sensible target for most apps that handle personal, financial, or business-sensitive data |
| **L3** | High-value targets (critical infrastructure, large-scale financial or health data), where the full requirement set applies |

For a normal review, the Top 10 tables above are enough. Reach for ASVS when the question is "prove it's covered," not "find what's wrong." When you do use it, cite requirement IDs from the official ASVS 5.0 document rather than paraphrasing from memory.

## Review record format

For each area above, write one of:
- **Finding**: severity, then `file:line`, the issue, an exploit scenario in one sentence, and the fix.
- **Checked, fine**: one line saying what was verified.
- **Not applicable**: one line saying why (e.g. "no file uploads in this change").

A silent area reads the same whether it was checked or skipped, so every area gets a line.
