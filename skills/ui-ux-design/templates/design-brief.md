# Design brief: {product or feature name}

<!--
Produced by product-builder:ui-ux-design. Save to docs/design/brief.md (or the project's docs convention).
Reads: docs/product/prd.md (audience, JTBD, user stories, KPIs).
Read by: developer (tech spec, build), security-engineer (sensitive screens), build-product (launch checklist).
Fill every section; write "n/a: <reason>" rather than deleting one, so a skipped decision is visible.
-->

| | |
|---|---|
| Status | Draft / Agreed |
| Last updated | YYYY-MM-DD |
| PRD | `docs/product/prd.md` |
| Tokens | `docs/design/tokens.css` *(or the project theme file they were mapped into)* |

## 1. Audience and job

*Taken from the PRD. If there's no PRD, state the assumption and mark it.*

- **Primary audience:**
- **Job to be done:**
- **Context of use:** devices, environment (desk all day? one-handed outdoors? night-time?), session length, frequency
- **Known accessibility needs for this audience:** e.g. older users, low-vision, keyboard-heavy power users

## 2. Visual direction

- **Style:** {style name} (`references/{file}.md`)
- **Why, in one line, tied to audience and category:**
- **Primary platform:** mobile / desktop / both (which one leads)
- **Themes:** light / dark / both; default and whether it follows the OS
- **Brand constraints carried in:** existing colours, typeface, logo, existing design system

## 3. Screens and flows

| # | Screen / flow | User goal | Primary action | PRD story |
|---|---|---|---|---|
| 1 | | | | |

## 4. States per screen

*Tick each state as it's designed; note anything screen-specific. See `references/states-and-forms.md`.*

| Screen | Empty: first use | Empty: no results | Loading | Partial | Error | Disabled | Success | Offline |
|---|---|---|---|---|---|---|---|---|
| | | | | | | | | |

Destructive actions on these screens and their pattern (undo / confirm / type-to-confirm):

-

## 5. Accessibility requirements

**Blanket requirements (apply to every screen):**

- [ ] WCAG 2.2 AA. Every token pair passes in every theme (result in §6)
- [ ] Visible `:focus-visible` ring on all interactive elements; logical tab order
- [ ] Touch targets ≥ 44pt (iOS) / 48dp (Android); ≥ 24px on pointer UIs
- [ ] No meaning by colour alone; reduced-motion behaviour defined
- [ ] Layout survives 200% zoom, 320px reflow, and the largest OS text size

**Screen-specific acceptance criteria** *(Given / When / Then; one per non-obvious interaction: modals, custom widgets, async updates, error recovery):*

- **Given** … **when** … **then** …

## 6. Tokens

- **Location:**
- **Format:** CSS custom properties / Tailwind v4 theme / mapped into {existing system}
- **Mapping table** (if mapped into an existing system):
- **Contrast check:** all pairs pass / exceptions: {pair, ratio, reason}

## 7. Content

- **Glossary** (one term per concept):
- **Tone:**
- **Key microcopy:** primary buttons, first-use empty states, the top 3 error messages

## 8. Handoff notes

**→ developer**

- Components to build vs reuse (which library):
- Interactions not obvious from mocks (animation, optimistic updates, keyboard shortcuts, drag and drop):
- Responsive behaviour: breakpoints and what changes at each:
- Analytics events for the PRD's KPIs that fire on these screens:

**→ security-engineer**

- Screens that collect credentials, payment details, PII, or health / financial data:
- Data shown on screen that must be scoped per user or role:
- Sensitive values displayed (masked? reveal on click? copy allowed?):

**→ product-management** (product decisions surfaced during design)

-

## 9. Open questions

| Question | Owner | Needed by |
|---|---|---|
| | | |
