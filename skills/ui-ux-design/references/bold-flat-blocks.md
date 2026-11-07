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
- One colour should dominate as the "brand" panel colour (e.g. a lime/chartreuse green); a second acts as a secondary block colour (e.g. cobalt blue); black and white carry the rest.
- Contrast should be stark — text sits directly on a solid block with no intermediate tone to ease the transition.
- Block colours: lime `#C6F24E` as the dominant panel (swap in the brand colour, but keep it saturated, not pastel), cobalt `#1D3FD6` as the secondary panel, plus `#0A0A0A` and `#FFFFFF`. Full token set below.
- **A light block colour is a panel colour, never a text or line colour.** Lime on white is about 1.3:1, so it can't carry text, icons, links or focus rings on a white panel. On white, interactive colour is cobalt or black. Lime becomes the accent only in dark mode, where it sits on black.
- Do not introduce a mid-grey as a "safe" neutral — this style wants black/white contrast, not grey softening.

## Tokens

This is the full semantic set from `tokens-handoff.md`, checked against WCAG 2.2 AA in both modes, plus each block colour with its text. The dark block is shown with a bare `[data-theme="dark"]` selector; `tokens-handoff.md` has the full system-preference wrapper.

```css
/* light (white panels as the base) */
:root {
  --surface-base: #FFFFFF;
  --surface-raised: #FFFFFF;    /* no elevation in this style: raised = same fill + 2px border */
  --surface-overlay: #FFFFFF;   /* overlays = same fill + 3px border, never a shadow */
  --text-primary: #0A0A0A;
  --text-secondary: #2E2E2E;    /* hierarchy comes from size and weight, not a grey */
  --text-on-accent: #FFFFFF;
  --border: #0A0A0A;
  --border-strong: #0A0A0A;
  --accent: #1D3FD6;            /* cobalt: buttons, links on white */
  --accent-hover: #1530A8;
  --focus-ring: #0A0A0A;        /* double ring: see note */
  --focus-ring-contrast: #FFFFFF;
  --success: #15803D;  --text-on-success: #FFFFFF;
  --warning: #C2410C;  --text-on-warning: #FFFFFF;
  --danger:  #C81E1E;  --text-on-danger:  #FFFFFF;
  --block-primary: #C6F24E;    --text-on-block-primary: #0A0A0A;    /* lime: dominant panel */
  --block-secondary: #1D3FD6;  --text-on-block-secondary: #FFFFFF;  /* cobalt panel */
  --block-inverse: #0A0A0A;    --text-on-block-inverse: #FFFFFF;    /* black panel, CTA bar */
}
```

```css
/* dark (black panels as the base) */
[data-theme="dark"] {
  --surface-base: #0A0A0A;
  --surface-raised: #0A0A0A;
  --surface-overlay: #0A0A0A;
  --text-primary: #FFFFFF;
  --text-secondary: #E6E6E6;
  --text-on-accent: #0A0A0A;
  --border: #FFFFFF;
  --border-strong: #FFFFFF;
  --accent: #C6F24E;            /* lime becomes the interactive colour on black */
  --accent-hover: #B2DD38;
  --focus-ring: #FFFFFF;
  --focus-ring-contrast: #0A0A0A;
  --success: #4ADE80;  --text-on-success: #0A0A0A;
  --warning: #FFB000;  --text-on-warning: #0A0A0A;
  --danger:  #FF5A4E;  --text-on-danger:  #0A0A0A;
  --block-primary: #C6F24E;    --text-on-block-primary: #0A0A0A;
  --block-secondary: #1D3FD6;  --text-on-block-secondary: #FFFFFF;
  --block-inverse: #FFFFFF;    --text-on-block-inverse: #0A0A0A;    /* the inverse panel flips to white */
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 0;  --radius-md: 0;  --radius-lg: 0;  --radius-full: 0;  /* no exceptions */
  --border-width: 2px;  --rule-width: 3px;
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;
  --font-display: "Archivo", "Helvetica Neue", Arial, sans-serif;  /* condensed width (Archivo wdth 62–75, or Archivo Narrow) for headlines */
  --font-sans: "Archivo", "Helvetica Neue", Arial, sans-serif;
  --font-mono: ui-monospace, monospace;
  --text-xs: 0.75rem;  --text-sm: 0.875rem;  --text-base: 1rem;  --text-lg: 1.25rem;  --text-xl: 2rem;
  --text-2xl: clamp(2.5rem, 1.5rem + 5vw, 4.5rem);
  --text-3xl: clamp(3.5rem, 2rem + 8vw, 7rem);    /* the headline is a graphic block */
  --shadow-sm: none;  --shadow-md: none;  --shadow-lg: none;
  --duration-fast: 80ms;  --duration-base: 140ms;  --duration-slow: 200ms;  /* instant, no bounce */
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);
}
```

- **Focus rings are doubled** (`outline: 3px solid var(--focus-ring); box-shadow: 0 0 0 6px var(--focus-ring-contrast)`) because no single colour clears 3:1 on white, lime, cobalt *and* black panels. One of the two rings always does. That box-shadow is a focus indicator, not elevation, so it doesn't break the zero-shadow rule.
- **Status colours are semantic additions, not a fourth block colour.** Use them only in status contexts (alerts, validation), never as section panels.

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
- The bottom nav or CTA bar can itself be a solid colour block, e.g. a full-width black bar holding a square-cornered white CTA button.
- Numbered section indicators (01, 02, 03) work well as a wayfinding device down the stack.

## Desktop / web adaptation

- Blocks can run as side-by-side panels rather than only stacking — e.g. a persistent left-hand colour block (nav/category list) against a lighter content panel on the right.
- Hover states should stay flat — a colour shift or underline, never a shadow-lift or scale transform (that would import depth language this style deliberately avoids).
- Because desktop has more width, resist the urge to soften the grid with more whitespace — keep panels full-bleed within their column rather than floating them as centred cards.

## Dark mode

Black is already one of this style's block colours, so dark mode is a re-weighting of the same palette rather than a new one.

- **Black becomes the default panel and white becomes the inverse block.** The lime and cobalt panels are unchanged.
- **Interactive colour moves from cobalt to lime.** Cobalt on black is about 2.6:1, which is too low for links, buttons or focus. Lime on black is above 15:1.
- **Pure white text on pure black is allowed here, unlike in the softer styles.** Starkness is the point, and the large type sizes reduce the halation that makes small white-on-black body text tiring. Keep long-form body copy at `--text-secondary` (`#E6E6E6`) if a page has a lot of it.
- **Borders flip to white and stay thick.** A 1px grey border on black is the dark-mode equivalent of the soft shadow this style forbids.

## Do / Don't

| Do | Don't |
|---|---|
| Solid saturated fills | Gradients or tinted overlays |
| 0px corner radius | Rounded corners "for friendliness" |
| Thick solid dividers | Soft hairlines or shadowed separators |
| Oversized flat typography | Decorative or soft type treatments |
| Colour-block hierarchy | Shadow-based elevation |
