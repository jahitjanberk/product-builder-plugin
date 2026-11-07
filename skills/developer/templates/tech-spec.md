# Tech spec: <product or feature name>

> **Status:** Draft | In review | Approved · **Author:** <name> · **Reviewers:** <names> · **Last updated:** <YYYY-MM-DD>
> **Related:** [PRD](../product/prd.md) · [Design brief](../design/brief.md) · [Threat model](../security/threat-model.md) · [ADRs](adr/) · [Launch checklist](../launch-checklist.md)

<!--
This spec covers HOW. The PRD covers what and why. Link to it rather than copying it.
security-engineer reads sections 2–5 to build the threat model, so make trust boundaries and data sensitivity explicit.
Mark unconfirmed choices as **(assumption)**. Delete these comments once filled.
-->

## 1. Context

- **Goal (one or two lines, linking the PRD):**
- **Constraints:** <fixed stack or infrastructure, deadline, expected scale, budget, compliance>
- **Out of scope:** <PRD non-goals, plus technical non-goals>

## 2. Architecture

| Component | Responsibility | Technology | Owner |
|---|---|---|---|
| | | | |

**Main data flow** (number the steps for the primary user journey, and mark each trust boundary where untrusted input enters):

1. <client> → <API> : <what is sent> **[trust boundary: user input]**
2. <API> → <service/DB> : …
3. …

<!-- Optional: a Mermaid diagram of the same flow. -->

## 3. Data model

| Entity | Key fields | Sensitivity | Encrypted at rest? | Who can read / write (scoped at the query layer) | Retention / deletion |
|---|---|---|---|---|---|
| | | | | | |

<!-- Sensitivity uses security-engineer's data classification (Public / Internal / Personal / Sensitive) and comes from the PRD's data section. Any field holding financial, health, credential, or government-ID data must say how it's protected. -->

**Migrations:** <expand → migrate → contract plan, so the previous app version can run against the new schema>

## 4. API surface

| Method + path (or operation) | Purpose | Who may call it (authz rule) | Request (key fields) | Response | Idempotent? | Paginated? |
|---|---|---|---|---|---|---|
| | | | | | | |

- **Error format:** <e.g. RFC 9457 Problem Details>
- **Versioning:** <strategy>
- **Rate limits:** <per user / per IP / per tenant>
- **Outbound calls and their timeouts:** <dependency: timeout, retry policy>

## 5. Infrastructure and environments

| Environment | Purpose | Hosting | Datastore | Secrets source | Who has access |
|---|---|---|---|---|---|
| dev | | | | | |
| staging | | | | | |
| production | | | | | |

- **Infrastructure as code location:** <path / tool>
- **CI/CD pipeline:** lint → tests → build → secret scan → SAST + dependency scan → staging → smoke/e2e → production → post-deploy smoke

## 6. Testing plan

| PRD story / acceptance criterion | Test type (unit / integration / e2e) | Test name or location |
|---|---|---|
| Story 1, criterion 1 | | |
| Story 1, criterion 2 (failure case) | | |
| Threat-model mitigation: <e.g. user A can't read user B's data> | integration | |

**Non-functional checks:** <load/performance test, accessibility checks, security scans>

## 7. Observability and metrics

**Analytics events** (from the PRD's metrics table):

| Event name (`object_action`) | Fires when | Properties (no secrets or unneeded PII) | Measures (PRD metric) | Emitted from (server / client) |
|---|---|---|---|---|
| | | | | |

**Alerts:**

| Symptom | Threshold | Who is notified | First action |
|---|---|---|---|
| | | | |

**Logging and tracing:** <structured log fields, request-ID propagation, error tracking setup>

## 8. Performance and cost budgets

- **Latency targets:** <e.g. p95 API < 300ms; web: LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1 at p75>
- **Bundle budget:** <e.g. initial JS ≤ N kB>
- **Cost limits:** <infrastructure cost ceiling; for AI features, max output tokens per call, iteration limits, and per-user rate limits>

## 9. Rollout and rollback

- **Feature flag(s):** <name, default off, cohort plan matching the PRD's launch tier>
- **Rollout steps:** <internal → cohort → everyone>
- **Rollback trigger:** <the PRD's kill criteria, plus technical triggers such as error rate above X%>
- **Rollback steps:** <flag off / redeploy previous version. Confirm no database rollback is needed.>
- **Post-deploy smoke test:** <what gets checked, by whom or what>

## 10. Security tasks

<!-- Filled from docs/security/threat-model.md: one row per mitigation. -->

| Threat-model item | Mitigation task | Test (if testable) | Status |
|---|---|---|---|
| | | | |

## 11. Open questions

| Question | Owner | Needed by |
|---|---|---|
| | | |

## 12. Decisions (ADRs)

| # | Decision | Status | Link |
|---|---|---|---|
| 0001 | | Accepted | [adr/0001-….md](adr/0001-….md) |
