---
name: build-product
description: Use this skill to take a product or a major feature from idea to launch across product management, design, development, and security — "I have an idea for an app," "build this end to end," "take X from idea to production," "help me launch this," "plan and build this feature," or "where are we / what's next" on a multi-phase build. Runs the phases in order (define → design → plan → secure → build → launch), decides which phases the request actually needs, has each phase write a named artifact the next phase reads (PRD, design brief, tech spec, threat model, launch checklist), and does not advance past a phase until its artifact meets its gate. Not for a single isolated task — one screen, one function, one pricing question goes straight to the matching skill (ui-ux-design, developer, product-management, security-engineer) without this orchestrator.
---

# Build Product

The entry point that turns the four discipline skills in this plugin into one build process. Each discipline skill knows *how* to do its part; this skill decides *which parts are needed, in what order, and what has to exist before moving on* — so a product doesn't reach code without a defined audience, or reach launch without a threat model.

## Step 0 — Triage: full flow, direct, or resume

| The request is… | Route |
|---|---|
| A new product, or a feature that spans more than one discipline ("build an app that…", "add paid team plans") | Run the flow below |
| One discipline, one output ("design this screen," "price this," "review this function") | Load that skill directly; don't create orchestrator artifacts |
| An existing build ("where are we?", "what's next?", "continue") | **Resume**: read the artifacts that exist, print the status table (below), continue at the first unmet gate |

Then pick a **track** and state it in one line with the reason:

- **Lean track** — prototype, hackathon, internal experiment, no real user data, no payments, not public. All phases write short sections into one file, `docs/build-plan.md` (`## Product`, `## Design`, `## Tech`, `## Security`, `## Launch`). Wherever another skill says "read the PRD," it reads the `## Product` section.
- **Full track** — real users, real personal/financial/health data, payments, auth, or anything publicly reachable. One artifact per phase at the paths below.

**Sensitive data overrides size.** A two-day project that stores payment details or health data is full track for the Secure phase, even if every other phase stays lean — say so when that applies.

If the project already keeps docs somewhere other than `docs/` (an existing `documentation/`, an ADR folder, a wiki convention in the README), use that location instead and state it once.

## Phases and gates

Load each phase's skill with the Skill tool at the start of the phase (e.g. `product-builder:product-management`), even if it was loaded earlier in the conversation — its ask-vs-proceed rules and red flags govern that phase.

| # | Phase | Skill(s) | Artifact | Gate — must be true before the next phase starts |
|---|---|---|---|---|
| 1 | **Define** | `product-management` | `docs/product/prd.md` | Problem and JTBD audience stated; North Star + guardrail metric named; every in-scope story has Given/When/Then acceptance criteria; non-goals listed; "data collected" section filled with a sensitivity class per item |
| 2 | **Design** | `ui-ux-design` | `docs/design/brief.md` + tokens | Style chosen with a one-line reason tied to the PRD audience; every in-scope screen listed with its states (empty/loading/error/success); accessibility requirements listed; tokens written to the project's styling system or `docs/design/tokens.css` |
| 3 | **Plan** | `developer` | `docs/tech/spec.md` (+ `docs/tech/adr/`) | Stack decided (asked, if high-stakes); data model carries the PRD's sensitivity classes; API surface listed; test plan maps to acceptance criteria; analytics events named for each PRD metric; rollback plan stated |
| 4 | **Secure** | `security-engineer` | `docs/security/threat-model.md` | Every trust boundary in the spec has a STRIDE pass; every threat is mitigated or accepted with a named owner; mitigations copied into the spec as tasks |
| 5 | **Build** | `developer` + `security-engineer` (+ `ui-ux-design` for UI work) | Code + tests | Acceptance-criteria tests pass; PRD analytics events are emitted; designed states are implemented, not just the happy path; every security-scan hook message is fixed or explained; the `product-builder:security-reviewer` subagent has reviewed the diff with no open Critical/High |
| 6 | **Launch** | `product-management` + `developer` + `security-engineer` | `docs/launch-checklist.md` from [templates/launch-checklist.md](templates/launch-checklist.md) | Every item checked or waived with an owner and a reason; go/no-go decision recorded with a named owner |

**Skipping a phase:**
- No UI (API, CLI, background service) → skip Design and say so.
- Design and Plan both read the PRD. If the user wants to start technical planning before the design is final, that's fine. Plan must then be re-checked against the brief when Design lands.

## Gate rules

- **Check before starting, not after.** At the start of each phase, verify the previous gate against the artifact's actual content, not a status label. If it isn't met, finish it or tell the user exactly what's missing. Never quietly paper over it.
- **The user can skip a gate; the skip must be visible.** Record `Skipped by user: <reason>` at the top of the next artifact and continue. Gates exist to make gaps visible, not to block someone who has decided.
- **One gate the user can't skip silently: an open Critical security finding at Launch.** Proceeding requires an explicit risk acceptance recorded in the threat model with a named owner. Say plainly what's being accepted.
- **Ask only what blocks the current phase.** Batch those questions in one message, using the owning skill's ask-vs-proceed logic. Don't front-load questions for later phases.

## Status table (for "where are we?" and at each phase transition)

Print one row per phase, then the single next action:

```
Phase    Artifact                        Gate     Notes
Define   docs/product/prd.md             met      —
Design   docs/design/brief.md            missing  error/empty states not listed for 2 screens
Plan     —                               —        blocked on Design (or: started in parallel)
...
Next: finish states for Checkout and Order history in the design brief.
```

## Handoff map

What each phase produces and who consumes it. Each skill's own "Inputs and handoffs" section has the detail.

| Produced by | Field | Consumed by → used for |
|---|---|---|
| PRD | Audience / JTBD | ui-ux-design → style selection, tone |
| PRD | Stories + acceptance criteria | developer → tests; ui-ux-design → screen list |
| PRD | North Star, input, guardrail metrics | developer → named analytics events |
| PRD | Data collected + sensitivity | developer → data model; security-engineer → asset inventory |
| PRD | Go-to-market, kill criteria | Launch checklist |
| Design brief | Tokens, per-screen states, a11y requirements | developer → implementation + acceptance criteria |
| Design brief | Screens collecting credentials, payment, or PII | security-engineer → threat model scope |
| Tech spec | Architecture, data model, API, infra | security-engineer → trust boundaries, STRIDE |
| Tech spec | Deploy and rollback plan | Launch checklist |
| Threat model | Mitigations | developer → tasks in the spec |
| Threat model | Open Critical/High | Launch checklist → blockers |

## When an upstream artifact changes

Changes ripple downstream. Re-open only the affected gates, and say which ones:

| Change | Re-check |
|---|---|
| Audience or JTBD pivots | Design style selection, PRD metrics, GTM |
| New story added | Design screen and state list, test plan |
| New data collected, or a sensitivity class rises | Data model, threat model, launch security section |
| New external integration, LLM feature, or public endpoint | Threat model (new trust boundary) |
| Stack or hosting change | Tech spec ADR, threat model infra rows, rollback plan |

## Red flags to surface proactively

- Code being written for a product with no stated audience or success metric.
- A screen designed without its empty, loading, and error states.
- A data model storing personal or financial data with no sensitivity classification.
- A launch date set while the threat model doesn't exist, or has open High/Critical items.
- Metrics defined in the PRD that no code actually emits. If nobody can measure the North Star, the launch can't be judged.
