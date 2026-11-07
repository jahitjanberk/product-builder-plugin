# Threat model: <system or feature name>

<!--
Save to docs/security/threat-model.md in the user's project, or follow the project's own docs convention.
Keep this proportionate. A small feature can fill in only the rows that apply.
Rate every threat with the severity scale in the security-engineer skill.
-->

- **Owner:** <name, accountable for accepting residual risk>
- **Last updated:** <YYYY-MM-DD>
- **Links:** PRD `docs/product/prd.md` · Tech spec `docs/tech/spec.md` · Design brief `docs/design/brief.md`

## 1. Scope

- **In scope:** <components, flows, environments covered>
- **Out of scope:** <what this model deliberately doesn't cover, and why>

## 2. Assets and data classification

<!-- Take the data list from the PRD. Each sensitive class needs an encryption, retention, and deletion answer. -->

| Asset / data | Classification (Public / Internal / Personal / Sensitive — see the security-engineer skill) | Where stored | Encrypted at rest | Retention | Deletion path |
|---|---|---|---|---|---|
| <e.g. user email> | personal | <Postgres `users`> | <yes, provider-managed> | <life of account + 30 days> | <account deletion job> |

## 3. Trust boundaries and data flow

<!-- List every point where data crosses from less trusted to more trusted. A short list or a diagram link is enough. -->

1. <Browser → API (public internet, unauthenticated until login)>
2. <API → database (private network)>
3. <API → third-party service X (outbound; their response is untrusted)>
4. <Retrieved documents → model context (untrusted content; see llm-security.md)>

## 4. STRIDE per component

<!-- One table per component that sits on a trust boundary. Delete rows that genuinely don't apply, and say why in the Notes column for any that are non-obvious. -->

### Component: <name>

| STRIDE | Threat | Severity | Mitigation | Owner | Status |
|---|---|---|---|---|---|
| **S**poofing | <attacker reuses a stolen session token> | <High: …> | <short expiry, rotation on login, revocation on password change> | <name> | <open / in progress / done / accepted> |
| **T**ampering | <client edits `price` in the checkout request> | | <server-side price lookup; allowlisted request binding> | | |
| **R**epudiation | <admin denies changing a user's role> | | <append-only audit log of admin actions> | | |
| **I**nformation disclosure | <user A reads user B's invoice by ID> | | <ownership check in the query; regression test> | | |
| **D**enial of service | <unbounded export endpoint> | | <pagination cap; rate limit; async job> | | |
| **E**levation of privilege | <mass assignment of `role` on profile update> | | <allowlisted fields; role changes via admin-only route> | | |

## 5. Mitigations → developer tasks

<!-- Each mitigation that isn't done yet becomes a tracked task. -->

| Task | Linked threat | Severity | Owner | Due |
|---|---|---|---|---|
| <Add ownership check to `GET /invoices/:id`> | <Component X / I> | <High> | <name> | <date> |

## 6. Accepted risks

<!-- A risk only counts as accepted when a named person signs off, with a review date. -->

| Risk | Severity | Why accepted | Accepted by | Review by |
|---|---|---|---|---|
| | | | | |

## 7. Launch blockers

<!-- Copy every open Critical or High finding here, and into the Security section of docs/launch-checklist.md. -->

- [ ] <None, or: "High: … (task link)">
