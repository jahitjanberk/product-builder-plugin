# Moody Editorial

A dark, photography-led style with minimal UI chrome — the interface recedes so imagery and content carry the emotional weight. Feels intimate, contemplative, and editorial rather than "app-like." Built for products where the content itself needs to feel considered, not just efficiently delivered.

**When to reach for this style:** wellness, meditation, sleep, journaling, lifestyle and content-led apps — anything where the product's value is emotional/experiential rather than transactional, and where slowing the user down is a feature, not a bug.

**When to avoid it:** transactional or utility apps (dark mode plus heavy photography slows scanning for task completion), data-dense products, anything needing to feel energetic, fast, or urgent — this style actively works against urgency.

## UX psychology behind this style

- **Dark environments and lowered arousal:** darker visual environments are associated with lower physiological arousal and a more contemplative, inward-focused state — this is why meditation and sleep apps reach for dark mode far more consistently than, say, fitness or productivity apps, which want the opposite.
- **Photography over illustration for trust:** real photographic imagery builds parasocial trust and emotional relatability faster than iconography or illustration, which matters disproportionately for emotionally sensitive categories where the user needs to feel *met*, not marketed to.
- **Minimal chrome as a trust signal:** stripping back visible UI (buttons, borders, labels) signals "the content is the product," which reduces the feeling of being sold to — critical in wellness, where overt commercial framing (a subscription paywall is the obvious case) can undermine the calm the rest of the product is trying to build. Handle that tension directly: the paywall screen should keep warm, human photography and the same quiet chrome rather than switching to a harder sales-page visual language.
- **Colour-emotion mapping via restrained gradient accents:** violet and amber gradient overlays used sparingly on specific cards (e.g. a settings header in violet, an energising movement practice in amber) let each category carry an emotional register — cool/spiritual vs. warm/energising — without needing explicit labelling, reducing cognitive load while still differentiating content types.
- **Full-bleed imagery and immersion:** photography filling the entire frame, edge to edge, reduces peripheral distraction and supports the kind of single-focus attention the product is trying to cultivate — this is a deliberate structural choice, not just an aesthetic one.

## Colour

- Near-black base (`#0A0A0A`–`#121212`) across nearly every screen.
- Colour is carried almost entirely by photographic imagery rather than UI elements — the interface itself stays desaturated.
- Violet and amber gradient overlays used sparingly, only on specific content cards or headers, never as a blanket treatment.
- White or near-white text throughout for legibility against the dark base.

## Tokens

This is the full semantic set from `tokens-handoff.md`, checked against WCAG 2.2 AA, including text over the violet and amber tints and over a worst-case white photo under the scrim. **Dark is the default.** The light block is an opt-in reading mode; see "Light variant" below for why it isn't automatic.

```css
/* dark (default) */
:root {
  --surface-base: #0E0E0E;
  --surface-raised: #181818;    /* settings rows, sheets */
  --surface-overlay: #222222;   /* modals, bottom sheets */
  --text-primary: #F5F2EE;      /* warm off-white, never pure #FFF */
  --text-secondary: #B3ADA6;    /* muted light grey: never over photos */
  --text-on-accent: #1A1206;
  --border: #2A2A2A;
  --border-strong: #77716B;     /* inputs only: the style otherwise avoids outlines */
  --accent: #EBC08A;            /* soft amber: primary CTA pill, active tab */
  --accent-hover: #F3D2A6;
  --focus-ring: #F5F2EE;
  --success: #6FCF97;  --text-on-success: #0B1F14;
  --warning: #F2C46D;  --text-on-warning: #241A05;
  --danger:  #F08A80;  --text-on-danger:  #2A0B08;
  --tint-violet: #5B3FA8;       /* cool / reflective categories */
  --tint-amber: #8F5A22;        /* warm / energising categories */
  --overlay-violet: linear-gradient(160deg, rgb(91 63 168 / 0.85) 0%, rgb(91 63 168 / 0) 70%);
  --overlay-amber: linear-gradient(160deg, rgb(143 90 34 / 0.85) 0%, rgb(143 90 34 / 0) 70%);
  --scrim: linear-gradient(to top, rgb(0 0 0 / 0.75) 0%, rgb(0 0 0 / 0.6) 35%, rgb(0 0 0 / 0) 70%);
  --text-on-media: #F5F2EE;     /* the only text colour allowed over photos and tints */
}
```

```css
/* light (opt-in reading mode, never automatic) */
[data-theme="light"] {
  --surface-base: #F6F3EE;      /* warm paper, not white */
  --surface-raised: #FFFFFF;
  --surface-overlay: #FFFFFF;
  --text-primary: #1A1714;
  --text-secondary: #5C554D;
  --text-on-accent: #FFFFFF;
  --border: #E5DFD6;
  --border-strong: #8C8379;
  --accent: #8A5A1F;            /* amber deepened to hold contrast on paper */
  --accent-hover: #6F4815;
  --focus-ring: #8A5A1F;
  --success: #1F7A4A;  --text-on-success: #FFFFFF;
  --warning: #8F5A00;  --text-on-warning: #FFFFFF;
  --danger:  #B42318;  --text-on-danger:  #FFFFFF;
  --tint-violet: #5B3FA8;
  --tint-amber: #8F5A22;
  --text-on-media: #F5F2EE;     /* photos keep light text and the scrim in both modes */
}
```

```css
/* shared (both modes) */
:root {
  --radius-sm: 10px;  --radius-md: 16px;  --radius-lg: 24px;  --radius-full: 9999px;  /* floating pill nav */
  --space-1: 4px;  --space-2: 8px;  --space-3: 12px;  --space-4: 16px;
  --space-5: 24px; --space-6: 32px; --space-7: 48px;  --space-8: 64px;
  --font-sans: "DM Sans", ui-sans-serif, system-ui, sans-serif;
  --font-mono: ui-monospace, monospace;
  --text-xs: 0.8125rem;  --text-sm: 0.9375rem;  --text-base: 1.0625rem;  --text-lg: 1.25rem;  --text-xl: 1.75rem;
  --text-2xl: clamp(2rem, 1.6rem + 1.8vw, 2.5rem);
  --text-3xl: clamp(2.5rem, 1.9rem + 2.8vw, 3.25rem);
  --shadow-sm: none;  --shadow-md: none;
  --shadow-lg: 0 12px 32px rgb(0 0 0 / 0.5);  /* floating nav pill and sheets only */
  --duration-fast: 160ms;  --duration-base: 280ms;  --duration-slow: 520ms;  /* slow on purpose */
  --ease-standard: cubic-bezier(0.25, 0.1, 0.25, 1);
}
```

- **Text over photos sits only where the scrim is at least 60% black.** That guarantees about 5:1 for `--text-on-media` even over a white sky. `--text-secondary` never goes over imagery: muted grey over a busy photo is the most common legibility failure in this style.
- **The violet and amber tints are tested at full strength.** Text belongs in the opaque end of each overlay gradient, not in the fade.

## Depth & elevation

- Minimal to none — flat dark surfaces with no card shadows in the traditional sense.
- Depth is provided by the photography itself (its own tonal range and focus) rather than by UI elevation tricks.
- Where text sits directly over a photo, a soft gradient scrim (dark-to-transparent) is used for legibility — this is the one "shadow-adjacent" device the style relies on.

## Shape language

- Softly rounded corners on photo tiles, cards, and buttons — enough to feel considered, not sharp or clinical.
- Circular icons and avatar treatments.
- Rounded pill-shaped bottom navigation bar, floating slightly above the content rather than flush with the screen edge.

## Typography

- Large, clean sans-serif headlines set directly over photography, relying on the scrim for contrast rather than a background box.
- Supporting text stays smaller and muted (light grey rather than pure white) to avoid competing with the headline.
- Avoid heavy typographic decoration — the photography is already carrying visual richness; competing with ornate type would clutter the composition.

## Spacing & layout

- Generous negative space around the dark canvas, even though individual tiles are full-bleed within their own boundaries.
- Discovery/grid screens use a consistent 2-column tile layout with even gutters.
- Detail screens go full-bleed on imagery with content anchored toward the bottom third, leaving the upper photo largely uninterrupted.

## Mobile adaptation

- 2-column full-bleed photo grid for browsing/discovery.
- Bottom tab bar navigation (For you / Discover / My space / Profile) — pill-shaped, floating, minimal.
- Detail and settings screens stack vertically with generous full-bleed hero imagery at the top of each.

## Desktop / web adaptation

- This style is mobile-native, so desktop is the adaptation: translate the 2-column mobile grid into a wider masonry or multi-column gallery layout, since desktop's extra width suits a richer photographic grid rather than a wider version of the same 2 columns.
- Increase negative space around the grid further — desktop has room to let images breathe more than mobile does.
- Hover states should stay understated: a subtle brightness lift or caption reveal on hover, never a hard shadow-lift, to stay consistent with the style's avoidance of elevation cues.
- Replace the bottom tab bar with a minimal sidebar or top nav, keeping it as unobtrusive as the mobile version — chrome should still recede relative to the imagery.

## Light variant

Dark is not a theme option here; it's how the style works. The lowered-arousal and immersion effects above depend on it. So:

- **Default to dark regardless of the OS setting.** Unlike the other five styles, don't follow `prefers-color-scheme` automatically. A meditation app that flips to bright paper at 11pm because the phone is in light mode breaks the product's core promise.
- **Still offer light as an explicit setting.** Some people can't comfortably read light text on dark (astigmatism makes it smear), and some use the product outdoors. Provide a "Light reading mode" toggle in settings using the `[data-theme="light"]` tokens, and remember the choice.
- **What changes in light:** warm paper surfaces, dark text, deeper amber accent. **What doesn't:** photography still carries the colour, text over photos keeps the scrim and light `--text-on-media`, and chrome stays minimal. If a brief wants a *light-first* contemplative product, that's closer to Ambient Gradient or Modern SaaS Light than to a light version of this style.

## Do / Don't

| Do | Don't |
|---|---|
| Near-black base, photography-led colour | Bright/light backgrounds by default (light is an opt-in reading mode only) |
| Full-bleed imagery with scrim for legibility | Boxed text over photos |
| Minimal, receding UI chrome | Heavy borders, visible card outlines |
| Sparing, purposeful gradient accents | Gradient applied broadly across the UI |
| Soft rounded corners | Sharp edges (reads as clinical, breaks the intimacy) |
