# Swiss Technical

A neutral-ground, grid-driven style rooted in Swiss/International Typographic design and technical-drawing aesthetics. Built from a visible structural grid, monospace eyebrow labels, numbered sections, and oversized two-tone headlines. Feels precise, rigorous, and engineered — the visual language of a product that wants to signal technical seriousness rather than warmth or approachability.

**When to reach for this style:** developer tools, security/infrastructure products, technical B2B marketing sites, anything where the audience is technical and "precise and rigorous" beats "friendly and soft." Especially strong for products whose value proposition is about correctness, detection, or engineering discipline — the aesthetic itself reinforces the claim.

**When to avoid it:** consumer products aimed at non-technical audiences (the schematic/blueprint language reads as cold or intimidating), wellness or lifestyle contexts, anything where emotional warmth is the goal — this style deliberately withholds it.

## UX psychology behind this style

- **Schematic-authority association:** monospace labels, crosshair grid markers, and technical-drawing motifs borrow the visual language of engineering blueprints and code, which primes an expectation of precision and correctness before any claim is read. For a security or developer product, the aesthetic is *itself* an argument — it says "we are rigorous" without stating it.
- **Visible grid as processing-fluency aid:** an explicit, consistent grid (with crosshair markers at intersections) makes the underlying structure legible, reducing the interpretive load of figuring out how the page is organised. The order feels intentional, and intentionality reads as competence — worth being deliberate about, since it's doing persuasive work, not just decorative.
- **Numbered-section wayfinding:** explicit sequence numbers (01 / 02 / 03) chunk content into an ordered mental model and support recall ("it was the third advantage"), the same chunking benefit Bold Flat Blocks gets from colour, achieved here through enumeration instead.
- **Restraint as premium signal:** a near-monochrome neutral ground with only occasional small colour-block accents reads as confident and disciplined — the design equivalent of not over-explaining. Sparse colour also means the few accent blocks (periwinkle, acid yellow) draw the eye precisely where intended (Von Restorff, applied through scarcity rather than saturation).
- **Two-tone headline as guided reading:** splitting a headline into a neutral part and an accent-colour part ("Agent security, *enforced at every PR*") directs the eye to the emphasised phrase first, letting typography carry the messaging hierarchy without extra UI.

## Colour

- Near-white / off-white base (`#F4F4F0`–`#FAFAF8`) — warm-neutral rather than pure white, closer to paper than screen.
- True black for primary type and rules.
- One primary accent (blue/`#2E4BFF`-ish) used for the emphasised headline word, small labels, and CTAs.
- Sparse secondary accent blocks — soft periwinkle (`#C8CCF5`) and acid yellow (`#E8F04E`) — used only on small feature cards, never as full-bleed fills.
- Ink `#0A0A0A` is `--text-primary` and the rule colour; `#2E4BFF` is the semantic `--accent`. Full token set below.

## Tokens

This is the full semantic set from `tokens-handoff.md`, checked against WCAG 2.2 AA in both modes, including ink on the periwinkle and acid-yellow cards. The dark block is shown with a bare `[data-theme="dark"]` selector; `tokens-handoff.md` has the full system-preference wrapper.

```css
/* light (paper) */
:root {
  --surface-base: #F5F5F1;      /* paper */
  --surface-raised: #FAFAF8;    /* separated by hairline, not shadow */
  --surface-overlay: #FFFFFF;   /* menus, dialogs: 1px ink border */
  --text-primary: #0A0A0A;      /* ink */
  --text-secondary: #55554F;
  --text-on-accent: #FFFFFF;
  --border: #CFCFC8;            /* visible grid lines */
  --border-strong: #0A0A0A;     /* section rules, inputs */
  --accent: #2E4BFF;            /* emphasised headline phrase, numbered markers, CTAs */
  --accent-hover: #1F36D6;
  --focus-ring: #2E4BFF;
  --success: #1A7F37;  --text-on-success: #FFFFFF;
  --warning: #8A5A00;  --text-on-warning: #FFFFFF;
  --danger:  #CF222E;  --text-on-danger:  #FFFFFF;
  --accent-soft: #C8CCF5;       --text-on-accent-soft: #0A0A0A;       /* periwinkle feature card */
  --accent-highlight: #E8F04E;  --text-on-accent-highlight: #0A0A0A;  /* acid-yellow feature card */
}
```

```css
/* dark (blueprint) */
[data-theme="dark"] {
  --surface-base: #101010;
  --surface-raised: #161616;
  --surface-overlay: #1C1C1C;
  --text-primary: #EDEDE8;
  --text-secondary: #A3A39B;
  --text-on-accent: #0A0A0A;
  --border: #2E2E2B;
  --border-strong: #EDEDE8;
  --accent: #6B80FF;
  --accent-hover: #8D9CFF;
  --focus-ring: #8D9CFF;
  --success: #4AC26B;  --text-on-success: #0A0A0A;
  --warning: #D9A400;  --text-on-warning: #0A0A0A;
  --danger:  #FF6B6B;  --text-on-danger:  #0A0A0A;
  --accent-soft: #2A2F5C;       --text-on-accent-soft: #EDEDE8;
  --accent-highlight: #E8F04E;  --text-on-accent-highlight: #0A0A0A;  /* stays acid: it's the one loud note */
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 0;  --radius-md: 2px;  --radius-lg: 4px;
  --rule-width: 1px;  --grid-columns: 12;  --grid-gutter: 24px;  --crosshair-size: 9px;
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;
  --font-sans: "Inter Tight", "Helvetica Neue", Arial, sans-serif;            /* grotesque: headlines + body */
  --font-mono: "JetBrains Mono", "IBM Plex Mono", ui-monospace, monospace;    /* eyebrows, numbers, annotations */
  --text-xs: 0.75rem;  --text-sm: 0.875rem;  --text-base: 1rem;  --text-lg: 1.25rem;  --text-xl: 2rem;
  --text-2xl: clamp(2.5rem, 1.5rem + 4vw, 3.5rem);
  --text-3xl: clamp(3.5rem, 2rem + 7vw, 5.5rem);  /* two-tone hero headline, tight tracking */
  --shadow-sm: none;  --shadow-md: none;  --shadow-lg: none;
  --duration-fast: 100ms;  --duration-base: 160ms;  --duration-slow: 240ms;
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);    /* precise: no overshoot, no bounce */
}
```

- **Mono eyebrow labels at `--text-xs` use `--text-primary` or `--accent`**, never `--text-secondary`. Small, uppercase, monospace text is already the hardest to read on the page, so it needs the strongest contrast available.
- **Grid lines (`--border`) are decorative and exempt from contrast minimums.** Anything that marks an interactive boundary uses `--border-strong`.

## Depth & elevation

- Flat — no drop shadows, no blur, no gradients for depth.
- Structure is communicated by the grid, hairline rules, and crosshair markers rather than by elevation.
- Isometric line-art illustrations provide visual interest and a sense of dimensionality without importing UI shadow language.

## Shape language

- Sharp or minimally-rounded corners (0–4px) — the style favours precision over softness.
- Thin hairline rules (1px) as dividers and grid lines.
- Crosshair / plus (`+`) markers at grid intersections — a signature motif of this style, evoking technical drawings and registration marks.
- Small rectangular feature cards, flat-filled with accent colour, no rounding beyond minimal.

## Typography

- Two typefaces working together: a clean grotesque/neo-grotesque sans for headlines (tight tracking, large scale) and a monospace for eyebrow labels, section numbers, and small technical annotations.
- Oversized headlines with two-tone colour treatment (neutral + accent word).
- Monospace eyebrow labels in small uppercase (`OUR SOLUTION`, `WHY IT MATTERS`, `HOW IT WORKS`) preceding each section.
- Numbered section markers (01, 02, 03) in monospace, often in the accent colour.

## Spacing & layout

- Strict, visible column grid — the grid isn't just a build tool here, it's part of the aesthetic and should be perceptible.
- Generous whitespace on the neutral ground; content aligned rigorously to grid lines.
- Asymmetric but grid-locked layouts — feature cards of varying sizes arranged on a shared modular grid, not a uniform row.
- Crosshair markers placed at key grid intersections to make the structure explicit.

## Mobile adaptation

- Collapse the multi-column grid to a single column, but keep the monospace eyebrow labels and numbered sections — they carry the style's identity even without the full grid visible.
- Stack the small accent-colour feature cards vertically, full-width.
- Maintain the two-tone headline treatment; scale headlines down but keep them oversized relative to body copy.
- The crosshair markers can be reduced or dropped on the tightest mobile layouts where a full grid isn't visible, but retain at least section-level structural cues.

## Desktop / web adaptation

- This style is effectively desktop/web-first — the visible modular grid, crosshair markers, and multi-size card arrangements need width to read properly.
- Use the full column grid with asymmetric card sizes locked to it; let whitespace and hairline rules do the structural work.
- Hover states should stay flat and precise — an accent-colour underline, a border shift, or a label change, never a shadow-lift or scale transform.
- Isometric line-art works well as large section illustrations on desktop where there's room for the detail to register.

## Dark mode

The dark version is a blueprint rather than paper: near-black ground, light ink, and the grid still visible.

- **Keep the grid visible.** Hairlines drop to `#2E2E2B`, which is subtle but present. Losing the grid in dark mode loses the style's main signature. Crosshair markers switch to `--text-secondary` so they stay findable.
- **Blue lightens to `#6B80FF` and takes ink-coloured text.** Saturated `#2E4BFF` on near-black is only about 3.2:1. That's enough for a boundary, not for the accent-coloured headline phrase, and it vibrates.
- **Periwinkle cards become deep indigo (`#2A2F5C`) with light text. Acid yellow stays acid** with dark text. It's the one loud note, and it works even harder on dark, so use it on even fewer cards.
- **Isometric line-art inverts to light strokes.** Check that illustrations don't ship as dark-stroke PNGs on transparent backgrounds, because those vanish on the dark ground.
- **Don't use the paper's warmth on the dark ground.** A warm-tinted dark reads as brown. Keep the dark ground neutral, since precision is the point.

## Do / Don't

| Do | Don't |
|---|---|
| Warm-neutral paper-like base as the default | Pure white, or dark as the default theme (dark is an option, not the identity) |
| Visible modular grid + crosshair markers | Hiding the grid entirely |
| Monospace eyebrow labels + numbered sections | Generic sentence-case labels |
| Two-tone oversized headlines | Single-colour, uniformly-weighted headlines |
| Sparse accent-colour cards | Full-bleed saturated colour fills |
| Flat, hairline-ruled structure | Drop shadows or gradient depth |
