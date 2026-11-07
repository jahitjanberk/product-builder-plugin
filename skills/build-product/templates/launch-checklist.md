# Launch checklist — <product / feature name>

> Copy to `docs/launch-checklist.md` (or the `## Launch` section of `docs/build-plan.md` on the lean track).
> Every item ends up either `[x]` checked, or `[~] waived — <owner>: <reason>`. An unchecked box at go/no-go time is a "no".
> Don't delete rows that don't apply. Waive them with a reason, so the next reader knows they were considered.

**Target date:** <date> · **Launch tier:** silent / soft (limited audience) / full · **Go/no-go owner:** <one name>

## 1. Product & go-to-market — owner: product-management

- [ ] Success criteria copied from the PRD: North Star target, guardrail thresholds, and the date they'll be judged
- [ ] **Kill / rollback criteria** written down *before* launch (e.g. "guardrail X drops > Y% for 48h → roll back")
- [ ] Positioning statement and the one-line value prop are final
- [ ] Channel plan: where the target audience hears about this, and who sends what, when
- [ ] Pricing / plan changes live in billing, and match the public pricing page
- [ ] Support ready: FAQ or help article, known-issues list, escalation path
- [ ] Stakeholders in the RACI "Informed" column have been told the date

## 2. Design & UX — owner: ui-ux-design

- [ ] Every in-scope screen ships its designed empty, loading, error, and success states, not just the happy path
- [ ] Accessibility pass done: keyboard-only walkthrough, screen-reader spot check on key flows, contrast verified (WCAG 2.2 AA), automated scan clean
- [ ] Copy reviewed: error messages say what happened and what to do next
- [ ] Checked on the smallest supported viewport and on the primary desktop width

## 3. Engineering & deploy — owner: developer

- [ ] All acceptance-criteria tests pass in CI on the release commit
- [ ] Analytics events for every PRD metric are emitted, and verified in the analytics tool with real events
- [ ] Error tracking and structured logging are live in production, and an alert exists for the main user-facing symptom
- [ ] Deployed to staging from the same pipeline that will deploy production
- [ ] **Rollback rehearsed**, not just written down. Database migrations are reversible or have a forward-fix plan
- [ ] Risky paths are behind a feature flag that can be turned off without a deploy
- [ ] Load expectation stated, and the system checked against it (or "low traffic expected, not load-tested")
- [ ] Backups configured, and one restore actually tested

## 4. Security — owner: security-engineer

- [ ] Threat model is up to date with the final tech spec
- [ ] **No open Critical or High findings.** Any accepted risk is recorded in the threat model with an owner (a launch blocker otherwise)
- [ ] `product-builder:security-reviewer` run on the release diff; findings resolved or accepted
- [ ] Secrets are in a secrets manager; none in the repo, images, or client bundle; any exposed during development rotated
- [ ] Production access is least-privilege and requires MFA; dev/staging credentials can't reach production
- [ ] Dependency and vulnerability scan clean, or exceptions recorded
- [ ] Privacy: data retention set, deletion/export path works, no PII or secrets in logs and analytics
- [ ] Incident contact and first containment step written down (who gets paged, what gets switched off)

## 5. Go / no-go

| Section | Status | Notes |
|---|---|---|
| Product & GTM | | |
| Design & UX | | |
| Engineering & deploy | | |
| Security | | |

**Decision:** GO / NO-GO · **Decided by:** <name> · **Date:** <date>

**Post-launch review on:** <date> — compare actual metrics to the success and kill criteria above.
