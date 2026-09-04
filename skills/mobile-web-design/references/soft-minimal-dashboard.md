# Soft Minimal Dashboard

A restrained, neutral-ground style built for data-dense, high-frequency-use interfaces — internal tools, admin panels, ops and security dashboards. Colour is reserved almost entirely for meaning (status, risk, action) rather than decoration, so the interface stays legible under heavy information load.

**When to reach for this style:** internal tools, admin panels, security/ops dashboards, B2B control centres, any interface a user will have open for hours at a time and needs to scan quickly and repeatedly.

**When to avoid it:** consumer-facing marketing or onboarding screens (this style intentionally recedes, which reads as cold in a context meant to persuade), any product where visual differentiation/brand personality is a priority — this style is deliberately generic-feeling by design.

## UX psychology behind this style

- **Colour-as-signal preservation:** by keeping the base canvas neutral (white/light-grey) and using colour only for status and semantic meaning, any colour that does appear reads as instantly meaningful. This matters most in security/ops contexts, where a false or diluted alarm (e.g. decorative red used elsewhere) has a real cost — operators start ignoring colour signals if they're not reserved.
- **Soft shadow elevation as low-noise affordance:** subtle, low-opacity shadows let users infer "this is interactive/layered" through an intuitive light-physics read, without adding a visual element that competes for attention on an already information-dense screen. This is a deliberate trade-off against a flatter style — a little elevation here does real functional work rather than just decoration.
- **Restrained type scale reduces scanning fatigue over long sessions:** unlike consumer apps used in short bursts, ops dashboards are often left open all day. A calm, low-contrast-but-legible type scale reduces fatigue over hours of use in a way that a bolder, more attention-grabbing scale would actively work against.
- **Layered/slide-over panels and spatial memory:** the detail panel sliding in from the right while the underlying table stays visible behind it preserves context — the user's sense of "where they are" persists via object permanence, reducing the cost of investigating a detail without a full navigation away from the list.
- **Monospace/tabular numerals for precision signalling:** using tabular or monospace-adjacent numerals for data figures (seen in the source's metric cards) borrows from a long history of technical and financial tools signalling rigor through typography — it's a small detail that disproportionately affects perceived trustworthiness of the numbers.

## Colour

- Near-white/light-grey canvas (`#F7F7F9`-ish), white cards.
- Blue as the primary "data" colour for charts and active states.
- Semantic red/yellow/green reserved strictly for status, risk, and alerts — never used decoratively elsewhere.
- Minimal additional saturated colour; the palette should feel almost monochrome until a status signal appears.

## Depth & elevation

- Soft, low-opacity drop shadows on cards and floating panels — enough to imply layering, never heavy or hard-edged.
- The floating detail panel (sliding over the main content) uses a slightly stronger shadow than base cards, to clearly signal it's above the primary layer.
- Thin 1px borders/dividers used alongside shadow, not instead of it — both work together for a controlled sense of structure.

## Shape language

- Consistent, moderate corner radius (8–12px) across cards, buttons, and panels — rounded enough to feel modern, restrained enough not to feel playful.
- Thin 1px dividers between list rows and sections.
- Sidebar navigation items use a subtle rounded highlight for the active state, not a bold colour block.

## Typography

- Small-to-medium sans-serif throughout — this style doesn't rely on large type for hierarchy the way bolder styles do.
- Tight, disciplined hierarchy: section labels in small uppercase grey, metric values in larger bold black, supporting context in regular-weight grey.
- Monospace or tabular-figure numerals for data points, distinct from the general UI sans.

## Spacing & layout

- Dense but organised — this style can hold more on screen than others precisely because the restrained colour and shadow keep it legible under density.
- Consistent grid: sidebar + main content, with an optional third column/panel for details.
- Card padding stays generous even though overall density is high — the density comes from *more cards*, not *less padding per card*.

## Mobile adaptation

- This style is inherently desktop-first due to its data density; on mobile, collapse to a single column and prioritise the top-line KPIs first.
- Defer detailed tables behind a drill-down tap rather than trying to fit a full table on a small screen.
- The slide-over detail panel becomes a full-screen modal on mobile rather than a partial-width overlay — there isn't room to show both list and detail simultaneously.

## Desktop / web adaptation (native to this style)

- Persistent sidebar navigation, as in the source.
- Multi-panel layouts are the default strength here — list, chart, and slide-over detail panel can all be visible at once without feeling cluttered, because the restrained colour and soft shadows keep each layer legible.
- Hover states for row highlighting and light interactivity cues.
- Keyboard shortcuts (e.g. ⌘K for search) are a natural fit for this style's power-user, high-frequency-use context.

## Do / Don't

| Do | Don't |
|---|---|
| Neutral canvas, colour reserved for meaning | Decorative colour scattered throughout |
| Soft, low-opacity shadows | Heavy shadows or none at all |
| Small, disciplined type scale | Oversized type competing for attention |
| Multi-panel desktop layouts | Forcing mobile's single-focus pattern onto desktop |
| Tabular numerals for data | Mismatched or decorative numeral styles |
