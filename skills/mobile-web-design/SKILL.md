---
name: mobile-web-design
description: Use this skill for any UI/UX design work on mobile apps, web apps, or desktop dashboards — including designing new screens, giving design feedback, choosing a visual direction, building landing pages, or reasoning about layout, hierarchy, colour, or interaction. Trigger this whenever the user asks for help designing an app, a screen, a component, a dashboard, or a website, even if they don't name a specific visual style — the skill selects one based on the brief. Also trigger for questions about UX psychology, visual hierarchy, or why a design choice works, even without an explicit "design this" request.
---

# Mobile & Web Design System

A design skill covering both the *why* (UX psychology, visual design fundamentals) and the *how* (five distinct visual styles, each fully specified) for mobile apps, web apps, and desktop dashboards.

## How to use this skill

1. Read the brief and check it against the **style selector** below to identify which visual direction fits.
2. Load the matching file from `references/` — only that one file, not all five. Each is self-contained with colour, shape, typography, spacing, and platform-specific rules for that style.
3. Apply the **universal principles in this file** (psychology, platform adaptation, foundations) together with the loaded style file. The style file tells you *what it looks like*; this file tells you *why it works* and *how it behaves across mobile vs. desktop*.
4. If nothing in the brief signals a style, don't guess silently — either ask, or pick the style that best fits the product category (see fallback logic below) and say which one you picked and why.

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
- Mobile: touch targets ≥44px, gesture-based navigation (swipe, pull-to-refresh), no interaction should depend on hover since there isn't one.
- Desktop: hover states can carry real information (tooltips, row highlighting, preview-on-hover), click targets can be smaller since cursor precision is higher, keyboard shortcuts become viable for power users.

**Information density**
- Mobile: progressive disclosure by necessity — screen space is the constraint.
- Desktop: can combine a data table, a chart, and a detail panel in one view without overwhelming, because there's room for the eye to segment them. Don't force mobile's one-thing-at-a-time pattern onto desktop just for consistency — that wastes the space desktop offers.

**Per-style note:** each reference file has a "Mobile adaptation" and "Desktop / web adaptation" section showing how that specific style's visual language (colour, shape, depth) translates across the two — read both if the project spans platforms.

## Visual design foundations

Baseline rules that hold across all five styles unless a specific reference file says otherwise:

- **Type scale:** establish a clear ratio between heading and body sizes (not just "a bit bigger") — insufficient contrast between levels is the most common cause of flat-feeling hierarchy.
- **Spacing system:** use a consistent spacing unit (e.g. 4px or 8px base) rather than arbitrary values — inconsistent spacing is one of the fastest ways for an interface to feel unpolished even when every individual element is well-designed.
- **Colour count:** most well-designed interfaces use fewer colours than feels intuitive — a restrained palette with disciplined semantic use (see above) consistently reads as more premium than a colourful one.
- **Alignment:** every element should sit on a shared grid or alignment axis; unaligned elements are one of the fastest tells of an unpolished layout, even to viewers who can't articulate why something looks "off."

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

**Fallback logic, in order:**
1. Explicit style name given → load that reference directly, no further inference needed.
2. Descriptive language matches a row above → infer and load; state which style was chosen and why in one line, so the choice is visible rather than silent.
3. A structural keyword (e.g. "dashboard," "app," "site") appears without a style adjective → don't pattern-match the keyword alone. Check who the interface is for and why. "Dashboard" alone is not enough to route to Soft Minimal Dashboard — an internal ops tool and a consumer habit tracker are both "dashboards" but need opposite treatment (restrained/neutral vs. approachable/friendly). Weigh audience and context over the noun.
4. No signal at all, and context doesn't clearly imply a category → ask one clarifying question if the ambiguity is high-stakes (e.g. it's a brand-defining screen), or default to Modern SaaS Light as the safest general-purpose starting point and say so — don't block on asking every time.

## Reference files

- `references/ambient-gradient.md` — soft gradient mesh, glow-based depth, rounded everything
- `references/moody-editorial.md` — dark base, photography-led, minimal chrome
- `references/soft-minimal-dashboard.md` — light neutral base, restrained colour-for-data, soft shadow elevation
- `references/bold-flat-blocks.md` — solid saturated blocks, zero depth, high contrast
- `references/modern-saas-light.md` — white base, gradient accents in data viz, pill shapes
- `references/swiss-technical.md` — neutral paper base, visible modular grid, monospace labels, two-tone headlines

Load only the file that matches the brief. Each is self-contained — colour tokens, shape/depth rules, typography, spacing, a style-specific UX psychology section, and mobile/desktop adaptation notes — so no cross-referencing between style files should be needed.
