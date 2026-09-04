# Bold Flat Blocks

A high-contrast, shadowless style built from solid colour panels. No gradients, no blur, no elevation — hierarchy comes entirely from colour, scale, and contrast. Reaches for a confident, almost brutalist energy; works well for brands that want to feel decisive rather than soft.

**When to reach for this style:** the brief calls for something bold, punchy, confident, high-contrast, "no-nonsense," or explicitly anti-skeuomorphic. Good fit for B2B/enterprise products that want to stand out from the sea of soft SaaS pastels, or any brand voice that's direct rather than reassuring.

**When to avoid it:** wellness, finance-for-consumers, or anything where the brand needs to feel calm or trustworthy through softness — the lack of shadow/depth can read as aggressive if the content itself is sensitive (e.g. a support/refund flow).

## UX psychology behind this style

These are mechanisms specific to *this* style — not the general platform-level principles (touch targets, Fitts's Law, etc.) that live in the main skill body. Knowing why the style works helps you judge when it's the right call and when to bend a rule deliberately rather than by accident.

- **Von Restorff effect (isolation effect):** a stimulus that visually deviates from its surroundings is disproportionately noticed and remembered. Full-bleed saturated blocks with no softening make this the whole style's mechanism — every section already reads as "the odd one out" relative to typical soft-shadow SaaS UI. This is also why mixing in one soft-shadowed card "just this once" undermines the style — it breaks the very pattern the effect depends on.
- **Colour-authority association:** high-saturation colour paired with true black/white, rather than tinted neutrals, borrows visual lineage from poster and print design, which carries connotations of confidence and intentionality. This is why the style suits brands wanting to feel decisive rather than reassuring — the association predates UI design entirely.
- **Processing fluency via directness:** removing gradients, shadows, and rounded corners removes ambiguity about depth and hierarchy, so there's less to interpret. Lower interpretive load can make claims feel more certain — the same mechanism blunt, high-contrast design exploits in editorial and political messaging, worth being deliberate about rather than purely decorative.
- **Anchoring via scale:** oversized headline type becomes the first fixation point on a screen; with no competing shadow or gradient detail to pull the eye elsewhere, scale alone carries the hierarchy. That's why type sizing needs to be more aggressive here than in softer styles — it's doing more of the work alone.
- **Chunking for scroll-based recall:** on long-scroll layouts, each full-bleed colour block acts as a distinct, memorable "chunk" — useful for wayfinding ("it was on the green section") in a way a continuous white page with subtle card shadows doesn't support as well.

## Colour

- Use 2–3 saturated hues plus true black and true white. No tints, no gradients, no colour blending.
- One colour should dominate as the "brand" panel colour (in the source example, a lime/chartreuse green); a second acts as a secondary block colour (cobalt blue); black and white carry the rest.
- Contrast should be stark — text sits directly on a solid block with no intermediate tone to ease the transition.
- Suggested token range:
  - `--accent-primary: #C6F24E` (lime — swap for brand colour, but keep it saturated, not pastel)
  - `--accent-secondary: #1D3FD6` (cobalt)
  - `--surface-dark: #0A0A0A`
  - `--surface-light: #FFFFFF`
- Do not introduce a mid-grey as a "safe" neutral — this style wants black/white contrast, not grey softening.

## Depth & elevation

- Zero shadows. Zero blur. Zero gradients used for depth.
- Elevation/hierarchy is communicated by colour block size and position, not by simulated lighting.
- Borders, when used, are solid and thick (2px+), never soft or low-opacity.

## Shape language

- Sharp rectangular corners throughout — 0px radius on cards, buttons, and containers. No exceptions for "friendliness."
- Sections butt directly against each other with no rounding or gap softening at the seams.
- Dividers are thick solid rules (2–4px), not hairlines.

## Typography

- Large, tightly-tracked or condensed sans-serif for headlines — type itself becomes a graphic block.
- Strong size contrast between headline and supporting text (headline should feel oversized relative to body copy).
- Labels/eyebrow text in uppercase, small size, often colour-inverted (light text on the dark block, dark on light).
- Avoid italics, script, or decorative type — it undercuts the starkness.

## Spacing & layout

- Full-bleed colour panels — content runs edge-to-edge within its block, minimal internal padding relative to block size.
- Grid is rigid and visible; asymmetry is allowed between blocks (a 2-column vs 1-column split) but never soft/organic.
- White space is used as a block itself (a white panel counts as "empty space") rather than as margin around content.

## Mobile adaptation

- Stack colour blocks vertically, full-width, one panel per viewport-height-ish section — the user scrolls through blocks like flipping cards.
- Bottom nav or CTA bar can itself be a solid colour block (see source: black bar with white CTA button, no rounding).
- Numbered section indicators (01, 02, 03) work well as a wayfinding device down the stack.

## Desktop / web adaptation

- Blocks can run as side-by-side panels rather than only stacking — e.g. a persistent left-hand colour block (nav/category list) against a lighter content panel on the right, as seen in the transform9 desktop layout.
- Hover states should stay flat — a colour shift or underline, never a shadow-lift or scale transform (that would import depth language this style deliberately avoids).
- Because desktop has more width, resist the urge to soften the grid with more whitespace — keep panels full-bleed within their column rather than floating them as centred cards.

## Do / Don't

| Do | Don't |
|---|---|
| Solid saturated fills | Gradients or tinted overlays |
| 0px corner radius | Rounded corners "for friendliness" |
| Thick solid dividers | Soft hairlines or shadowed separators |
| Oversized flat typography | Decorative or soft type treatments |
| Colour-block hierarchy | Shadow-based elevation |
