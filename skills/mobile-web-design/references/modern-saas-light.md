# Modern SaaS Light

A polished, white-based style with gradient accents reserved for data visualisation and soft, friendly shape language throughout. This is the current default visual convention for consumer and prosumer SaaS — approachable and professional at once, closely following patterns popularised by products like Linear and Stripe.

**When to reach for this style:** consumer or prosumer SaaS, general-purpose product dashboards, startups wanting to feel modern and premium without being intimidating or clinical.

**When to avoid it:** internal ops tools where personality is a distraction rather than an asset (reach for Soft Minimal Dashboard instead), or any product wanting genuine visual differentiation — this style is now a widely recognised convention, which means low novelty and low differentiation are part of the trade-off.

## UX psychology behind this style

- **Gradient reserved for data visualisation only:** because colour and gradient appear *only* inside charts, they draw the eye directly to the metric worth attention without desensitising users to gradient elsewhere in the UI. This selective use is what keeps the "premium" cue meaningful — if gradient appeared everywhere, it would lose its signalling power (the same principle as colour-as-meaning, applied specifically to gradient rather than solid colour).
- **Pill-shaped buttons and tags as friendliness cues:** soft, fully rounded forms read as less aggressive and more approachable than sharp rectangles (shape-personality research consistently finds this), which balances the "professional" tone of a SaaS dashboard against feeling cold or intimidating to a prosumer audience.
- **Large numeric focal points and achievement framing:** oversized bold numerals for headline metrics (page views, revenue, subscriber count) leverage the "big number" convention, which draws immediate attention and creates a sense of scale/achievement — deliberately used in growth-metric-driven products to make progress feel tangible at a glance.
- **Convention familiarity reduces learning curve:** because this style closely follows widely recognised SaaS dashboard patterns, users who've encountered similar tools transfer their mental model instantly — lower cognitive cost to onboard, at the direct cost of differentiation. Worth being explicit with stakeholders about this trade-off if brand distinctiveness matters to them.
- **Whitespace as a premium/quality cue:** generous negative space around cards has a long-standing association with luxury and confidence in visual design — implying the product doesn't need to fill every pixel to prove its value, versus a denser layout that can read as scrappier or lower-cost.

## Colour

- White base canvas, light-grey secondary surfaces for the sidebar/background.
- Indigo, purple, and teal gradients used specifically and only within data visualisation elements (bar charts, donut charts) — never as a general UI accent.
- Black/dark-grey for primary text, mid-grey for secondary/supporting text.
- Small coloured pill tags for categorisation (used sparingly, one colour per category type).

## Depth & elevation

- Soft shadows on cards — a touch more pronounced than Soft Minimal Dashboard's near-invisible shadows, giving cards a slightly more "lifted," tactile feel appropriate to a consumer-facing product.
- Subtle border/frame around the overall container is acceptable (the source shows this inside a browser chrome), reinforcing a clean, contained feel.

## Shape language

- Medium-rounded cards (12–16px radius) — softer than Soft Minimal Dashboard, not as extreme as Ambient Gradient.
- Pill-shaped buttons and status/category tags throughout.
- Rounded avatar images and icon containers.

## Typography

- Clean, modern sans-serif throughout.
- Large, bold numerals for headline metrics — these are the clear visual anchors of the layout.
- Small uppercase or medium-weight labels for section headers and context, kept clearly subordinate to the metric values.

## Spacing & layout

- Generous spacing between cards — breathing room is part of the "premium" read, not just a density choice.
- Comfortable grid gutters; sidebar plus a flexible multi-card main content grid.
- Cards group related metrics (e.g. Page Views / Total Revenue / Bounce Rate as a row) with consistent sizing across the row.

## Mobile adaptation

- Stack cards vertically in a single column, keeping the large numeric metrics prominent as scroll-stopping focal points even as the layout condenses.
- Collapse the sidebar into a bottom tab bar or hamburger menu.
- Keep pill-shaped buttons and tags — they're already touch-friendly given their rounded, generously-sized form.
- Prioritise the 2–3 most important metrics above the fold; defer secondary charts further down rather than shrinking everything to fit.

## Desktop / web adaptation (native to this style)

- Persistent sidebar navigation, as shown in the source.
- Multi-column card grid with charts and tables able to sit side-by-side.
- Hover states on interactive rows, cards, and chart segments (e.g. highlighting a specific bar or segment on hover) — consistent with the friendly, tactile feel of the rest of the style.
- The style is effectively designed browser-first (the source frames it inside actual browser chrome) — treat desktop/web as the primary canvas, with mobile as the adapted condensation rather than the other way around.

## Do / Don't

| Do | Don't |
|---|---|
| White base, gradient only in data viz | Gradient used as a general UI accent |
| Pill-shaped buttons and tags | Sharp-edged buttons (undercuts the approachable tone) |
| Large bold numerals as focal points | Uniform type sizing that buries key metrics |
| Generous card spacing | Cramming cards edge-to-edge |
| Soft, tactile card shadows | Flat, shadowless cards (reads as the wrong style entirely) |
