# Accessibility checklist

Load this when designing a screen in detail, writing accessibility acceptance criteria for the `developer` skill, or reviewing an existing UI. The target is **WCAG 2.2 AA**. The EU's European Accessibility Act points to EN 301 549, which currently maps to WCAG 2.1 AA. 2.2 is a superset, so meeting 2.2 covers both. US ADA claims are also routinely argued against WCAG AA.

The must-apply summary lives in `SKILL.md`. This file is the per-component detail and the testing method.

## Text

- **Contrast**: 4.5:1 for body text; 3:1 for large text, which means ≥ 24px regular or ≥ 18.66px bold. Check against the actual surface, including tinted cards, gradients and photos (worst point under the text).
- **Resize and reflow**: the layout works at 200% browser zoom and reflows at a 320 CSS px width without horizontal scrolling (except data tables and maps). Use `rem` for type, and don't give text containers fixed heights, because they clip when users increase text spacing.
- **Platform text scaling**: support iOS Dynamic Type and Android font scaling. Layouts must grow vertically, not truncate. Check the largest setting on the screens with the densest text.
- **Readable body copy**: 45–80 characters per line, line-height ≥ 1.5 for paragraphs. No justified text, since uneven word gaps hurt dyslexic readers.
- **No text baked into images**: it can't be resized, translated, or read by assistive tech.

## Buttons and links

- **Right element for the job**: `<button>` for actions, `<a href>` for navigation. This choice determines keyboard behaviour (Space vs Enter), how screen readers announce it, and whether "open in new tab" works.
- **Accessible name contains the visible label** (WCAG 2.5.3). Icon-only buttons need an `aria-label`. A tooltip is not a name.
- **Links in body text are underlined.** Colour alone only qualifies if it's 3:1 against the surrounding text *and* there's a non-colour cue on hover and focus, so underlining is the simpler option.
- **Target size**: ≥ 24×24 CSS px or enough spacing around the target (WCAG 2.2 floor). Design touch UIs to platform norms instead: 44×44pt on iOS, 48×48dp on Android. Icon buttons can look small but keep a large hit area.
- **Link text makes sense out of context**: "Download the Q3 report", not "click here". Screen reader users often navigate by a list of links.

## Focus and keyboard

- **Everything interactive is reachable with Tab, in visual order.** If the visual and DOM orders differ, fix the DOM, not `tabindex`. Positive `tabindex` values are almost always a bug.
- **Focus is always visible**: at least a 2px ring at ≥ 3:1 against adjacent colours, offset so it isn't clipped. Use `:focus-visible` so mouse clicks don't show rings. Never set `outline: none` without a replacement.
- **Focus isn't hidden** (WCAG 2.4.11) under sticky headers, footers, cookie banners or chat widgets. Use `scroll-padding-top` for sticky headers.
- **Skip link** to the main content on any page with repeated navigation.
- **Custom widgets** (menus, tabs, comboboxes, date pickers, tree views) follow the WAI-ARIA Authoring Practices keyboard patterns. Prefer a headless library that already does this (Radix, React Aria, Headless UI, Ark) over hand-rolling, because hand-rolled comboboxes are the most common source of serious accessibility bugs.
- **Keyboard shortcuts** that are single printable characters (e.g. "j"/"k") can be turned off or remapped (WCAG 2.1.4), or they hijack screen-reader and voice-control input.

## Forms

- **Every input has a visible, programmatically associated label.** Placeholder text is not a label: it disappears on input and usually fails contrast.
- **Errors are identified in text**, associated with the field via `aria-describedby`, and announced. On submit, move focus to the first invalid field, or to an error summary for long forms.
- **Required fields are indicated in text or with `aria-required`**, not by colour. An asterisk is fine if a legend explains it.
- **`autocomplete` on personal-data fields** (WCAG 1.3.5): `name`, `email`, `tel`, `street-address`, `postal-code`, `cc-number`, `one-time-code`, `new-password`, `current-password`. Password managers and mobile autofill depend on these.
- **Don't ask twice** (WCAG 3.3.7): information already given in the same process is pre-filled or selectable.
- **Accessible authentication** (WCAG 3.3.8): no memory or puzzle tests to log in. Allow paste in password and code fields, support password managers, and offer passkeys or magic links. A CAPTCHA needs a non-puzzle alternative.
- **Dragging has a single-pointer alternative** (WCAG 2.5.7): sliders get +/− or an input, sortable lists get "move up/down".

## Images and media

- **Alt text says what the image is *for* in context**, not what it literally depicts. Decorative images get `alt=""` so screen readers skip them.
- **Charts and diagrams** need a text alternative: a one-sentence summary of the insight plus access to the underlying data (a table or download).
- **Video** has captions; **audio** has transcripts. Nothing autoplays with sound. Any motion that autoplays for more than 5 seconds (carousels, background video, animated gradients) has a pause control.

## Motion

- **Honour `prefers-reduced-motion`**: replace movement (parallax, slide-ins, zooms, gradient drift, auto-scrolling) with a fade or nothing. Keep essential feedback such as a progress indicator, minus the travel.
- **No content flashes more than 3 times per second.**
- **Motion has a purpose**, such as showing where something came from, went, or changed. Purely decorative motion is the first thing to remove under reduced motion and often the first thing users complain about.

## Colour and meaning

- **Never colour alone**: status badges get an icon and a text label; errors get an icon and a message; chart series get direct labels, markers or dash patterns; required fields get text.
- **Non-text contrast 3:1** (WCAG 1.4.11) for anything needed to understand or operate the UI: input borders, checkbox and toggle states, focus rings, meaningful icons, chart lines and bars.
- **Check status colours for colour-vision deficiency**: red/green pairs must also differ in lightness or shape. Simulate deuteranopia and protanopia before handoff.

## Modals, drawers, popovers and toasts

- **On open**, focus moves into the dialog (to its heading or first control). Focus is trapped inside, `Escape` closes it, and the background is inert. **On close**, focus returns to the element that opened it.
- **Use the native `<dialog>` element** (with `showModal()`) or a library dialog. Hand-rolled modals usually miss the inert background or the focus return.
- **Toasts** use `role="status"` (polite). Never put the only route to an action inside an auto-dismissing toast: users of screen readers, magnification or switch access may not reach it in time. Undo toasts stay up at least about 5–10 seconds and pause on hover and focus.
- **Popovers and tooltips** triggered by hover also open on focus, can be dismissed with `Escape`, and stay open while the pointer moves onto them (WCAG 1.4.13).

## Tables and data visualisation

- **Tabular data uses a real `<table>`** with `<th scope>` headers. A div grid announces as an unstructured list of numbers. Interactive grids follow the ARIA grid pattern.
- **Charts are distinguishable without colour**: direct labels at line ends beat a colour legend. Lines and bars that carry data need 3:1 against the background.
- **Chart tooltips are reachable by keyboard**, or the same values are available in an adjacent table.
- **Numbers use tabular figures and right-align in columns**, so magnitude can be compared at a glance.

## Navigation and structure

- **One `h1` per page and headings in order** with no skipped levels. Landmarks (`header`, `nav`, `main`, `footer`) are present. Screen-reader users navigate by headings and landmarks first.
- **Each page has a unique, descriptive `<title>`** and a correct `lang` attribute (it sets screen-reader pronunciation).
- **Consistent navigation and help** (WCAG 3.2.3, 3.2.6): nav order and the help or contact link stay in the same place across pages.
- **Mobile tab bars use icon + text label.** Icon-only tab bars fail first-time users and screen readers alike.
- **Orientation isn't locked** (WCAG 1.3.4) unless the content truly needs it, as a piano app does.

## Testing method

Run in this order. Each step catches what the previous one can't.

1. **Keyboard pass**: put the mouse away and complete every primary flow with Tab, Shift+Tab, Enter, Space, the arrow keys and Escape. Check order, visibility, traps and focus return.
2. **Screen reader spot check**: VoiceOver (macOS/iOS), NVDA (Windows) or TalkBack (Android). Take one primary flow end to end and check that names, roles, states and errors are announced and make sense heard in sequence.
3. **Zoom and text scaling**: 200% zoom, a 320px-wide viewport, and the OS's largest text setting on mobile.
4. **Preferences**: toggle reduced motion, dark mode and Windows high-contrast / forced colours.
5. **Automated scan as a floor, not a pass**: axe DevTools, Lighthouse, `eslint-plugin-jsx-a11y`, or `@axe-core/playwright` in CI. These reliably catch missing labels, contrast failures and ARIA misuse. They can't judge whether alt text is meaningful, focus order is logical or an error message is understandable. A clean automated report means "no obvious errors", not "accessible".

## Writing accessibility acceptance criteria

Hand accessibility to the `developer` skill as testable criteria in the PRD's Given/When/Then format, not as "make it accessible":

> **Given** a keyboard-only user on the dashboard, **when** they activate "Filter", **then** focus moves to the drawer heading, Tab cycles within the drawer, Escape closes it, and focus returns to the "Filter" button.

> **Given** a screen-reader user submitting the signup form with an invalid email, **when** they press "Create account", **then** focus moves to the email field and the error "Enter an email address like name@example.com" is announced.

Write one criterion per non-obvious interaction: modals, custom widgets, async updates, error recovery. The generic rules above (contrast, labels, focus visibility) go in the design brief once as a blanket requirement, not repeated per screen.
