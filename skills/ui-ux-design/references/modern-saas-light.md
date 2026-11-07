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
- Indigo doubles as the interactive accent (primary buttons, links, active nav). That's the one non-chart use of a chart hue, and it's allowed because it's solid, never gradient. The "gradient only in data viz" rule still holds.

## Tokens

This is the fallback style when a brief gives no visual signal, so it's specified the most completely. It covers the full semantic set from `tokens-handoff.md`. Every text pair, UI-boundary pair and status pair below is checked against WCAG 2.2 AA in both modes. Use the blocks as-is or map them into the project's existing theme. The dark block is shown with a bare `[data-theme="dark"]` selector; `tokens-handoff.md` shows the full system-preference wrapper.

```css
/* light (default) */
:root {
  --surface-base: #FFFFFF;      /* main canvas */
  --surface-sunken: #F5F6F8;    /* sidebar, page background behind cards */
  --surface-raised: #FFFFFF;    /* cards: lifted by --shadow-md, not by tint */
  --surface-overlay: #FFFFFF;   /* modals, menus, popovers: --shadow-lg */
  --text-primary: #0F1222;
  --text-secondary: #5B6070;
  --text-on-accent: #FFFFFF;
  --border: #E6E8EE;            /* card edges, dividers (decorative) */
  --border-strong: #8A90A0;     /* input, checkbox and toggle outlines */
  --accent: #4F46E5;            /* indigo: primary buttons, links, active nav */
  --accent-hover: #4338CA;
  --accent-subtle: #EEF2FF;     /* selected row, active nav background */
  --focus-ring: #6366F1;
  --success: #15803D;  --text-on-success: #FFFFFF;
  --warning: #B45309;  --text-on-warning: #FFFFFF;
  --danger:  #DC2626;  --text-on-danger:  #FFFFFF;
  /* data visualisation only, never a UI accent */
  --viz-1: #4F46E5;    /* indigo */
  --viz-2: #9333EA;    /* purple */
  --viz-3: #0D9488;    /* teal */
  --viz-gradient: linear-gradient(180deg, #6366F1 0%, #A855F7 100%);
  /* category pills: tinted fill + dark text, one hue per category type */
  --tag-indigo-bg: #EEF2FF;  --tag-indigo-text: #3730A3;
  --tag-teal-bg: #F0FDFA;    --tag-teal-text: #115E59;
  --tag-amber-bg: #FFFBEB;   --tag-amber-text: #92400E;
  /* shadows live in the mode blocks, not the shared block, so the dark block's override isn't undone by source order */
  --shadow-sm: 0 1px 2px rgb(15 18 34 / 0.06);
  --shadow-md: 0 4px 12px rgb(15 18 34 / 0.08);
  --shadow-lg: 0 12px 32px rgb(15 18 34 / 0.14);
}
```

```css
/* dark */
[data-theme="dark"] {
  --surface-base: #0E1017;
  --surface-sunken: #0A0B10;
  --surface-raised: #171A23;
  --surface-overlay: #1F2330;
  --text-primary: #F1F2F6;
  --text-secondary: #A3A8B8;
  --text-on-accent: #0E1017;    /* dark text on the lighter dark-mode indigo */
  --border: #2A2F3D;
  --border-strong: #6B7287;
  --accent: #818CF8;
  --accent-hover: #A5B4FC;
  --accent-subtle: #1E2140;
  --focus-ring: #A5B4FC;
  --success: #4ADE80;  --text-on-success: #052E16;
  --warning: #FBBF24;  --text-on-warning: #1F1300;
  --danger:  #F87171;  --text-on-danger:  #2A0505;
  --viz-1: #818CF8;  --viz-2: #C084FC;  --viz-3: #2DD4BF;
  --viz-gradient: linear-gradient(180deg, #818CF8 0%, #C084FC 100%);
  --tag-indigo-bg: #1E2140;  --tag-indigo-text: #C7D2FE;
  --tag-teal-bg: #0F2A28;    --tag-teal-text: #99F6E4;
  --tag-amber-bg: #2A1F0A;   --tag-amber-text: #FCD34D;
  --shadow-sm: 0 1px 2px rgb(0 0 0 / 0.40);
  --shadow-md: 0 4px 12px rgb(0 0 0 / 0.45);
  --shadow-lg: 0 12px 32px rgb(0 0 0 / 0.55);
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 8px;  --radius-md: 14px;  --radius-lg: 20px;  --radius-full: 9999px;  /* cards = md, buttons/tags = full */
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;  /* card gutters: --space-5 or more */
  --font-sans: "Inter", ui-sans-serif, system-ui, sans-serif;
  --font-mono: "JetBrains Mono", ui-monospace, monospace;
  --text-xs: 0.75rem;  --text-sm: 0.875rem;  --text-base: 1rem;  --text-lg: 1.125rem;  --text-xl: 1.5rem;
  --text-2xl: clamp(1.75rem, 1.4rem + 1.5vw, 2.25rem);
  --text-3xl: clamp(2.25rem, 1.6rem + 3vw, 3.25rem);  /* headline metric numerals, bold, tabular */
  --duration-fast: 120ms;  --duration-base: 200ms;  --duration-slow: 320ms;
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);
}
```

- **Gradient fills in charts** run between `--viz-*` hues that each clear 3:1 against the card. A gradient bar whose lightest stop disappears into the white card fails non-text contrast even if the darker end passes.
- **Pill tags** always pair a tinted `-bg` with its matching `-text`. Never put saturated text on white for a tag, because tags sit next to status colours and would read as status.

## Depth & elevation

- Soft shadows on cards — a touch more pronounced than Soft Minimal Dashboard's near-invisible shadows, giving cards a slightly more "lifted," tactile feel appropriate to a consumer-facing product.
- A subtle border or frame around the overall app container is acceptable (e.g. when the product is presented inside browser chrome on a marketing page) and reinforces a clean, contained feel.

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

- Persistent sidebar navigation on `--surface-sunken`, with the white content area to its right.
- Multi-column card grid with charts and tables able to sit side-by-side.
- Hover states on interactive rows, cards, and chart segments (e.g. highlighting a specific bar or segment on hover) — consistent with the friendly, tactile feel of the rest of the style.
- The style is browser-first. Treat desktop/web as the primary canvas and mobile as the condensed adaptation, not the other way around.

## Dark mode

- **Surfaces step up in lightness**: `--surface-sunken` → base → raised → overlay. Keep shadows as well, because cards need both cues to stay "lifted" on dark: a shadow alone barely reads.
- **Indigo lightens to `#818CF8` and takes dark text.** At light-mode saturation, white text on indigo stays legible, but the indigo itself vibrates against near-black.
- **Gradients in charts stay, at lighter stops.** On dark, a chart gradient becomes even more of a focal point, so be stricter about keeping it to the one or two charts that matter.
- **Big bold numerals use `--text-primary`**, not pure white, which glows on dark and makes the headline metric harder to read.
- **Pill tags swap to dark tinted fills with light text** rather than keeping light-mode pastels, which turn into bright stickers on a dark canvas.

## Do / Don't

| Do | Don't |
|---|---|
| White base, gradient only in data viz | Gradient used as a general UI accent |
| Pill-shaped buttons and tags | Sharp-edged buttons (undercuts the approachable tone) |
| Large bold numerals as focal points | Uniform type sizing that buries key metrics |
| Generous card spacing | Cramming cards edge-to-edge |
| Soft, tactile card shadows | Flat, shadowless cards (reads as the wrong style entirely) |
