# Ambient Gradient

A soft, glowing style built from gradient meshes and diffused light rather than hard edges or flat colour. Depth comes from bloom, not shadow. Feels warm, sophisticated, and slightly futuristic — the visual language most associated right now with AI-powered and premium fintech products.

**When to reach for this style:** premium fintech, AI-forward products wanting to feel intelligent and human at once, onboarding flows where the goal is to build trust and calm before asking for commitment, any product where "warm but sophisticated" beats "playful" or "stark."

**When to avoid it:** data-dense dashboards (gradient becomes visual noise once you have more than a couple of focal elements), enterprise B2B wanting to feel stark/decisive, anything with strict accessibility contrast requirements handled carelessly — gradients can quietly fail contrast ratios if not checked.

## UX psychology behind this style

- **Biophilic colour association:** soft, organic gradient blends (sunset, aurora, dawn-light hues) tap into evolved associations with natural light and safe environments, lowering perceived risk before a user has processed any actual information. This is doing real work in the Fintar source example — a "High returns strategy / RISK: ELEVATED" card sits inside a warm pink-to-yellow gradient, which primes optimism ahead of the risk disclosure. Worth using deliberately, not by default — softening a genuine risk signal with warmth can tip into manipulative if the gradient is chosen to *offset* rather than *complement* the content.
- **Shape-personality association (circles vs. rectangles):** circular and orb-like forms read as organic, unified, and non-threatening compared to rectangles, which read as structured/mechanical. The glowing orb as hero visual is doing more trust-building work than any copy on the screen.
- **Colour-as-sophistication signal:** gradient mesh has become closely associated with generative AI and "intelligent" product branding over the past few years — using it primes an expectation of the product being adaptive/smart before any feature is demonstrated.
- **Single-focal-point reduction of decision friction:** the onboarding screen has exactly one visual anchor (the orb) and one action (the CTA) — this matters most at the highest-stakes moment in a flow, where every extra element increases the odds of hesitation or drop-off.

## Colour

- Gradient mesh spanning warm-to-cool: pink → purple → magenta, sometimes extending into yellow at one edge for warmth. Soft, not harsh — no hard colour stops.
- Base canvas is white or near-white (`#FAFAFC`-ish) outside the gradient elements — the gradient is a focal device, not a background wash for the whole screen.
- True black used sparingly and deliberately for the highest-contrast CTA — this is the one place the style breaks from softness, and it works precisely because everything else is soft.
- Suggested tokens:
  - `--gradient-start: #E85D9E` (pink)
  - `--gradient-mid: #8B5CF6` (purple)
  - `--gradient-end: #FDE68A` (soft yellow, used as an edge accent, not a dominant tone)
  - `--surface-base: #FAFAFC`
  - `--cta-anchor: #0A0A0A`

## Depth & elevation

- No hard-edged shadows. Depth comes from radial glow/bloom — a soft light diffusion around the hero shape, achieved with blurred, low-opacity colour layers rather than a drop-shadow.
- Gradient-filled cards don't need a shadow to feel elevated — the colour transition itself reads as dimensional.
- Where a shadow is unavoidable (e.g. a white card on a white background), keep it extremely soft and diffuse — never a sharp, defined edge.

## Shape language

- Fully rounded corners throughout — cards, buttons, and containers all use generous radius (16–24px or more).
- Circular/orb motifs work well as hero visuals or decorative accents.
- Pill-shaped buttons are consistent with the rest of the rounded language.

## Typography

- Bold, confident sans-serif headlines with generous line-height — the type should feel calm, not urgent.
- High-contrast black text on the white base for legibility; white text on the gradient cards where the gradient is dark/saturated enough to support it (check contrast — this is the easiest place for this style to fail accessibility).
- Supporting copy stays smaller and lower-contrast (grey), keeping the headline as the clear single focal point.

## Spacing & layout

- Generous whitespace, especially around the hero moment — this style needs room to breathe or the gradient reads as cluttered rather than premium.
- Mobile hero screens favour a single centred focal element; dashboard-style layouts (multiple gradient cards) should still give each card enough surrounding space that they don't visually merge.

## Mobile adaptation

- Full-screen hero moments work best for this style — the orb/gradient as the entire visual field, with headline and single CTA anchored at the bottom.
- Reserve the gradient for the moment that most needs emotional framing (onboarding, a key decision point) rather than using it on every screen — overuse dilutes its impact.

## Desktop / web adaptation

- Gradient cards can sit side-by-side in a grid rather than taking over the full screen — the gradient becomes an accent within a broader white-based dashboard rather than a full takeover.
- Hover states can subtly intensify the glow or shift the gradient angle slightly — a lift/shadow-based hover would import a depth language this style doesn't otherwise use.
- On data-dense desktop views, limit gradient elements to genuinely important cards (e.g. a featured strategy or key metric) rather than applying it broadly — the same restraint logic as mobile, just at greater scale.

## Do / Don't

| Do | Don't |
|---|---|
| Soft, multi-colour gradient blends | Hard colour stops or single flat gradients |
| Glow/bloom for depth | Sharp drop-shadows |
| Fully rounded corners | Sharp/rectangular edges |
| One clear focal point per screen | Gradient applied to every element indiscriminately |
| Black used sparingly for high-contrast anchors | Black used broadly (undercuts the softness) |
