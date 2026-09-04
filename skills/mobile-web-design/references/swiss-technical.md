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
- Suggested tokens:
  - `--surface-base: #F5F5F1`
  - `--ink: #0A0A0A`
  - `--accent-primary: #2E4BFF`
  - `--accent-soft: #C8CCF5`
  - `--accent-highlight: #E8F04E`

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

## Do / Don't

| Do | Don't |
|---|---|
| Warm-neutral paper-like base | Pure white or dark backgrounds |
| Visible modular grid + crosshair markers | Hiding the grid entirely |
| Monospace eyebrow labels + numbered sections | Generic sentence-case labels |
| Two-tone oversized headlines | Single-colour, uniformly-weighted headlines |
| Sparse accent-colour cards | Full-bleed saturated colour fills |
| Flat, hairline-ruled structure | Drop shadows or gradient depth |
