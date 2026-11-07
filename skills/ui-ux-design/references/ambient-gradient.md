# Ambient Gradient

A soft, glowing style built from gradient meshes and diffused light rather than hard edges or flat colour. Depth comes from bloom, not shadow. Feels warm, sophisticated, and slightly futuristic — the visual language most associated right now with AI-powered and premium fintech products.

**When to reach for this style:** premium fintech, AI-forward products wanting to feel intelligent and human at once, onboarding flows where the goal is to build trust and calm before asking for commitment, any product where "warm but sophisticated" beats "playful" or "stark."

**When to avoid it:** data-dense dashboards (gradient becomes visual noise once you have more than a couple of focal elements), enterprise B2B wanting to feel stark/decisive, anything with strict accessibility contrast requirements handled carelessly — gradients can quietly fail contrast ratios if not checked.

## UX psychology behind this style

- **Biophilic colour association:** soft, organic gradient blends (sunset, aurora, dawn-light hues) tap into evolved associations with natural light and safe environments, lowering perceived risk before a user has processed any actual information. For example, a "High returns strategy / RISK: ELEVATED" investment card set inside a warm pink-to-yellow gradient primes optimism before the risk disclosure is even read. Worth using deliberately, not by default — softening a genuine risk signal with warmth can tip into manipulative if the gradient is chosen to *offset* rather than *complement* the content.
- **Shape-personality association (circles vs. rectangles):** circular and orb-like forms read as organic, unified, and non-threatening compared to rectangles, which read as structured/mechanical. The glowing orb as hero visual is doing more trust-building work than any copy on the screen.
- **Colour-as-sophistication signal:** gradient mesh has become closely associated with generative AI and "intelligent" product branding over the past few years — using it primes an expectation of the product being adaptive/smart before any feature is demonstrated.
- **Single-focal-point reduction of decision friction:** an onboarding screen in this style has exactly one visual anchor (the orb) and one action (the CTA) — this matters most at the highest-stakes moment in a flow, where every extra element increases the odds of hesitation or drop-off.

## Colour

- Gradient mesh spanning warm-to-cool: pink → purple → magenta, sometimes extending into yellow at one edge for warmth. Soft, not harsh — no hard colour stops.
- Base canvas is white or near-white (`#FAFAFC`-ish) outside the gradient elements — the gradient is a focal device, not a background wash for the whole screen.
- True black used sparingly and deliberately for the highest-contrast CTA — this is the one place the style breaks from softness, and it works precisely because everything else is soft.
- Gradient stops: pink `#E85D9E`, purple `#8B5CF6`, and soft yellow `#FDE68A` used as an edge accent, not a dominant tone. The black CTA anchor becomes the semantic `--accent`. Full token set below.

## Tokens

This is the full semantic set from `tokens-handoff.md`, checked against WCAG 2.2 AA in both modes, including text against every gradient stop. The dark block is shown with a bare `[data-theme="dark"]` selector; `tokens-handoff.md` has the full system-preference wrapper.

```css
/* light */
:root {
  --surface-base: #FAFAFC;
  --surface-raised: #FFFFFF;
  --surface-overlay: #FFFFFF;
  --text-primary: #0A0A0A;
  --text-secondary: #5E5A6B;
  --text-on-accent: #FFFFFF;
  --border: #ECE9F2;
  --border-strong: #8E889C;
  --accent: #0A0A0A;            /* the black CTA anchor: the one hard element */
  --accent-hover: #2A2730;
  --focus-ring: #7C3AED;
  --success: #15803D;  --text-on-success: #FFFFFF;
  --warning: #B45309;  --text-on-warning: #FFFFFF;
  --danger:  #C81E1E;  --text-on-danger:  #FFFFFF;  /* deliberately redder than the pink stop, so the gradient never reads as an error */
  --gradient-start: #E85D9E;    /* pink */
  --gradient-mid: #8B5CF6;      /* purple */
  --gradient-end: #FDE68A;      /* soft yellow edge accent */
  --gradient-mesh: radial-gradient(at 20% 20%, #E85D9E 0, transparent 55%), radial-gradient(at 80% 30%, #8B5CF6 0, transparent 55%), radial-gradient(at 60% 90%, #FDE68A 0, transparent 50%);
  --text-on-gradient: #0A0A0A;  /* passes on every stop; see note below */
  --glow: 0 0 64px rgb(139 92 246 / 0.30);
}
```

```css
/* dark */
[data-theme="dark"] {
  --surface-base: #0C0A12;
  --surface-raised: #16131F;
  --surface-overlay: #201C2B;
  --text-primary: #F5F3FA;
  --text-secondary: #ADA6BD;
  --text-on-accent: #0C0A12;
  --border: #2B2638;
  --border-strong: #736A88;
  --accent: #F5F3FA;            /* the anchor inverts: off-white CTA on dark */
  --accent-hover: #DCD7E6;
  --focus-ring: #A78BFA;
  --success: #4ADE80;  --text-on-success: #052E16;
  --warning: #FBBF24;  --text-on-warning: #1F1300;
  --danger:  #F87171;  --text-on-danger:  #2A0505;
  --gradient-start: #EC6AA8;
  --gradient-mid: #8B5CF6;
  --gradient-end: #FDE68A;
  --text-on-gradient: #0C0A12;
  --glow: 0 0 80px rgb(139 92 246 / 0.45);
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 12px;  --radius-md: 20px;  --radius-lg: 28px;  --radius-full: 9999px;
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;  /* hero moments: --space-7 and up around the focal element */
  --font-sans: "Manrope", ui-sans-serif, system-ui, sans-serif;
  --font-mono: ui-monospace, monospace;
  --text-xs: 0.8125rem;  --text-sm: 0.9375rem;  --text-base: 1.0625rem;  --text-lg: 1.25rem;  --text-xl: 1.75rem;
  --text-2xl: clamp(2rem, 1.5rem + 2vw, 2.5rem);
  --text-3xl: clamp(2.5rem, 1.75rem + 3.5vw, 3.5rem);
  --shadow-sm: 0 2px 12px rgb(30 20 60 / 0.04);   /* only for white-on-white cards; depth is --glow otherwise */
  --shadow-md: 0 8px 32px rgb(30 20 60 / 0.06);
  --shadow-lg: 0 16px 48px rgb(30 20 60 / 0.10);
  --duration-fast: 150ms;  --duration-base: 260ms;  --duration-slow: 480ms;  /* calm, unhurried */
  --ease-standard: cubic-bezier(0.3, 0, 0, 1);
}
```

- **Dark text on gradients by default.** `--text-on-gradient` (near-black) clears 4.5:1 on all three stops. White text fails on the pink stop (3.2:1) and on the purple (4.2:1), so white is allowed only for large headline text (≥24px, 3:1) sitting entirely over the purple region. When a mesh shifts under the text, check the lightest point beneath it.
- **Animated mesh drift** stops under `prefers-reduced-motion`; a static mesh carries the style fine.

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

## Dark mode

Bloom actually works *better* on dark than on light. Glow is light, and light reads strongest against darkness. So this style translates well, provided restraint holds.

- **Use a deep violet-black base, not neutral black.** A warm-cool tinted base (`#0C0A12`) lets the gradient feel like it's emitting light into the room rather than sitting on a void.
- **The CTA anchor inverts** from black to off-white. It is still the single hardest-edged element on screen, so it keeps its job as the one break from softness.
- **Turn the glow up and the gradient area down.** On dark, a smaller gradient shape with a stronger `--glow` gives the same emotional weight as a larger one on light. Full-screen gradient washes on dark become overwhelming and drain OLED batteries.
- **Keep dark text on gradient cards.** The mesh stays light enough that near-black text still passes, which avoids the most common failure of this style: white text on pink.

## Do / Don't

| Do | Don't |
|---|---|
| Soft, multi-colour gradient blends | Hard colour stops or single flat gradients |
| Glow/bloom for depth | Sharp drop-shadows |
| Fully rounded corners | Sharp/rectangular edges |
| One clear focal point per screen | Gradient applied to every element indiscriminately |
| Black used sparingly for high-contrast anchors | Black used broadly (undercuts the softness) |
