---
name: developer
description: Use this skill when writing, structuring, reviewing, or planning code and its delivery — choosing a tech stack, organizing a codebase, writing a tech spec or architecture decision record (ADR), designing an API, planning a testing strategy, adding logging, monitoring, or analytics instrumentation, fixing performance problems, implementing an AI/LLM feature (model calls, prompts, evals), setting up CI/CD, or deciding how and where to deploy. Trigger for "what stack should I use," "review this code," "how should I structure this project," "design this API," "how should I test this," "why is this slow," "add an AI feature," "set up deployment," or any request to write or restructure production code.
---

# Developer

Standards for building software that's testable, observable, and safe to deploy: choosing a stack for the project's actual constraints, turning requirements into tested code, and shipping it with a way back.

## How to use this skill

1. If the stack isn't already fixed by the project, run the **stack selection framework** and follow its **when to ask vs proceed** logic rather than silently assuming an answer.
2. For a new product or feature, or any change that crosses layers or touches a data model, write the **tech spec** before implementing. Record hard-to-reverse decisions as **ADRs**.
3. While writing or reviewing code, apply the **code principles**, **structure**, **testing strategy**, **API design**, **observability**, and **performance** sections as defaults, not suggestions. Deviate only with a stated reason.
4. Before finalizing any schema, data model, or storage decision, run the **data handling checkpoint**. This applies whether or not a separate security review is happening in the conversation.
5. Before calling anything done, run it against the **deployment checklist**.
6. When reviewing someone else's code or plan, check it against **red flags** even if not explicitly asked.

## Inputs and handoffs

**Reads**
- **PRD** (`docs/product/prd.md`):
  - acceptance criteria → test cases in the testing plan
  - goals and metrics → named analytics events in the observability plan
  - data collected and its sensitivity → the data model's classification column

  If there's no PRD: infer requirements for a small change and state them in one line. For a new product or feature inside a `build-product` run, ask, or hand back to `product-management`, rather than inventing acceptance criteria.
- **Design brief and tokens** (`docs/design/brief.md`, `docs/design/tokens.css` or the project's styling system):
  - implement the tokens as the single source of truth for color, type, spacing, and radius, rather than hardcoding new values
  - implement every state the brief specifies (empty, loading, error, disabled, success)

  If UI is being built with no design input, use `ui-ux-design` instead of improvising a visual system.
- **Threat model** (`docs/security/threat-model.md`): each mitigation becomes a task in the spec, plus a test where it's testable (e.g. "user A cannot read user B's invoice").

**Hands off**
- **Tech spec → `security-engineer`**: the architecture, data model with classification, API surface, and infrastructure are the inputs to the threat model. Write them precisely enough that trust boundaries are visible.
- **Finished change → security review**: before calling a feature done, run the `security-engineer` checks on the diff. The `security-reviewer` subagent does this with fresh context, which catches what the context that wrote the code takes for granted.
- **Deploy plan → launch checklist**: feature flags, migration plan, rollback steps, smoke tests, and alerts go in the Engineering/deploy section of `docs/launch-checklist.md`.

## Tech spec and ADRs

- **Spec before code for anything non-trivial.** Write `docs/tech/spec.md` from `templates/tech-spec.md` for a new product or feature, or any change that crosses layers or alters the data model. A small change inside an existing design doesn't need one; say so and proceed. Reference the PRD instead of copying it. The spec covers *how*, not *what* or *why*.
- **One ADR per decision that's expensive to reverse**: stack, datastore, auth provider, hosting, sync vs. async architecture, a build-vs-buy call. Use `templates/adr.md` and save to `docs/tech/adr/NNNN-slug.md`. Record the alternatives and why they lost. "Why not X?" is the question future contributors actually ask.

## Code principles

Only the defaults that change what gets written:

- **Comments explain *why*, never *what*.** "// retry: the upstream API rate-limits in bursts" earns its place; "// increment counter" doesn't. If code needs a *what* comment, rename or restructure it instead.
- **Fail loudly, not silently.** Raise or return explicit errors rather than swallowing exceptions or returning ambiguous defaults (`null`, `-1`, empty list) that move the failure somewhere harder to debug.
- **Abstract on the third repetition, not the second.** Duplication that will diverge is cheaper than the wrong abstraction. Don't generalize for a second use case that doesn't exist yet.
- **Set up the formatter and linter in CI at project start**, before the first feature. Retrofitting style rules onto an existing codebase produces giant diffs nobody reviews, and manual style enforcement turns code review into spacing debates.

## Structuring a codebase

- **Separate layers**: presentation (UI/API surface), business logic (rules, orchestration), and data access (persistence, external calls) shouldn't be tangled in one file. This is what makes a codebase testable without spinning up a database or a browser.
- **Config lives outside code.** Environment-specific values (URLs, keys, feature flags) come from environment variables or a config service, never hardcoded. This is also a security requirement, not just a style preference.
- **A new contributor should find the entry point in under a minute.** A consistent, documented top-level structure (e.g. `src/`, `tests/`, `infra/`, `docs/`) does more for maintainability than any clever pattern inside it.

## Testing strategy

- **Acceptance criteria become tests first.** Each Given/When/Then in the PRD maps to at least one automated test, named after the criterion. The suite then reads as the spec, and a criterion with no test is a visible gap rather than a silent one.
- **Test at the layer where the logic lives:**

  | Layer | Test type | Notes |
  |---|---|---|
  | Business logic | Unit: many, fast, no I/O | Most behavior should be testable here; that's what the layer separation buys |
  | Data access, external integrations | Integration, against a real local database or container | Mocking your own ORM tests the mock. Use contract tests or recorded fixtures for third-party APIs. |
  | Critical user journeys (signup, payment, the North Star action) | A few end-to-end tests | Slow and flakier, so reserve them for flows that would block a launch if broken |

- **Don't test** framework or library behavior, trivial pass-throughs, or implementation details (private functions, exact mock call counts). Tests coupled to implementation break on every refactor and get deleted, taking their real coverage with them.
- **Bug fixes start with a failing test that reproduces the bug**, then the fix. This proves the fix works and keeps the bug from quietly returning.
- **Flaky tests are bugs.** Quarantine and fix them within days, or delete them. Never retry-until-green in CI: a suite that's sometimes red for no reason trains everyone to ignore red.
- **Tests live next to what they test** (colocated, or a mirrored `tests/` tree) and run in CI on every change.

## Data handling checkpoint

Run this before finalizing any schema, data model, or storage layer. It's self-contained, so it applies even in a session where a separate security review never gets triggered. This is where a data-exposure gap gets baked in permanently, so don't defer it. For classification levels and encryption choices, follow `security-engineer`.

- **Classify the data before designing the table.** Does it touch financial data, health data, credentials, government IDs, or anything else a person would consider sensitive? If yes, encryption at rest is the default, not an enhancement:
  - client-side storage (IndexedDB, SQLite, localStorage): usually an encrypted wrapper rather than a raw plaintext database
  - server-side storage: turn on the datastore's built-in encryption at rest

  Record the classification per entity in the spec's data model.
- **"Local only" is not "secure by default."** Local-only removes network exposure, but not device-loss, shared-device, or malware exposure. Say this out loud rather than treating "local" as the end of the security question. The person can still decide the trade-off is acceptable, but they should make that call; it shouldn't be made silently.
- **If more than one user or account exists**, confirm each user's queries are scoped to their own data at the query layer, not just hidden in the UI.
- **State the outcome either way, briefly.** If the data is genuinely low-sensitivity and encryption would be overkill, say so in one line. Silence reads the same whether the check happened or not, so the check isn't complete until it's visible.

## API design

Must-apply rules; load `references/api-design.md` when designing or reviewing an API surface:

- **One error envelope for every error** (e.g. RFC 9457 Problem Details), with a request ID and never a stack trace, so clients handle errors in one place.
- **Validate at the boundary.** Parse each request into a typed schema at the handler, and reject unknown fields on writes. The business layer only ever receives validated, typed input.
- **Paginate every list endpoint, with a server-enforced maximum page size.** Use cursor pagination for large or frequently changing collections; offset is fine only for small, stable lists.
- **Idempotency keys on writes that clients retry** (payments, orders, messages), so a network retry doesn't create a duplicate.
- **Every outbound call has a timeout.** Retry only idempotent operations, with exponential backoff and jitter.
- **Decide the versioning strategy before the first external consumer exists.** Afterwards, every breaking change is a migration for someone else.

## Observability

- **Structured logs** (JSON, consistent field names) with a request/trace ID generated at the edge and propagated through every service and job, so one user's failure can be followed end to end.
- **Error tracking** with release/version tags, so a spike can be tied to the deploy that caused it.
- **PRD metrics are instrumented as named analytics events**, defined in the tech spec (`object_action`, e.g. `report_exported`, with segmenting properties). Emit server-side where possible, because client-side events get blocked and dropped. Verify every event actually fires before launch, since a metric that can't be measured on launch day can't drive the launch decision.
- **Alert on user-facing symptoms** (error rate, latency against target, failed key actions), not on every exception. Every paging alert should have an owner and a first action. Alerts nobody acts on train people to ignore the ones that matter.
- **No secrets, tokens, or unnecessary personal data in logs, traces, or analytics properties.** Log identifiers, not contents. See `security-engineer` for what counts as sensitive.

## Performance basics

- **Measure before optimizing.** Profile, trace, or check query plans first, then fix the measured bottleneck. Intuition about where time goes is wrong often enough that unmeasured optimization mostly adds complexity.
- **Web: Core Web Vitals "good" thresholds at the 75th percentile of real users**: LCP ≤ 2.5s, INP ≤ 200ms, CLS ≤ 0.1. Use field data (real-user monitoring) for decisions; lab tools like Lighthouse are for diagnosis.
- **Database:**
  - no queries inside loops (N+1): batch, join, or preload instead
  - every production query path has a supporting index (check with `EXPLAIN`)
  - every list is paginated
- **Caching needs a written invalidation rule** (a TTL, or the event that clears it). A cache without one is a stale-data bug that hasn't been reported yet.
- **Set a JavaScript bundle budget in CI** that fails the build when exceeded. Bundle bloat arrives one dependency at a time, and nobody notices until load time has doubled.

## AI features

- **For model IDs, parameters, pricing, streaming, tool use, and prompt caching, load the `claude-api` skill if it's available** rather than answering from memory. Models, limits, and prices change faster than training data.
- **Evals run in CI on every prompt or model change.** Use a fixed, versioned set of representative inputs with graded expected outputs, and block merges that regress past a threshold. These scores are the PRD's AI quality metrics; without them, a prompt tweak that breaks 20% of cases ships unnoticed.
- **Timeouts and retries with exponential backoff and jitter** on rate-limit and overload errors, plus a fallback (degraded response, queued job, clear error) for when the model is unavailable.
- **Cap cost per request and per user**:
  - a maximum output-token limit on every call
  - an iteration limit on agent loops
  - per-user/tenant rate limits
  - spend alerts

  One runaway loop or abusive user can burn a month's budget in hours.
- **Prompts are versioned in code** and reviewed like code, not edited live in a dashboard. Log the prompt version and model per request, so any output can be traced to what produced it.
- **Model output is untrusted input.** Validate structured output against a schema. Never execute it, interpolate it into queries or shell commands, or render it unescaped. Give tools the least privilege they need. See the LLM security section of `security-engineer`.
- **Stream user-facing responses**, since time to first token matters more to perceived speed than total time.

## Stack selection framework

Choose based on constraints, not familiarity or trend. Weigh these in order:

1. **Team/solo familiarity**: the fastest stack is the one already known. A "better" unfamiliar stack has a real learning-curve cost that should be justified, not assumed away.
2. **Scale and traffic needs**: don't provision for hypothetical scale. A stack that comfortably handles the actual expected load, with a known upgrade path, beats one over-engineered for traffic that may never arrive.
3. **Time-to-market**: a managed, batteries-included stack (built-in auth, ORM, admin) is usually right for validating an idea. A more custom stack earns its complexity once the idea is validated.
4. **Ecosystem maturity**: prefer stacks with active maintenance, good docs, and a community large enough that a stuck problem is searchable. Bleeding-edge tooling trades stability for novelty.
5. **Operational overhead**: factor in who maintains this after launch. A serverless or managed stack lowers ops burden at the cost of some control; self-hosted is the reverse.
6. **Cost at expected scale**: compare cost curves, not sticker price at zero traffic. Some "cheap to start" platforms get expensive fast at moderate scale.

**Concrete defaults:** load `references/stack-defaults.md` when choosing a stack or any major tool (database, auth, hosting, testing, CI, observability). It gives a dated, opinionated default per project shape, with when to deviate. Criterion 1 still wins: if the team knows a different stack well, that usually beats the table's default. Record the choice as an ADR.

### When to ask vs proceed

A stack choice is expensive to reverse, so don't guess silently on a high-stakes one. Don't block a low-stakes one on a question either.

**Fallback logic, in order:**
1. A stack, language, or hard constraint is already stated ("use Python," "it has to run on our existing AWS account") → use it, no need to ask.
2. The brief clearly implies a direction via the weighing criteria above (e.g. "solo project, want to ship an MVP this week" → managed, batteries-included stack) → infer and proceed. State the direction and why in one line, so the choice is visible rather than silent.
3. A structural keyword appears without enough context ("build me an app," "set up the backend") → don't pattern-match the keyword alone. Ask using the questions below. "App" alone doesn't say whether it's a weekend prototype or a system meant to handle real user data.
4. No signal, and the decision is high-stakes or costly to reverse (a production system, a database real data will live in, a choice that locks in hosting or hiring constraints) → ask before proceeding.
5. No signal, but the decision is low-stakes or easily reversible (a prototype, a script, a component inside an already-fixed stack) → use the matching default from `references/stack-defaults.md` and say so. Don't block on asking every time.

**Questions worth asking, when asking:**
- Who's building and maintaining this: solo, a small team, or handed off to someone else later? (This changes how much the familiarity criterion should weigh.)
- Expected scale: a prototype, hundreds of users, or provisioning for real growth?
- Time pressure: is shipping a first version fast more important than long-term flexibility right now?
- Does this need to fit an existing stack or infrastructure, or is it green-field?
- Where will this run, and who owns operating it after it ships?

## Deployment

- **Separate environments**: at minimum dev and production, ideally dev/staging/production, with no shared credentials or datastore between them.
- **Infrastructure as code**: environment definitions (not just app code) are version-controlled and reproducible, not click-configured in a console. This is also what makes a security review of the infrastructure possible.
- **Pipeline order**:
  1. lint/format check
  2. unit + integration tests
  3. build
  4. secret scan
  5. static analysis (SAST) + dependency/vulnerability scan
  6. deploy to staging
  7. smoke/end-to-end tests
  8. deploy to production
  9. post-deploy smoke test

  Nothing skips the scan steps to save time.
- **Feature flags for risky launches.** Deploy dark, enable for a cohort, and keep a kill switch. This decouples deploy from release, and it's what makes the PRD's silent/soft/full launch tiers possible. Delete flags once fully rolled out, because stale flags become untested code paths.
- **Rollback is planned before launch, not improvised during an incident.** Make database migrations backward-compatible (expand, migrate, then contract in a later deploy), so rolling back the app never requires rolling back the database.
- **Secrets never enter version control.** They come from a secrets manager or environment injection at deploy time, not committed and not baked into images.

## Red flags to surface proactively

- Hardcoded config or secrets in source
- No tests covering the change, or a PRD acceptance criterion with no matching test
- Retry-until-green or quarantined-forever flaky tests in CI
- Business logic embedded directly in UI/API handler code with no separation
- A list endpoint with no pagination or maximum page size; an outbound call with no timeout
- A query inside a loop (N+1), or a production query path with no index
- A cache with no stated invalidation rule
- PRD metrics with no analytics event defined or verified before launch
- An LLM call with no timeout or token cap, model output used without validation, or a prompt/model change merged without running evals
- A stack choice justified only by "it's popular," with no constraint-based reasoning and no ADR
- No stated rollback plan before a production deploy, or a migration that the previous app version can't run against
