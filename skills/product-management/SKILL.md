---
name: product-management
description: Use this skill when defining or evaluating a product's direction or requirements — setting product goals, identifying and validating the target audience, sizing a market, choosing a pricing strategy, mapping stakeholders, picking KPIs, writing a PRD or spec with user stories and acceptance criteria, prioritizing a backlog or roadmap, planning customer discovery interviews, designing an experiment or A/B test, or planning a launch and go-to-market. Trigger for questions like "who is this for," "how should we price this," "what should we measure," "is there a market for this," "write a PRD," "what should we build first," "how do I interview users," "should we A/B test this," or "how do we launch this," and when reviewing a product idea, pitch, roadmap, or spec for gaps in any of these areas — even without an explicit product-management question.
---

# Product Management

Frameworks for turning a product idea into a defensible plan and then into buildable requirements: what it's for, who it's for, whether the market supports it, what it costs, who needs to sign off, how success is measured, what exactly gets built first, and how it reaches users.

## How to use this skill

1. Identify which of the eleven areas below the request touches (often more than one). Areas 1–6 are strategy (direction and viability); areas 7–11 are execution (what gets built, in what order, and how it's validated and launched).
2. Apply the matching framework rather than generic advice. Where an area names a `references/` file, load it when the request needs that area in depth (designing an interview script, sizing an experiment, scoring a backlog). A one-line answer doesn't need the file.
3. When the output is a requirements document, or a `build-product` run is in progress, write it to `docs/product/prd.md` from `templates/prd.md`. If the project already has a docs convention, use that instead. A single question asked outside a build run gets answered in chat, with no file.
4. If the brief is missing something a framework needs (no stated audience, no pricing signal, no success metric), follow the **when to ask vs proceed** logic below instead of defaulting silently.
5. When reviewing an existing plan, pitch, or spec, check it against the **Red flags** section at the end. Surface gaps even if not asked.

## Inputs and handoffs

PM is usually the first skill in a build. Most of what it produces is consumed downstream, so write each output in the form the next skill needs, not just as prose.

**Reads**
- An existing `docs/product/prd.md`, if present. Update it rather than starting a new one, so decisions already made aren't silently re-litigated.
- When product thinking is being retrofitted onto something already built, read the tech spec's data model (`docs/tech/spec.md`) to fill the PRD's data section from what the product actually stores, not from memory.
- Nothing else is required. If the audience, problem, or goal is absent, follow the ask-vs-proceed logic.

**Hands off**

| PM output | Consumed by | Used for |
|---|---|---|
| Audience / JTBD (job, context, current alternative, who's excluded) | `ui-ux-design` | Style selection and tone. The design style selector weighs audience over keywords. |
| User stories + Given/When/Then acceptance criteria | `developer` | Each criterion becomes at least one automated test. |
| North Star, input, and guardrail metrics, each with its analytics event | `developer` | Instrumentation list in the tech spec's observability section. |
| Data collected + sensitivity classification | `security-engineer` | Threat model asset inventory (Identify). |
| Positioning, channel plan, launch tier, success and kill criteria | `build-product` launch checklist | Go-to-market section of `docs/launch-checklist.md`. |

## 1. Product goals

A goal needs a **North Star metric** (the single number that best reflects the value the product delivers to users) plus supporting **OKRs**:

- **Objective**: qualitative, ambitious, time-bound ("Become the default tool for X by Q3")
- **Key Results**: 2–4 quantitative, verifiable outcomes that would prove the objective is met, not activities. "Ship the onboarding flow" is an activity; "Reduce time-to-first-value from 8 minutes to 2" is a key result.

A goal that can't be falsified isn't a goal yet. If you can't describe what evidence would prove it failed, tighten it.

## 2. Target audience

Use **Jobs to Be Done (JTBD)** over demographic personas as the default. Demographics describe who; JTBD explains why they'd switch:

- **Job**: the progress the person is trying to make, stated as a verb phrase ("get my expenses approved faster"), not a product category
- **Context**: the situation that triggers the need
- **Current alternative**: what they use today, including "do nothing" or a manual workaround. This is the real competitor, not just other products in the category.
- **Switching trigger**: the specific frustration or event that would make them try something new

Build a lightweight persona only after the JTBD is clear, and anchor it to a real behavior pattern rather than an invented backstory (age/name/stock-photo personas rarely change a product decision).

**Segmentation check**: if the audience described could just as easily be "everyone," it isn't a target audience yet. Narrow until you can name who it deliberately excludes.

## 3. Market analysis

**Sizing**: TAM/SAM/SOM, built bottom-up from a unit economic (price × addressable users) rather than top-down from an industry report, which tends to overstate the reachable market:
- **TAM**: total demand for the category, if you had 100% share
- **SAM**: the slice reachable given your business model, geography, and channel
- **SOM**: what's realistically capturable in the next 1–3 years given competition and go-to-market capacity

**Positioning**: plot competitors on a 2×2 using the two axes that matter most to the buyer, not the two easiest to draw. Look for empty quadrants that are actually valuable, not just empty because no one wants to be there.

**Signal-gathering checklist** before claiming a market exists:
- evidence of people actively paying for a worse solution today
- evidence of switching behavior in the category
- at least one channel where the target audience is reachable at a known cost

## 4. Pricing strategy

Match the model to the product's stage and value-delivery pattern, not to what's trendy:

| Signal | Fitting model | Why |
|---|---|---|
| Value is clear and quantifiable per user/use (time saved, revenue generated, risk avoided) | Value-based pricing | Price tracks the outcome, not the cost to build |
| Usage varies widely across customers, cost-to-serve scales with usage | Usage-based / metered | Avoids overcharging light users and undercharging heavy ones |
| Product needs viral/network adoption before it's valuable | Freemium | Free tier is the acquisition channel, not the product |
| Buyers are enterprises with budget cycles and procurement | Tiered + custom enterprise tier | Matches how the budget actually gets approved |
| Commodity-like product, thin differentiation | Cost-plus / market-matching | Value-based pricing has no room to work without differentiation |
| Early-stage, no comparable, need fast market feedback | Penetration pricing, raise later | Prioritizes adoption data over margin at launch |

**Common mistakes to flag**:
- pricing set before any willingness-to-pay signal exists
- pricing copied from a competitor without checking cost structure
- a free tier generous enough that upgrading never becomes necessary
- for AI features, flat pricing with no check of the per-user model cost at heavy usage

## 5. Stakeholder analysis

**Power/interest grid**: for each stakeholder, plot power to affect the project against interest in its outcome:
- High power, high interest → manage closely, involve in decisions
- High power, low interest → keep satisfied, don't over-communicate
- Low power, high interest → keep informed, they can become advocates
- Low power, low interest → monitor, minimal effort

**RACI** for execution: for each major decision or deliverable, name who is Responsible (does the work), Accountable (owns the outcome, one person only), Consulted (input sought beforehand), and Informed (told after). A RACI with two "Accountable" names on one row is a sign the decision will stall.

## 6. KPIs

Structure metrics in three tiers, not a flat list:
- **North Star**: the one metric that best represents value delivered (see Goals above)
- **Input metrics**: the 2–4 levers the team can actually move that drive the North Star
- **Guardrail metrics**: metrics that must not regress while optimizing the others (e.g. don't grow signups by tanking retention)

**Every metric names the analytics event that measures it.** A metric with no defined event can't be reported on launch day. The event list goes in the PRD and becomes the developer's instrumentation task.

**Match KPIs to stage**. The same metric can be wrong at the wrong stage:

| Stage | Primary focus | Example metrics |
|---|---|---|
| Pre-launch | Problem validation | Waitlist signups, interview conversion, pre-orders |
| MVP / early | Activation, retention signal | Time-to-first-value, Day-1/Day-7 retention, qualitative feedback |
| Growth | Acquisition efficiency, expansion | LTV:CAC, referral rate, expansion revenue |
| Mature | Efficiency, defensibility | Net revenue retention, margin, churn by cohort |

**Leading vs lagging**: include at least one leading indicator (predicts future outcomes, e.g. activation rate) alongside lagging ones (confirm past outcomes, e.g. revenue). An all-lagging dashboard reports a problem only after it's too late to prevent it.

**AI-feature metrics**: model quality is invisible in usage numbers until users churn, so measure it directly:
- **Eval score**: offline quality score on a fixed, versioned test set of representative inputs. Use it as an input metric when improving the feature, and as a guardrail on every prompt or model change.
- **Task success rate**: share of sessions where the user got what they came for (accepted output, completed the flow). This is usually the North Star candidate for the feature.
- **Cost per successful task**: model spend divided by successful tasks, not per request. Retries and failures are part of the real cost.
- **Latency**: time to first token and total time, at p50 and p95.
- **Override / regeneration rate**: how often users edit, regenerate, or abandon output. This is a leading indicator of quality problems the eval set hasn't caught.

## 7. Requirements (PRD)

Requirements turn the strategy above into something the developer can build and test without guessing. Use `templates/prd.md`.

- **User stories in job form**: "When [situation], I want to [action], so I can [outcome]." The situation comes from the JTBD context, which keeps every story tied to the real job rather than to a feature someone thought of.
- **Acceptance criteria as Given/When/Then**: "Given [precondition], when [action], then [observable result]." Write at least one failure or edge case per story. The developer turns each criterion into an automated test, so a vague criterion becomes a vague test or no test at all.
- **Explicit non-goals**: list what v1 deliberately won't do. Non-goals are the cheapest scope control available, and they stop design and engineering from building toward an unstated future.
- **Every story gets a priority** (Must / Should / Could, see Prioritization), so scope can be cut deliberately when time runs short.

## 8. Prioritization

Pick the method by the decision being made. Load `references/prioritization.md` when scoring a backlog or running a Kano survey.

| Decision | Method | Why |
|---|---|---|
| Ranking a backlog of comparable items | **RICE** (Reach × Impact × Confidence ÷ Effort) | Forces an explicit estimate for each factor instead of a gut ranking |
| Cutting scope to hit a fixed date or release | **MoSCoW** | Answers "what ships if we run out of time," which RICE doesn't |
| Deciding which features differentiate vs. merely qualify | **Kano** | Separates must-haves (absence angers, presence is unnoticed) from delighters, which RICE scores the same |

RICE scores order a list; they aren't measurements. Two items within ~20% of each other are a tie, and an untested idea shouldn't carry high Confidence.

## 9. Customer discovery interviews

Interviews validate the problem and the current alternative, not the idea. Load `references/customer-interviews.md` for the script and synthesis method.

- **Ask about past behavior, never hypotheticals.** "Tell me about the last time you…" produces facts. "Would you use…?" produces polite fiction.
- **Don't pitch.** Once the idea is described, people start being nice about it, and the rest of the interview is contaminated.
- **Commitment is the only real signal.** Compliments and "I'd definitely pay for that" are noise. A follow-up meeting, an intro to a colleague, a pilot, or a pre-order is evidence.

## 10. Experiments and A/B tests

Load `references/experiments.md` before designing any test. It has the sample-size rule of thumb and the pre-registration checklist.

- **Write the hypothesis first:** "Because [evidence], we believe [change] for [segment] will move [primary metric] by at least [minimum detectable effect], without regressing [guardrails]."
- **Fix one primary metric, the guardrails, the minimum detectable effect, the sample size, and the duration before starting.** Each one decided after seeing data is a chance to fool yourself.
- **No peeking and early stopping.** Checking repeatedly and stopping at the first significant result inflates false positives well past the nominal 5%. If early looks are needed, choose a sequential method up front.
- **Don't A/B test when the traffic can't support it.** If the required sample takes more than ~4–6 weeks to collect, use qualitative usability tests, a fake-door test, or a staged rollout with a holdout instead.

## 11. Launch and go-to-market

Fill the Go-to-market section of the launch checklist (`../build-product/templates/launch-checklist.md`, written to `docs/launch-checklist.md`).

- **Positioning statement**: "For [audience] who [job], [product] is a [category] that [key benefit]. Unlike [current alternative], it [differentiator]." The current alternative comes from the JTBD. If it can't be filled in, positioning isn't settled.
- **Channel plan**: the one or two channels where the audience is reachable at a known cost (from the market signal checklist). A list of every channel is not a plan.
- **Launch tier, chosen by reversibility and risk**:
  - **silent**: shipped behind a flag to internal users or a handful of customers
  - **soft**: a limited cohort or beta, with no announcement
  - **full**: public announcement
  
  A first version of anything risky starts silent or soft.
- **Success criteria tied to KPIs**: a named metric, a target, and a date.
- **Kill / rollback criteria, written before launch**: which guardrail regression or missed floor triggers a rollback, and who makes the call. Without them, a failing launch gets rationalized instead of reversed.

## When to ask vs proceed

Some of these decisions are cheap to guess and revise later (a first-draft North Star for internal discussion). Others are expensive to get wrong (pricing that's about to be announced, a target audience that steers the whole roadmap, a launch going public). Don't guess silently on the expensive ones.

**Fallback logic, in order:**
1. An answer is already given (a stated audience, a stated goal, a stated price point) → use it, don't re-litigate it.
2. The brief clearly implies an answer via the framework's own criteria (e.g. "enterprise buyer with a procurement process" → tiered + custom enterprise pricing) → infer and proceed; state the choice and the one-line reasoning, so it's visible rather than silent.
3. A bare keyword appears without enough context ("we need KPIs," "who's this for," "how do we price it," "write a PRD") → don't guess from the noun alone. Ask using the questions below rather than inventing an audience, price, metric, or scope from nothing.
4. No signal, and the decision is high-stakes or hard to walk back (pricing about to be published, a target audience that will steer the roadmap, a stakeholder being left off a sign-off list, a full public launch) → ask before proceeding.
5. No signal, but the decision is low-stakes or easy to revise later (an early exploratory goal, a first-draft persona or PRD for internal discussion) → propose the most defensible default from the framework and say so. Don't block on asking every time; mark the guessed fields as assumptions in the document.

**Questions worth asking, by area:**
- **Goals**: What would have to be true in 90 days for this to count as working — is there a number, or only a feeling?
- **Audience**: Who deals with this problem today, and what do they currently do about it — including doing nothing?
- **Market**: Is there any evidence yet — a paid alternative, an active workaround, expressed interest — that this is a problem people will act on?
- **Pricing**: What's the cost basis, and how is the closest alternative priced today?
- **Stakeholders**: Who has to say yes for this to ship, and who's hurt if it fails?
- **KPIs**: If you could only check one number to know whether this is working, what would it be?
- **Requirements**: What must a user be able to do for v1 to count as done — and what is explicitly out?
- **Prioritization**: Is there a fixed date or scope to cut against, a backlog to rank, or a question about which features differentiate?
- **Interviews**: Who can you actually get access to, and what decision will the interviews inform?
- **Experiments**: How much eligible traffic does this surface get per week, and what's the smallest change that would be worth detecting?
- **Launch**: Who needs to hear about this, where do they already pay attention, and what result would make you roll it back?

## Red flags to surface proactively

- Target audience described broadly enough to include almost anyone
- No stated current alternative. If the audience isn't using anything today, the "problem" may not be painful enough to switch for.
- Pricing chosen before any signal of willingness to pay
- A pitch or roadmap with no named Accountable owner for key decisions
- KPIs that are all vanity/lagging (e.g. total signups, total downloads) with nothing measuring retention or value delivered
- A metric with no analytics event defined to measure it
- User stories with no acceptance criteria, or criteria with no failure/edge case. The developer will invent the behavior instead.
- A PRD with no non-goals
- RICE scores treated as precise, or high Confidence on an idea no user has seen
- Interview "validation" built on compliments or answers to "would you use this?"
- An A/B test started without a pre-set sample size and duration, or stopped the first time it looked significant
- A launch with success criteria but no kill/rollback criteria
- An AI feature with no eval set, where quality is judged only by anecdotes
