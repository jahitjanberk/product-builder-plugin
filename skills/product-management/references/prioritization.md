# Prioritization methods

Load this when scoring a backlog, cutting scope against a deadline, or deciding which features to differentiate on. The method follows from the decision being made. Applying RICE to a scope-cut question, or MoSCoW to a backlog ranking, gives a confident-looking answer to the wrong question.

## Choosing the method

| Situation | Use | Output |
|---|---|---|
| 10+ comparable candidate items, roughly similar in kind, need an order | RICE | A ranked list with the estimate behind each rank visible |
| A fixed date or release, and scope has to fit | MoSCoW | Must / Should / Could / Won't for this release |
| Unsure which features users expect vs. which would win them | Kano | Each feature classified as basic, performance, delighter, indifferent, or reverse |
| A few large strategic bets of very different kinds | Don't score them. Write a one-paragraph case for each against the North Star and decide explicitly. | A decision with stated reasoning |

The methods combine: Kano decides *what kind* of value a feature has, RICE orders the candidates, and MoSCoW cuts the ordered list to fit a release.

## RICE

**Score = (Reach × Impact × Confidence) ÷ Effort**

| Factor | Definition | Scale |
|---|---|---|
| Reach | Users or events affected **per fixed period** (e.g. per quarter). Use the same period for every item. | Real count from analytics where possible |
| Impact | Effect on the North Star or its input metric for each user reached | 3 = massive, 2 = high, 1 = medium, 0.5 = low, 0.25 = minimal |
| Confidence | How well-supported the Reach and Impact estimates are | 100% = measured data, 80% = strong qualitative evidence, 50% = informed guess. Go below 50% and the item needs discovery, not scoring. |
| Effort | Total team time across design, engineering, and QA | Person-weeks (or person-months, consistently) |

**Caveats to apply every time:**
- **Scores order the list; they don't measure it.** Treat items within ~20% of each other as tied and break the tie on strategy or dependencies.
- **Confidence inflates.** An idea no user has seen in any form (interview, prototype, fake door) caps at 50%. Raising Confidence requires new evidence, not more conviction.
- **Effort is usually underestimated for new surfaces and overestimated for extensions of existing ones.** Ask the developer for the estimate rather than guessing, and include design, QA, and migration time.
- **Don't score unlike things on one list.** Infrastructure work, compliance obligations, and bug debt don't have comparable Reach × Impact. Reserve explicit capacity for them (e.g. a fixed share of each cycle) instead of letting them perpetually lose to features.
- **Show the inputs, not just the score**, so a disagreement becomes a disagreement about a specific estimate.

## MoSCoW

For a specific release with a fixed date:

- **Must**: the release fails or can't ship without it, whether legally, functionally, or because it's the core job. Test: "If this is missing, do we cancel the launch?" If the answer is no, it isn't a Must.
- **Should**: important and expected, but there's a workaround or it can follow shortly after.
- **Could**: nice to have; first to cut.
- **Won't (this time)**: explicitly out. These become the PRD's non-goals.

**Keep Musts to roughly 60% of estimated capacity.** The remaining buffer absorbs estimate error. A release planned at 100% Musts has no slack, so it either slips or cuts a Must under pressure.

## Kano

Classifies features by how their presence and absence affect satisfaction:

| Category | Present | Absent | Implication |
|---|---|---|---|
| Basic (must-be) | Unnoticed | Strong dissatisfaction | Required to compete. Investing beyond "good enough" earns nothing. |
| Performance (one-dimensional) | More is better | Less is worse | Compete on these, and benchmark against the current alternative. |
| Delighter (attractive) | Disproportionate satisfaction | Not missed | Where differentiation lives. Cheap delighters are the best bets. |
| Indifferent | No effect | No effect | Cut |
| Reverse | Dissatisfies some users | Satisfies them | Make optional, or cut |

**Survey method:** for each feature, ask a pair of questions:
- functional: "How would you feel if the product had X?"
- dysfunctional: "How would you feel if it didn't have X?"

Each answer is one of: like it / expect it / neutral / can tolerate / dislike. Classify each feature by the most common answer pair across respondents, using the standard Kano evaluation table. Survey the target segment from the PRD, not everyone, because categories differ by segment.

**Delighters decay into basics.** Something that impressed users two years ago may now be expected. Re-run the survey before major planning cycles rather than reusing old classifications.
