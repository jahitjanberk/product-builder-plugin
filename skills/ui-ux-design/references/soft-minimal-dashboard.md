# Soft Minimal Dashboard

A restrained, neutral-ground style built for data-dense, high-frequency-use interfaces — internal tools, admin panels, ops and security dashboards. Colour is reserved almost entirely for meaning (status, risk, action) rather than decoration, so the interface stays legible under heavy information load.

**When to reach for this style:** internal tools, admin panels, security/ops dashboards, B2B control centres, any interface a user will have open for hours at a time and needs to scan quickly and repeatedly.

**When to avoid it:** consumer-facing marketing or onboarding screens (this style intentionally recedes, which reads as cold in a context meant to persuade), any product where visual differentiation/brand personality is a priority — this style is deliberately generic-feeling by design.

## UX psychology behind this style

- **Colour-as-signal preservation:** by keeping the base canvas neutral (white/light-grey) and using colour only for status and semantic meaning, any colour that does appear reads as instantly meaningful. This matters most in security/ops contexts, where a false or diluted alarm (e.g. decorative red used elsewhere) has a real cost — operators start ignoring colour signals if they're not reserved.
- **Soft shadow elevation as low-noise affordance:** subtle, low-opacity shadows let users infer "this is interactive/layered" through an intuitive light-physics read, without adding a visual element that competes for attention on an already information-dense screen. This is a deliberate trade-off against a flatter style — a little elevation here does real functional work rather than just decoration.
- **Restrained type scale reduces scanning fatigue over long sessions:** unlike consumer apps used in short bursts, ops dashboards are often left open all day. A calm, low-contrast-but-legible type scale reduces fatigue over hours of use in a way that a bolder, more attention-grabbing scale would actively work against.
- **Layered/slide-over panels and spatial memory:** the detail panel sliding in from the right while the underlying table stays visible behind it preserves context — the user's sense of "where they are" persists via object permanence, reducing the cost of investigating a detail without a full navigation away from the list.
- **Monospace/tabular numerals for precision signalling:** using tabular or monospace-adjacent numerals for data figures in metric cards and tables borrows from a long history of technical and financial tools signalling rigor through typography — it's a small detail that disproportionately affects perceived trustworthiness of the numbers.

## Colour

- Near-white/light-grey canvas (`#F7F7F9`-ish), white cards.
- Blue as the primary "data" colour for charts and active states.
- Semantic red/yellow/green reserved strictly for status, risk, and alerts — never used decoratively elsewhere.
- Minimal additional saturated colour; the palette should feel almost monochrome until a status signal appears.

## Tokens

This is the full semantic set from `tokens-handoff.md`, checked against WCAG 2.2 AA in both modes. The dark block is shown with a bare `[data-theme="dark"]` selector; `tokens-handoff.md` has the full system-preference wrapper.

```css
/* light */
:root {
  --surface-base: #F7F7F9;      /* canvas */
  --surface-raised: #FFFFFF;    /* cards, table container */
  --surface-overlay: #FFFFFF;   /* slide-over detail panel, menus: --shadow-lg */
  --text-primary: #111318;      /* metric values, row primary text */
  --text-secondary: #5F6470;    /* labels, supporting context */
  --text-on-accent: #FFFFFF;
  --border: #E4E5EA;            /* row dividers, card edges */
  --border-strong: #868A96;     /* inputs, checkboxes, filter chips */
  --accent: #2563EB;            /* the one "data" blue: active state, primary series */
  --accent-hover: #1D4ED8;
  --accent-subtle: #EFF4FF;     /* active sidebar item, selected row */
  --focus-ring: #2563EB;
  --success: #15803D;  --text-on-success: #FFFFFF;
  --warning: #B45309;  --text-on-warning: #FFFFFF;
  --danger:  #C81E1E;  --text-on-danger:  #FFFFFF;
  --viz-1: #2563EB;    /* primary series */
  --viz-2: #475569;    /* comparison / previous period */
  --viz-fill: #DBE7FE; /* area under a line: decorative, the line carries the data */
  /* shadows live in the mode blocks, not the shared block, so the dark block's override isn't undone by source order */
  --shadow-sm: 0 1px 2px rgb(17 19 24 / 0.04);
  --shadow-md: 0 2px 8px rgb(17 19 24 / 0.06);
  --shadow-lg: 0 8px 24px rgb(17 19 24 / 0.10);   /* slide-over panel */
}
```

```css
/* dark */
[data-theme="dark"] {
  --surface-base: #0F1115;
  --surface-raised: #171A20;
  --surface-overlay: #1E222A;
  --text-primary: #E8EAEE;
  --text-secondary: #9AA0AC;
  --text-on-accent: #0B1220;
  --border: #262A33;
  --border-strong: #6A7080;
  --accent: #60A5FA;
  --accent-hover: #93C5FD;
  --accent-subtle: #172338;
  --focus-ring: #93C5FD;
  --success: #4ADE80;  --text-on-success: #052E16;
  --warning: #FACC15;  --text-on-warning: #1F1500;
  --danger:  #F87171;  --text-on-danger:  #2B0606;
  --viz-1: #60A5FA;  --viz-2: #94A3B8;  --viz-fill: #172338;
  --shadow-sm: 0 1px 2px rgb(0 0 0 / 0.35);
  --shadow-md: 0 2px 8px rgb(0 0 0 / 0.40);
  --shadow-lg: 0 8px 24px rgb(0 0 0 / 0.50);
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 6px;  --radius-md: 8px;  --radius-lg: 12px;
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;
  --font-sans: "Inter", ui-sans-serif, system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;  /* or font-variant-numeric: tabular-nums on --font-sans */
  --text-xs: 0.75rem;  --text-sm: 0.8125rem;  --text-base: 0.875rem;  --text-lg: 1rem;
  --text-xl: 1.25rem;  --text-2xl: 1.5rem;  --text-3xl: 2rem;  /* no clamp: dashboards don't need display type */
  --duration-fast: 100ms;  --duration-base: 160ms;  --duration-slow: 240ms;  /* snappy: users repeat these actions all day */
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);
}
```

- **Body text is 14px (`--text-base: 0.875rem`) by design** for density. Anything that must be read at length (descriptions, help text) still gets `--text-lg`, so that density doesn't come at the cost of readability.
- **Status colours only ever appear with an icon or label** (a red dot alone fails colour-only meaning). That pairing also stops them reading as decoration.

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

- Persistent sidebar navigation, with the active item marked by `--accent-subtle` rather than a solid colour block.
- Multi-panel layouts are the default strength here — list, chart, and slide-over detail panel can all be visible at once without feeling cluttered, because the restrained colour and soft shadows keep each layer legible.
- Hover states for row highlighting and light interactivity cues.
- Keyboard shortcuts (e.g. ⌘K for search) are a natural fit for this style's power-user, high-frequency-use context.

## Dark mode

Ops and security dashboards are often run in dark mode in control rooms and on night shifts, so treat dark mode as a first-class theme here rather than an afterthought.

- **Keep the near-monochrome restraint.** Dark mode is not licence to add colour. The neutral greys just move to the dark end, and status colours remain the only saturated elements.
- **Status colours shift lighter and keep their meaning** (`#F87171` for danger). In an alerting context, re-check that red, amber and green stay distinguishable from each other for colour-blind users, not just against the background. That's another reason every status needs an icon or label.
- **Elevation becomes lightness first.** The slide-over panel sits on `--surface-overlay`, the lightest surface, so it reads as "above" even where the shadow is lost against dark.
- **Tables lose zebra striping or keep it extremely subtle.** On dark, alternating row tints read as banding noise. Use row dividers (`--border`) and a hover highlight instead.

## Do / Don't

| Do | Don't |
|---|---|
| Neutral canvas, colour reserved for meaning | Decorative colour scattered throughout |
| Soft, low-opacity shadows | Heavy shadows or none at all |
| Small, disciplined type scale | Oversized type competing for attention |
| Multi-panel desktop layouts | Forcing mobile's single-focus pattern onto desktop |
| Tabular numerals for data | Mismatched or decorative numeral styles |
