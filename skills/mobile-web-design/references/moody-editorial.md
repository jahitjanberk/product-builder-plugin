# Moody Editorial

A dark, photography-led style with minimal UI chrome — the interface recedes so imagery and content carry the emotional weight. Feels intimate, contemplative, and editorial rather than "app-like." Built for products where the content itself needs to feel considered, not just efficiently delivered.

**When to reach for this style:** wellness, meditation, sleep, journaling, lifestyle and content-led apps — anything where the product's value is emotional/experiential rather than transactional, and where slowing the user down is a feature, not a bug.

**When to avoid it:** transactional or utility apps (dark mode plus heavy photography slows scanning for task completion), data-dense products, anything needing to feel energetic, fast, or urgent — this style actively works against urgency.

## UX psychology behind this style

- **Dark environments and lowered arousal:** darker visual environments are associated with lower physiological arousal and a more contemplative, inward-focused state — this is why meditation and sleep apps reach for dark mode far more consistently than, say, fitness or productivity apps, which want the opposite.
- **Photography over illustration for trust:** real photographic imagery builds parasocial trust and emotional relatability faster than iconography or illustration, which matters disproportionately for emotionally sensitive categories where the user needs to feel *met*, not marketed to.
- **Minimal chrome as a trust signal:** stripping back visible UI (buttons, borders, labels) signals "the content is the product," which reduces the feeling of being sold to — critical in wellness, where overt commercial framing (visible everywhere in the subscription paywall shown in the source) can undermine the calm the rest of the product is trying to build. Notice the source handles this tension directly: the paywall screen still uses warm, human photography rather than switching to a harder sales-page visual language.
- **Colour-emotion mapping via restrained gradient accents:** the violet and amber gradient overlays used sparingly on specific cards (Settings header, Embodiment practice) let each category carry an emotional register — cool/spiritual vs. warm/energising — without needing explicit labelling, reducing cognitive load while still differentiating content types.
- **Full-bleed imagery and immersion:** photography filling the entire frame, edge to edge, reduces peripheral distraction and supports the kind of single-focus attention the product is trying to cultivate — this is a deliberate structural choice, not just an aesthetic one.

## Colour

- Near-black base (`#0A0A0A`–`#121212`) across nearly every screen.
- Colour is carried almost entirely by photographic imagery rather than UI elements — the interface itself stays desaturated.
- Violet and amber gradient overlays used sparingly, only on specific content cards or headers, never as a blanket treatment.
- White or near-white text throughout for legibility against the dark base.

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

- 2-column full-bleed photo grid for browsing/discovery, as seen in the source.
- Bottom tab bar navigation (For you / Discover / My space / Profile) — pill-shaped, floating, minimal.
- Detail and settings screens stack vertically with generous full-bleed hero imagery at the top of each.

## Desktop / web adaptation

- No desktop example in the source material, so treat this as an extrapolation: translate the 2-column mobile grid into a wider masonry or multi-column gallery layout, since desktop's extra width suits a richer photographic grid rather than a wider version of the same 2 columns.
- Increase negative space around the grid further — desktop has room to let images breathe more than mobile does.
- Hover states should stay understated: a subtle brightness lift or caption reveal on hover, never a hard shadow-lift, to stay consistent with the style's avoidance of elevation cues.
- Replace the bottom tab bar with a minimal sidebar or top nav, keeping it as unobtrusive as the mobile version — chrome should still recede relative to the imagery.

## Do / Don't

| Do | Don't |
|---|---|
| Near-black base, photography-led colour | Bright/light backgrounds |
| Full-bleed imagery with scrim for legibility | Boxed text over photos |
| Minimal, receding UI chrome | Heavy borders, visible card outlines |
| Sparing, purposeful gradient accents | Gradient applied broadly across the UI |
| Soft rounded corners | Sharp edges (reads as clinical, breaks the intimacy) |
