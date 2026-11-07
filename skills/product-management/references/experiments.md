# Experiments and A/B tests

Load this before designing, sizing, or reading out an experiment. Most bad A/B results come from decisions made after the data started arriving. Everything in the pre-registration checklist gets fixed before the test starts.

## Hypothesis format

> Because **[evidence: interview finding, funnel data, support tickets]**, we believe **[specific change]** for **[segment]** will move **[primary metric]** by at least **[minimum detectable effect]**, without regressing **[guardrail metrics]**.

If the "because" clause is empty, the test is a guess. That's sometimes fine, but say so, because guesses have a much lower prior of winning.

## Pre-registration checklist (write down before launch)

| Item | Rule |
|---|---|
| Primary metric | Exactly one. With several, one will "win" by chance. |
| Guardrail metrics | 1–3 metrics that must not regress (e.g. retention, revenue per user, error rate, support tickets). |
| Minimum detectable effect (MDE) | The smallest change worth acting on, stated in absolute terms (10.0% → 11.0%) as well as relative (+10%). |
| Randomization unit | Usually the user, not the session or page view, so one person doesn't see both variants. |
| Sample size per variant | From the rule of thumb below, or a proper power calculator. |
| Duration | Total sample ÷ daily eligible traffic, rounded **up to whole weeks**, and never under one full week, so weekday/weekend cycles are covered. |
| Decision rule | What result leads to ship, iterate, or drop, including what happens if guardrails regress while the primary metric wins. |

## Sample size rule of thumb

For 80% power and a two-sided 5% significance level:

**n per variant ≈ 16 × p × (1 − p) ÷ δ²**

where `p` is the baseline conversion rate and `δ` is the absolute MDE. For a continuous metric, replace `p × (1 − p)` with the metric's variance.

| Baseline (p) | Absolute MDE (δ) | n per variant |
|---|---|---|
| 10% | 2 pp (10% → 12%) | ~3,600 |
| 10% | 1 pp (10% → 11%) | ~14,400 |
| 5% | 0.5 pp (5% → 5.5%) | ~30,400 |
| 2% | 0.2 pp (2% → 2.2%) | ~78,400 |

Halving the MDE quadruples the sample. Low-baseline metrics need far more traffic than intuition suggests.

**Duration check:** if collecting the sample takes more than ~4–6 weeks, don't run the A/B test as designed. Long tests accumulate novelty effects, seasonality, and product changes that contaminate the result. Instead, pick a metric with a higher baseline that's closer to the change, accept a larger MDE, or use an alternative below.

## Running the test

- **No peeking and early stopping.** Checking significance repeatedly and stopping at the first p < 0.05 pushes the real false-positive rate far above 5%. If the business needs early reads, choose a **sequential testing** method designed for repeated looks (group-sequential boundaries or always-valid p-values) before the test starts. Most experimentation platforms offer one.
- **Check sample ratio mismatch (SRM) first.** If a 50/50 split arrives as, say, 52/48 with large samples, assignment or logging is broken. Fix that before reading any metric.
- **Watch for novelty and primacy effects.** Existing users react to change itself. Compare new-user and existing-user segments, and be wary of a lift that decays across the test's weeks.
- **Don't change the variant mid-test.** A change restarts the clock.

## When not to A/B test

| Situation | Why A/B fails | Use instead |
|---|---|---|
| Low traffic (the sample takes more than 4–6 weeks) | Underpowered: "no significant difference" means nothing | Qualitative usability tests (5 users catch most major issues), interviews, a larger MDE |
| Testing whether demand exists at all | Building both variants costs more than the question is worth | Fake-door test (a button or landing page that measures intent, then explains it isn't ready) |
| Pricing changes for existing customers | Fairness, trust, and possible legal exposure when customers compare notes | A test on new signups only, or by geography, or a staged rollout |
| Network or marketplace effects (variants interact) | Treatment leaks into control, biasing the result | Cluster randomization (by team, region, market) or switchback tests |
| Big one-way-door changes (rebrand, core workflow redesign) | A short test can't capture long-run effects | Staged rollout with a holdout group measured over a longer period |
| AI prompt or model changes | Online tests are slow and expensive per variant | Offline evals on a fixed test set first; A/B only the finalists |

## Readout

Report:
1. the hypothesis
2. the primary metric's effect with its **confidence interval**, not just a p-value
3. each guardrail's effect
4. the SRM check
5. segment notes
6. the decision, applied as pre-registered
7. what was learned

A null result is a result. Record it so the same idea isn't re-tested in six months.
