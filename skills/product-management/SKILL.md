---
name: product-management
description: Use this skill when defining or evaluating a product's direction — setting product goals, identifying and validating target audience, sizing or analyzing a market, choosing a pricing strategy, mapping stakeholders, or picking KPIs. Trigger for questions like "who is this for," "how should we price this," "what should we measure," "is there a market for this," or when reviewing a product idea, pitch, or roadmap for gaps in any of these areas — even without an explicit product-management question.
---

# Product Management

Frameworks for turning a product idea into a defensible plan: what it's for, who it's for, whether the market supports it, what it costs, who needs to sign off, and how success is measured.

## How to use this skill

1. Identify which of the six areas below the request actually touches (often more than one).
2. Apply the matching framework rather than generic advice — each one below has a specific method, not just a checklist.
3. If the brief is missing something a framework needs (no stated audience, no pricing signal, no success metric), follow the **when to ask vs proceed** logic below rather than always defaulting silently.
4. When reviewing an existing plan or pitch, actively check it against the "Red flags" section at the end — surface gaps even if not asked.

## 1. Product goals

A goal needs a **North Star metric** (the single number that best reflects the value the product delivers to users) plus supporting **OKRs**:

- **Objective**: qualitative, ambitious, time-bound ("Become the default tool for X by Q3")
- **Key Results**: 2–4 quantitative, verifiable outcomes that would prove the objective is met — not activities. "Ship the onboarding flow" is an activity; "Reduce time-to-first-value from 8 minutes to 2" is a key result.

A goal that can't be falsified isn't a goal yet — if you can't describe what evidence would prove it failed, tighten it.

## 2. Target audience

Use **Jobs to Be Done (JTBD)** over demographic personas as the default — demographics describe who, JTBD explains why they'd switch:

- **Job**: the progress the person is trying to make, stated as a verb phrase ("get my expenses approved faster"), not a product category
- **Context**: the situation that triggers the need
- **Current alternative**: what they use today, including "do nothing" or a manual workaround — this is the real competitor, not just other products in the category
- **Switching trigger**: the specific frustration or event that would make them try something new

Build a lightweight persona only after the JTBD is clear, and anchor it to a real behavior pattern rather than an invented backstory (age/name/stock photo personas rarely change a product decision).

**Segmentation check**: if the audience described could just as easily be "everyone," it isn't a target audience yet. Narrow until you can name who it deliberately excludes.

## 3. Market analysis

**Sizing** — TAM/SAM/SOM, built bottom-up from a unit economic (price × addressable users) rather than top-down from an industry report, which tends to overstate reachable market:
- **TAM**: total demand for the category, if you had 100% share
- **SAM**: the slice reachable given your business model, geography, and channel
- **SOM**: what's realistically capturable in the next 1–3 years given competition and go-to-market capacity

**Positioning** — plot competitors on a 2×2 using the two axes that matter most to the buyer (not the two easiest to draw). Look for empty quadrants that are actually valuable, not just empty because no one wants to be there.

**Signal-gathering checklist** before claiming a market exists: evidence of people actively paying for a worse solution today, evidence of switching behavior in the category, and at least one channel where the target audience is reachable at a known cost.

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

**Common mistakes to flag**: pricing set before any willingness-to-pay signal exists, pricing copied from a competitor without checking cost structure, and a free tier generous enough that upgrading never becomes necessary.

## 5. Stakeholder analysis

**Power/interest grid** — for each stakeholder, plot power to affect the project against interest in its outcome:
- High power, high interest → manage closely, involve in decisions
- High power, low interest → keep satisfied, don't over-communicate
- Low power, high interest → keep informed, they can become advocates
- Low power, low interest → monitor, minimal effort

**RACI** for execution — for each major decision or deliverable, name who is Responsible (does the work), Accountable (owns the outcome, one person only), Consulted (input sought beforehand), and Informed (told after). A RACI with two "Accountable" names on one row is a sign the decision will stall.

## 6. KPIs

Structure metrics in three tiers, not a flat list:
- **North Star**: the one metric that best represents value delivered (see Goals above)
- **Input metrics**: the 2–4 levers the team can actually move that drive the North Star
- **Guardrail metrics**: metrics that must not regress while optimizing the others (e.g. don't grow signups by tanking retention)

**Match KPIs to stage** — the same metric can be wrong at the wrong stage:

| Stage | Primary focus | Example metrics |
|---|---|---|
| Pre-launch | Problem validation | Signups on a waitlist, interview conversion, pre-orders |
| MVP / early | Activation, retention signal | Time-to-first-value, Day-1/Day-7 retention, qualitative feedback |
| Growth | Acquisition efficiency, expansion | CAC:LTV, referral rate, expansion revenue |
| Mature | Efficiency, defensibility | Net revenue retention, margin, churn by cohort |

**Leading vs lagging**: prefer at least one leading indicator (predicts future outcomes, e.g. activation rate) alongside lagging ones (confirm past outcomes, e.g. revenue) — an all-lagging dashboard tells you about a problem only after it's too late to prevent it.

## When to ask vs proceed

Some of these decisions are cheap to guess and revise later (a first-draft North Star for internal discussion); others are expensive to get wrong (pricing that's about to be announced, a target audience that steers the whole roadmap). Don't guess silently on the expensive ones.

**Fallback logic, in order:**
1. An answer is already given (a stated audience, a stated goal, a stated price point) → use it, don't re-litigate it.
2. The brief clearly implies an answer via the framework's own criteria (e.g. "enterprise buyer with a procurement process" → tiered + custom enterprise pricing) → infer and proceed; state the choice and the one-line reasoning, so it's visible rather than silent.
3. A bare keyword appears without enough context ("we need KPIs," "who's this for," "how do we price it") → don't guess from the noun alone. Ask using the questions below rather than inventing an audience, price, or metric from nothing.
4. No signal, and the decision is high-stakes or hard to walk back (pricing about to be published, a target audience that will steer the roadmap, a stakeholder being left off a sign-off list) → ask before proceeding.
5. No signal, but the decision is low-stakes or easy to revise later (an early exploratory goal, a first-draft persona for internal discussion) → propose the most defensible default from the framework and say so — don't block on asking every time.

**Questions worth asking, by area:**
- **Goals**: What would have to be true in 90 days for this to count as working — is there a number, or only a feeling?
- **Audience**: Who deals with this problem today, and what do they currently do about it — including doing nothing?
- **Market**: Is there any evidence yet — a paid alternative, an active workaround, expressed interest — that this is a problem people will act on?
- **Pricing**: What's the cost basis, and how is the closest alternative priced today?
- **Stakeholders**: Who has to say yes for this to ship, and who's hurt if it fails?
- **KPIs**: If you could only check one number to know whether this is working, what would it be?

## Red flags to surface proactively

- Target audience described broadly enough to include almost anyone
- No stated current alternative — if the audience isn't using anything today, the "problem" may not be painful enough to switch for
- Pricing chosen before any signal of willingness to pay
- A pitch or roadmap with no named Accountable owner for key decisions
- KPIs that are all vanity/lagging (e.g. total signups, total downloads) with nothing measuring retention or value delivered
