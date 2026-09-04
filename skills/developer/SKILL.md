---
name: developer
description: Use this skill when writing, structuring, reviewing, or planning code and its deployment — choosing a tech stack, organizing a codebase, writing clean and readable functions, setting up CI/CD, or deciding how and where to deploy. Trigger for "what stack should I use," "review this code," "how should I structure this project," "set up deployment," or any request to write or restructure production code.
---

# Developer

Standards for writing code a human can read and maintain, choosing the right stack for the actual constraints of a project, and deploying it safely.

## How to use this skill

1. Before writing code, check the **stack selection framework** if the stack isn't already fixed by the project — and follow its **when to ask vs proceed** logic rather than silently assuming an answer.
2. While writing or reviewing code, apply the **clean code principles** and **structure** sections as defaults, not suggestions — deviate only with a stated reason.
3. Before finalizing any schema, data model, or storage decision, run the **data handling checkpoint** — this applies whether or not a separate security review is happening in the conversation.
4. Before calling anything done, run it against the **deployment checklist**.
5. When reviewing someone else's code or plan, check it against **red flags** even if not explicitly asked to.

## Clean code principles

- **Naming carries the explanation.** A well-named function or variable needs no comment to explain what it does; comments are reserved for *why*, not *what* — "// retry because the upstream API rate-limits in bursts," not "// increment counter."
- **One responsibility per function.** If a function needs "and" to describe what it does ("validates and saves and notifies"), split it. Small functions are easier to test, name accurately, and reuse.
- **Avoid premature abstraction.** Don't generalize for a second use case that doesn't exist yet — duplication that will diverge is cheaper than the wrong abstraction. Reach for abstraction on the third repetition, not the second.
- **Consistent formatting is non-negotiable, and automated.** Use a linter/formatter (not manual style enforcement) so code review discusses logic, not spacing.
- **Fail loudly, not silently.** Prefer raising/returning explicit errors over swallowing exceptions or returning ambiguous defaults (e.g. `null`/`-1`) that push the failure downstream to a harder-to-debug location.
- **Readable beats clever.** If a one-liner needs a comment to explain the trick, write it as three plain lines instead.

## Structuring a codebase

- **Separate layers**: presentation (UI/API surface), business logic (rules, orchestration), and data access (persistence, external calls) should not be tangled in one file — this is what makes a codebase testable without spinning up a database or a browser.
- **Config lives outside code.** Environment-specific values (URLs, keys, feature flags) come from environment variables or a config service, never hardcoded — this is also a security requirement, not just a style preference.
- **Tests live next to what they test**, and are written as behavior travels through the layers above, not just as an afterthought bolted onto business logic.
- **A new contributor should be able to find the entry point in under a minute** — a consistent, documented top-level structure (e.g. `src/`, `tests/`, `infra/`) does more for maintainability than any individual clever pattern inside it.

## Data handling checkpoint

Run this before finalizing any schema, data model, or storage layer — self-contained, so it applies even in a session where a separate security review never gets triggered on its own. This is the point where a data-exposure gap gets baked in permanently, so don't defer it.

- **Classify the data before designing the table.** Does it touch financial data, health data, credentials, government IDs, or anything else a person would consider sensitive? If yes, treat encryption at rest as the default, not an enhancement — for client-side storage (IndexedDB, SQLite, localStorage), that usually means an encrypted wrapper rather than a raw plaintext database; for server-side storage, it means turning on the datastore's built-in encryption-at-rest setting.
- **"Local only" is not "secure by default."** Local-only removes network exposure, but not device-loss, shared-device, or malware exposure. Say this out loud rather than treating "local" as the end of the security question — the person can still decide the trade-off is acceptable, but they should get to make that call rather than have it made silently.
- **If more than one user or account exists**, confirm each user's queries are scoped to their own data at the query layer, not just hidden in the UI.
- **State the outcome either way, briefly.** If the data is genuinely low-sensitivity and encryption would be overkill, say that in one line. Silence reads identically whether the check happened or not, so the check isn't complete until it's visible.

## Stack selection framework

Choose based on constraints, not familiarity or trend. Weigh these in order:

1. **Team/solo familiarity** — the fastest stack is the one already known; a "better" unfamiliar stack has a real learning-curve cost that should be justified, not assumed away.
2. **Scale and traffic needs** — don't provision for hypothetical scale; a stack that comfortably handles the actual expected load, with a known upgrade path, beats one over-engineered for traffic that may never arrive.
3. **Time-to-market** — a managed/batteries-included stack (e.g. a framework with built-in auth, ORM, admin) is usually the right call for validating an idea; a more custom stack earns its complexity once the idea is validated.
4. **Ecosystem maturity** — prefer stacks with active maintenance, good docs, and a large enough community that a stuck problem is Google-able; bleeding-edge tooling trades stability for novelty.
5. **Operational overhead** — factor in who maintains this after launch: a serverless/managed stack lowers ops burden at the cost of some control; a self-hosted stack is the reverse.
6. **Cost at expected scale** — compare cost curves, not just sticker price at zero traffic; some "cheap to start" platforms get expensive fast at moderate scale.

**Rule of thumb by project shape:**

| Project shape | Reasonable default direction |
|---|---|
| Native mobile app, tight platform integration | Platform-native (e.g. Swift/Kotlin) over cross-platform, if targeting one OS well matters more than shipping to both cheaply |
| Cross-platform mobile/small team | A cross-platform framework, accepting some native-feel trade-off for shared code |
| Data-driven web app / dashboard | A typed frontend framework + a REST/GraphQL API + a relational database, unless the data is genuinely document-shaped |
| Serverless / cost-sensitive backend, spiky traffic | Managed functions + managed datastore, defined as infrastructure-as-code |
| Long-running, stateful backend | A traditional server process over serverless — cold starts and execution-time limits fight persistent state |
| Static content / marketing site | Static site generation + CDN, not a full server framework |
| Desktop app reusing web skills | A web-shell desktop framework, accepting the resource-usage trade-off over native |

### When to ask vs proceed

A stack choice is expensive to reverse, so don't guess silently on a high-stakes one — but don't block a low-stakes one on a question either.

**Fallback logic, in order:**
1. A stack, language, or hard constraint is already stated ("use Python," "it has to run on our existing AWS account") → use it, no need to ask.
2. The brief clearly implies a direction via the weighing criteria above (e.g. "solo project, want to ship an MVP this week" → managed/batteries-included stack) → infer and proceed; state which direction was chosen and why in one line, so the choice is visible rather than silent.
3. A structural keyword appears without enough context ("build me an app," "set up the backend") → don't pattern-match the keyword alone. Ask using the questions below rather than guessing from the noun — "app" alone doesn't say whether it's a weekend prototype or a system meant to handle real user data.
4. No signal, and the decision is high-stakes or costly to reverse (a production system, a database real data will live in, a choice that locks in hosting or hiring constraints) → ask before proceeding.
5. No signal, but the decision is low-stakes or easily reversible (a prototype, a script, a component inside an already-fixed stack) → default to the safest general-purpose direction from the table above and say so — don't block on asking every time.

**Questions worth asking, when asking:**
- Who's building and maintaining this — solo, a small team, or handed off to someone else later? (changes how much the familiarity criterion should weigh)
- Expected scale — a prototype, hundreds of users, or provisioning for real growth?
- Time pressure — is shipping a first version fast more important than long-term flexibility right now?
- Does this need to fit an existing stack/infra, or is it green-field?
- Where will this run, and who owns operating it after it ships?

## Deployment

- **Separate environments**: at minimum dev and production, ideally dev/staging/production, with no shared credentials or datastore between them.
- **Infrastructure as code**: environment definitions (not just app code) should be version-controlled and reproducible, not click-configured in a console — this is also what makes a security review of the infrastructure possible.
- **Pipeline order**: lint → automated tests → build → dependency/vulnerability scan → deploy → smoke test. Nothing skips the scan step to save time.
- **Rollback is planned before launch, not improvised during an incident** — know how to revert a deploy before you need to.
- **Secrets never enter version control** — pulled from a secrets manager or environment injection at deploy time, not committed, not baked into images.

## Red flags to surface proactively

- Hardcoded config or secrets in source
- A function doing several unrelated things under one name
- No tests covering the change being reviewed
- A stack choice justified only by "it's popular" with no constraint-based reasoning
- No stated rollback plan before a production deploy
- Business logic embedded directly in UI/API handler code with no separation
