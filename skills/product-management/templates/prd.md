# PRD: <product or feature name>

> **Status:** Draft | In review | Approved · **Accountable owner:** <one name> · **Last updated:** <YYYY-MM-DD>
> **Related:** [Design brief](../design/brief.md) · [Tech spec](../tech/spec.md) · [Threat model](../security/threat-model.md) · [Launch checklist](../launch-checklist.md)

<!--
How to fill this in:
- Mark anything inferred rather than confirmed as **(assumption)**, so reviewers know what still needs checking.
- Keep each section short. This document is read by design, engineering, and security, so tables beat prose.
- Delete these comments once the section is filled.
-->

## 1. Problem

<!-- One paragraph: what is broken or missing today, for whom, and the evidence (interview notes, support tickets, usage data). If there is no evidence yet, say so and list it under Open questions. -->

## 2. Audience and job to be done

| Field | Answer |
|---|---|
| Job (verb phrase: the progress they're trying to make) | |
| Context / triggering situation | |
| Current alternative (including "do nothing" or a workaround) | |
| Switching trigger | |
| Deliberately excluded (who this is *not* for) | |

<!-- ui-ux-design uses this table to choose the visual style and tone. Engineering and security use the "excluded" row to bound scope. -->

## 3. Goals and metrics

**Objective:** <qualitative, time-bound>

| Tier | Metric | Current | Target | By when | Analytics event(s) that measure it |
|---|---|---|---|---|---|
| North Star | | | | | |
| Input | | | | | |
| Input | | | | | |
| Guardrail | | | Must not drop below: | | |

<!-- The last column is the developer's instrumentation list. Name events as object_action (e.g. report_exported) with the properties needed to segment them. A metric with no event can't be reported at launch. For AI features, add eval score, task success rate, cost per successful task, and latency. -->

## 4. Scope

**In scope (v1):**
-

**Non-goals (explicitly out of v1):**
-

## 5. User stories and acceptance criteria

### Story 1: <short name>

**When** <situation>, **I want to** <action>, **so I can** <outcome>.
**Priority:** Must | Should | Could

**Acceptance criteria:**
- **Given** <precondition>, **when** <action>, **then** <observable result>.
- **Given** <precondition>, **when** <invalid input / failure / edge case>, **then** <observable result>.

### Story 2: <short name>

**When** …, **I want to** …, **so I can** ….
**Priority:** Must | Should | Could

**Acceptance criteria:**
- **Given** …, **when** …, **then** ….

<!-- Every criterion must be observable (something a test can assert), and each story needs at least one failure or edge case. The developer maps each criterion to a test in the tech spec's testing plan. -->

## 6. Data collected and sensitivity

| Data item | Why it's needed | Sensitivity | Retention | Who can access it |
|---|---|---|---|---|
| | | | | |

<!-- Sensitivity uses security-engineer's data classification: Public / Internal / Personal / Sensitive. Financial, health, credential, government-ID, and precise-location data are always Sensitive; anything that identifies a person is at least Personal. The data you don't collect is the data you never have to protect, so cut any item without a clear "why". security-engineer uses this table as the threat model's asset inventory. -->

## 7. Stakeholders and decisions

| Decision / deliverable | Responsible | Accountable (one name) | Consulted | Informed |
|---|---|---|---|---|
| | | | | |

## 8. Dependencies, risks and open questions

| Item | Type (dependency / risk / question) | Impact if wrong | Owner | How and when it gets resolved |
|---|---|---|---|---|
| | | | | |

## 9. Launch and kill criteria

- **Launch tier:** silent | soft | full. Why this tier:
- **Success looks like:** <metric> reaches <target> by <date>.
- **Kill / rollback if:** <guardrail> regresses by more than <threshold>, or <metric> stays below <floor> after <period>.
- **Who makes the kill/rollback call:** <one name>

<!-- These carry into the Go-to-market section of docs/launch-checklist.md. -->
