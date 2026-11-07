---
name: ui-ux-design
description: UI/UX design for mobile apps, web apps, dashboards and websites, from visual direction through to code-ready output. Use when designing or critiquing screens, components, landing pages or flows; choosing a visual style; reasoning about layout, hierarchy, colour, typography or interaction; or answering UX psychology questions, even when no style is named. Also use for accessibility and WCAG contrast, empty/loading/error states, forms and microcopy, dark mode, and turning a design into design tokens (CSS variables, Tailwind theme) and a design brief a developer can build from. Part of the product-builder plugin. It reads the PRD's audience when one exists and hands states, tokens and accessibility criteria to the developer skill.
---

# UI/UX Design

A design skill covering the *why* (UX psychology, visual design fundamentals), the *how* (six fully specified visual styles), and the *handoff* (accessibility, UI states and design tokens a developer can build from) for mobile apps, web apps and desktop dashboards.

## How to use this skill

1. **Read upstream context first.** If a PRD exists (`docs/product/prd.md`) or the conversation already established the audience and job to be done, use it. It's the input to step 3 of the style fallback logic below.
2. Check the brief against the **style selector** below and load the matching file from `references/`. Load only that one style file, not all six. Each is self-contained: colour, full light and dark tokens, shape, typography, spacing, style-specific psychology, and mobile/desktop adaptation.
3. Apply the **universal principles in this file** together with the loaded style. The style file tells you *what it looks like*; this file tells you *why it works* and *how it behaves across mobile and desktop*.
4. Apply **Accessibility** and **UI states** below to every screen. They're design requirements, not a polish pass. Load `references/accessibility.md` and `references/states-and-forms.md` when designing a screen in detail or reviewing one.
5. If the design is going to be built, **finish with the handoff**: tokens per `references/tokens-handoff.md`, and for multi-screen work or a `build-product` run, a design brief from `templates/design-brief.md`. A single screen discussed in chat doesn't need files.
6. If nothing in the brief signals a style, don't guess silently. Either ask, or pick the style that best fits the product category (see fallback logic below) and say which one you picked and why.

## Universal UX psychology

These apply regardless of which visual style is chosen — they're about how people perceive and navigate interfaces, not about aesthetics. Each style's reference file adds *style-specific* psychology on top of these; it doesn't replace them.

- **Hick's Law:** the more choices presented at once, the longer it takes to decide. Fewer, clearer options at each step beat a comprehensive menu — this is why navigation should favour progressive disclosure over exposing everything up front.
- **Fitts's Law:** the time to reach a target depends on its size and distance from the current point. Primary actions should be large and close to where attention already is (e.g. thumb zone on mobile, cursor-proximity on desktop) — this becomes a hard constraint, not just a suggestion, on mobile touch targets specifically.
- **Cognitive load:** every extra decision, unfamiliar icon, or inconsistent pattern taxes working memory. Consistency (same action always looks the same way) reduces load more reliably than novelty increases delight — default to consistency unless there's a specific reason to break it.
- **Gestalt principles (proximity, similarity, continuity):** elements placed close together, styled alike, or aligned on a shared axis are read as a group even without a visible border. Use spacing and alignment to communicate structure before reaching for dividers or boxes.
- **Visual hierarchy via contrast, not just size:** hierarchy comes from the relationship between size, weight, colour, and spacing together — a large but low-contrast element can lose to a smaller high-contrast one. Check hierarchy by asking what the eye lands on first, not just what's biggest.
- **Progressive disclosure:** show what's needed for the current decision, defer the rest. This is a mobile necessity but a desktop choice — desktop has room to show more at once, so the decision to disclose progressively there should be deliberate, not just inherited from mobile habits.
- **Colour as meaning, not just decoration:** once a colour is used for a semantic purpose (e.g. red = destructive/error), reusing it decoratively elsewhere undermines the signal. Reserve semantic colours and keep brand/decorative colour separate from them.

## Platform adaptation: mobile vs. desktop/web

This applies inside whichever style is chosen — a style's *look* stays consistent across platforms, but its *behaviour* has to adapt.

**Layout & structure**
- Mobile: single column, bottom tab bar or hamburger navigation, full-bleed sections, one primary decision per screen.
- Desktop/web: multi-column grids, persistent sidebar or top nav, more can be shown simultaneously without feeling cramped — density is an asset, not a compromise.

**Interaction model**
- Mobile: touch targets ≥ 44×44pt on iOS and ≥ 48×48dp on Android, gesture-based navigation (swipe, pull-to-refresh) with a visible alternative for every gesture, and no interaction that depends on hover, since there isn't one.
- Desktop: hover states can carry real information (tooltips, row highlighting, preview-on-hover), click targets can be smaller since cursor precision is higher, keyboard shortcuts become viable for power users.

**Information density**
- Mobile: progressive disclosure by necessity — screen space is the constraint.
- Desktop: can combine a data table, a chart, and a detail panel in one view without overwhelming, because there's room for the eye to segment them. Don't force mobile's one-thing-at-a-time pattern onto desktop just for consistency — that wastes the space desktop offers.

**Per-style note:** each reference file has a "Mobile adaptation" and "Desktop / web adaptation" section showing how that specific style's visual language (colour, shape, depth) translates across the two — read both if the project spans platforms.

## Visual design foundations

These baseline rules hold across all six styles unless a specific reference file says otherwise:

- **Type scale:** establish a clear ratio between heading and body sizes (not just "a bit bigger") — insufficient contrast between levels is the most common cause of flat-feeling hierarchy.
- **Spacing system:** use a consistent spacing unit (e.g. 4px or 8px base) rather than arbitrary values — inconsistent spacing is one of the fastest ways for an interface to feel unpolished even when every individual element is well-designed.
- **Colour count:** most well-designed interfaces use fewer colours than feels intuitive — a restrained palette with disciplined semantic use (see above) consistently reads as more premium than a colourful one.
- **Alignment:** every element should sit on a shared grid or alignment axis; unaligned elements are one of the fastest tells of an unpolished layout, even to viewers who can't articulate why something looks "off."

## Accessibility (every screen)

Retrofitting accessibility costs far more than designing it in, and WCAG 2.2 AA is a legal requirement in a growing number of markets. These rules are must-apply. The per-component checklist, the testing method and the acceptance-criteria format are in `references/accessibility.md`. Load it when designing a screen in detail, writing criteria for the developer, or reviewing an existing UI.

- **Check contrast; don't eyeball it.** 4.5:1 for body text. 3:1 for large text (≥ 24px, or ≥ 18.66px bold) and for non-text UI: input borders, meaningful icons, focus rings, chart marks. Every style's tokens are pre-checked. Any new colour pair is checked before use, and gradients and photos are checked at the worst point under the text.
- **Visible focus on everything interactive**: a ring of at least 2px at 3:1 against its surroundings, via `:focus-visible`. Never remove the outline without a replacement.
- **Keyboard-complete**: every action is reachable in visual order. Modals trap focus and return it on close, and Escape closes overlays.
- **Semantics before ARIA**: use real buttons, links, labels, headings and tables. Use ARIA only for patterns HTML can't express, following the WAI-ARIA pattern or a library that implements it.
- **Target size**: 24×24 CSS px is the WCAG 2.2 floor. On touch, design to platform norms of 44×44pt (iOS) and 48×48dp (Android).
- **Never colour alone**: status, errors, required fields and chart series also carry an icon, a label or a pattern.
- **Motion respects `prefers-reduced-motion`**: replace movement with a fade or nothing. Nothing flashes more than 3 times per second.
- **Text scales**: layouts survive 200% zoom, 320px reflow, and iOS Dynamic Type / Android font scaling without truncating or overlapping.

## UI states (every data-bearing screen)

A screen isn't designed until its non-happy states are. For each screen that shows data or performs an action, specify these states:

- **Empty**: first use, no results and cleared are three different messages.
- **Loading**: a skeleton when the layout is known, a spinner inside the control for discrete actions, optimistic UI only for reversible actions.
- **Partial**: show what loaded and mark what failed inline.
- **Error**: inline, with a recovery action, keeping the user's input.
- **Disabled**: say why.
- **Success**: in proportion to the consequence.

Forms get labels above fields, validation when the user leaves a field, and errors below the field that say how to fix the problem. Destructive actions get undo if reversible, a confirmation that names the object if not, and type-to-confirm if the loss is large.

Load `references/states-and-forms.md` for any screen with data, input or async actions. It has the loading decision table, error rules, form rules, destructive-action patterns and microcopy rules.

## Dark mode

These principles apply to any style shipped in both themes. Each style reference has a dark token set, and the light styles also have a Dark mode section covering the style-specific translation.

- **Don't simply invert.** A pure `#000` base with `#FFF` text causes glare and halation for many readers. Use a near-black base and off-white text. Bold Flat Blocks is the deliberate exception.
- **Elevation flips to lightness.** Shadows barely read on dark, so raised surfaces get progressively lighter (base → raised → overlay), with shadow as a secondary cue at most.
- **Desaturate and lighten accents.** Saturated mid-tones that pass on white often fail or vibrate on dark. Shift them lighter, and usually put dark text on accent fills.
- **Semantic colours keep their meaning, not their hex.** Red still means danger, at a lighter value that passes on dark.
- **Re-check every contrast pair.** A passing light theme says nothing about the dark one.
- **Images and illustrations**: dim large photos slightly. Swap dark-stroke illustrations and logos on transparent backgrounds, because they vanish on dark.
- **Respect the user's choice**: follow the OS by default, offer an explicit override, and remember it. Moody Editorial is the exception (dark by default, light as an opt-in).

## Design → code handoff

Design output that's going to be built should end up as tokens and a brief, not as hex values and prose scattered through a chat.

- **Tokens**: emit the chosen style's `## Tokens` set as CSS custom properties (light + dark), as a Tailwind v4 theme, or **mapped into the project's existing design system**. Never create a parallel second system. Load `references/tokens-handoff.md` whenever tokens are written or a theme is added. It has the required token list, the output formats, the shadcn/ui mapping and the contrast rule.
- **Design brief**: for multi-screen work or a `build-product` run, fill `templates/design-brief.md` into `docs/design/brief.md`. It covers screens, per-screen states, accessibility acceptance criteria and handoff notes. A single screen in chat doesn't need the file; give the same information inline.
- **An existing design system in the codebase wins.** Check for one (theme file, Tailwind config, component library) before proposing tokens. Use the style reference to choose values *within* it rather than replacing it.

## Inputs and handoffs

**Reads**
- **`docs/product/prd.md`** (from `product-management`):
  - target audience and job to be done → style selector, fallback step 3
  - context of use → which platform leads
  - user stories → the screen list
  - North Star and input metrics → which number gets the focal treatment on a dashboard

  If there's no PRD, infer the audience from the brief and state the assumption in one line. Ask only when the screen is brand-defining (fallback step 4).
- **The existing codebase**: theme files, a component library, or tokens already in use. These override the style reference's literal values.

**Hands off**
- **→ `developer`**: the token file; the design brief (screens, per-screen states, component states, responsive behaviour); accessibility requirements written as Given/When/Then acceptance criteria; and the analytics events for PRD metrics that fire on these screens.
- **→ `security-engineer`**: every screen that collects or displays credentials, payment details, PII, or health or financial data. These are listed in the brief's security handoff, so masking, autocomplete, storage and per-user data scoping get reviewed before build rather than after.
- **→ `product-management`**: questions that turn out to be product decisions rather than design ones. For example, what a new user's empty dashboard should push them towards depends on which activation metric matters.

## Style selector

Match the brief's language against this table to choose a reference. If multiple seem plausible, prefer the one matching the product category over the one matching adjectives alone.

| Signal in the brief | Product category fit | Reference file |
|---|---|---|
| "warm," "soft," "glowing," "gradient," "dreamy," "premium fintech" | Consumer finance, wellness-adjacent, onboarding flows | `ambient-gradient.md` |
| "moody," "dark mode," "editorial," "photographic," "calm," "intimate" | Wellness, meditation, lifestyle, content-led apps | `moody-editorial.md` |
| "clean dashboard," "data-heavy," "control centre," "internal tool," "admin" | Internal tools, ops dashboards, B2B admin panels | `soft-minimal-dashboard.md` |
| "bold," "punchy," "no-nonsense," "brutalist," "high-contrast," "confident" | B2B/enterprise wanting differentiation, direct brand voice | `bold-flat-blocks.md` |
| "modern SaaS," "polished," "startup," "pill buttons," "friendly but professional" | Consumer/prosumer SaaS, general-purpose product dashboards | `modern-saas-light.md` |
| "technical," "precise," "engineered," "grid-driven," "blueprint," "developer/security tool," "editorial B2B" | Developer tools, security/infra products, technical B2B marketing | `swiss-technical.md` |

"Dark mode" on its own is not a style signal. Every style has a dark token set. It points to Moody Editorial only when it comes with the emotional, content-led signals in that row.

**Fallback logic, in order:**
1. Explicit style name given → load that reference directly, no further inference needed.
2. Descriptive language matches a row above → infer and load; state which style was chosen and why in one line, so the choice is visible rather than silent.
3. A structural keyword (e.g. "dashboard", "app", "site") appears without a style adjective → don't pattern-match the keyword alone. Check who the interface is for and why. "Dashboard" alone is not enough to route to Soft Minimal Dashboard: an internal ops tool and a consumer habit tracker are both "dashboards" but need opposite treatment (restrained/neutral vs. approachable/friendly). Weigh audience and context over the noun. **If a PRD exists, its target audience and job to be done answer "who and why"; use them instead of guessing.**
4. No signal at all, and context doesn't clearly imply a category → ask one clarifying question if the ambiguity is high-stakes (e.g. it's a brand-defining screen), or default to Modern SaaS Light as the safest general-purpose starting point and say so — don't block on asking every time.

## Reference files

**Styles** (load exactly one, the one the selector picks):
- `references/ambient-gradient.md` — soft gradient mesh, glow-based depth, rounded everything
- `references/moody-editorial.md` — dark base, photography-led, minimal chrome; dark by default
- `references/soft-minimal-dashboard.md` — light neutral base, restrained colour-for-data, soft shadow elevation
- `references/bold-flat-blocks.md` — solid saturated blocks, zero depth, high contrast
- `references/modern-saas-light.md` — white base, gradient accents in data viz, pill shapes; the fallback default
- `references/swiss-technical.md` — neutral paper base, visible modular grid, monospace labels, two-tone headlines

Each style file is self-contained: colour, a full light and dark token set, shape and depth rules, typography, spacing, style-specific UX psychology, and mobile/desktop adaptation. No cross-referencing between style files should be needed.

**Cross-cutting** (load when the trigger applies, alongside the style file):
- `references/accessibility.md` — when designing a screen in detail, writing accessibility acceptance criteria, or reviewing a UI
- `references/states-and-forms.md` — when a screen shows data, takes input or runs async actions
- `references/tokens-handoff.md` — when writing tokens, adding a theme, or handing a design to the developer

**Template:**
- `templates/design-brief.md` — the design brief for multi-screen work or a `build-product` run, saved to `docs/design/brief.md`
