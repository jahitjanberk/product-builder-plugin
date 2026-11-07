# Design tokens and design → code handoff

Load this whenever tokens are being written for a project, a design is being handed to the `developer` skill, or a theme (e.g. dark mode) is being added to an existing UI. The goal is that a chosen style arrives in code as one token file, not as hex values scattered through components.

## Two tiers: primitives → semantics

- **Primitives** are the raw palette (`--indigo-600: #4F46E5`). They describe what a value *is*, never where it's used, and components never reference them directly.
- **Semantic tokens** name a *role* (`--accent: var(--indigo-600)`), and components only ever use semantic tokens. This is what makes dark mode, a rebrand or an accessibility fix a one-file change instead of a search through the whole codebase: the dark theme reassigns the same semantic names to different primitives.
- **Skip a third tier (component tokens like `--button-bg`) unless several teams share the design system.** For a single product it adds indirection without payoff.

The style references give semantic values directly as hex for brevity. In a project, either keep that or split into primitives. Both are fine as long as components only see semantic names.

## Required semantic set

Every style reference defines all of these, in light and dark. If a project needs a token not on this list, add it to the semantic layer with a role name. Don't reach for a raw hex inside a component.

| Group | Tokens | Rule |
|---|---|---|
| Surfaces | `--surface-base`, `--surface-raised`, `--surface-overlay` | Base = page; raised = cards and panels; overlay = modals, popovers, menus. In dark mode each step up is *lighter*. |
| Text | `--text-primary`, `--text-secondary`, `--text-on-accent` | Primary and secondary ≥ 4.5:1 on every surface. There's deliberately no "tertiary" or "disabled" text token. A third grey is where contrast failures live; see disabled states in `states-and-forms.md`. |
| Borders | `--border`, `--border-strong` | `--border` is decorative (dividers, card edges) and has no contrast minimum. `--border-strong` marks a control's boundary when nothing else does (inputs, checkboxes, toggles) and needs ≥ 3:1 against adjacent surfaces. |
| Accent | `--accent`, `--accent-hover` | The interactive colour: primary buttons, links, active states. ≥ 3:1 against surfaces; `--text-on-accent` ≥ 4.5:1 on both. |
| Focus | `--focus-ring` | ≥ 3:1 against every surface it can appear on. Where no single colour can manage that (e.g. Bold Flat Blocks), use a two-colour ring. |
| Status | `--success`, `--warning`, `--danger`, each with `--text-on-success` / `-warning` / `-danger` | Each status colour ≥ 4.5:1 against base and raised surfaces, because it gets used as inline error text, not just as a fill. Each text-on pair ≥ 4.5:1. Reserved for meaning, never decoration. |
| Radius | `--radius-sm`, `--radius-md`, `--radius-lg` (+ `--radius-full` for pills) | Styles with no rounding set them to `0` explicitly. |
| Spacing | `--space-1` … `--space-8` | 4px base: 4, 8, 12, 16, 24, 32, 48, 64. |
| Type | `--font-sans`, `--font-mono` (+ `--font-display` if the style uses one), `--text-xs` … `--text-3xl` | Seven steps. The display steps (`2xl`, `3xl`) use `clamp()` so they shrink on mobile without a breakpoint. |
| Elevation | `--shadow-sm`, `--shadow-md`, `--shadow-lg` | Styles with no shadows set them to `none` explicitly, so a component that reaches for a shadow gets nothing rather than an invented one. |
| Motion | `--duration-fast`, `--duration-base`, `--duration-slow`, `--ease-standard` | Collapse to near-zero under `prefers-reduced-motion` (see below). |

Style-specific extras (gradient stops, data-viz series, colour blocks, image tints) sit alongside these and follow one rule: **anything that carries text gets a `--text-on-*` partner, and the pair is contrast-checked.**

## Output format 1: CSS custom properties (default)

Use this when the project has no styling system yet, or as the source file other formats reference. Light is the default; dark follows the OS unless the user has chosen explicitly.

```css
/* tokens.css */
:root {
  color-scheme: light;
  --surface-base: #FFFFFF;
  /* …full light set from the style reference… */
}

@media (prefers-color-scheme: dark) {
  :root:not([data-theme="light"]) {
    color-scheme: dark;
    --surface-base: #0E1017;
    /* …full dark set… */
  }
}

/* An explicit user choice overrides the OS */
:root[data-theme="dark"] {
  color-scheme: dark;
  --surface-base: #0E1017;
  /* …same dark set… */
}

@media (prefers-reduced-motion: reduce) {
  :root {
    --duration-fast: 0.01ms;
    --duration-base: 0.01ms;
    --duration-slow: 0.01ms;
  }
}
```

- **The duplicated dark block is deliberate.** Repeating it inside the media query and under `[data-theme="dark"]` is the only plain-CSS way to support "follow system" and "force dark" together. If there's a build step, generate both from one source.
- **`color-scheme` makes native controls match the theme** (scrollbars, inputs, date pickers, autofill). Leaving it out is the most common cause of "dark mode looks broken in one spot".
- **Apply a stored theme choice before first paint**, with a few lines of inline script in `<head>` that set `data-theme` from storage. Otherwise the page flashes the wrong theme on every load.
- **Moody Editorial is the exception:** it defaults to dark regardless of OS and offers light only as an explicit setting. See its reference.

## Output format 2: Tailwind v4

Keep `tokens.css` as the single source of values and expose the *themable* tokens to Tailwind with `@theme inline`, so utilities like `bg-surface-raised` resolve to the runtime variable and switch with the theme:

```css
@import "tailwindcss";
@import "./tokens.css";

/* Themable: colours change between light and dark, so utilities read the runtime variable */
@theme inline {
  --color-surface-base: var(--surface-base);
  --color-surface-raised: var(--surface-raised);
  --color-surface-overlay: var(--surface-overlay);
  --color-fg: var(--text-primary);
  --color-fg-muted: var(--text-secondary);
  --color-on-accent: var(--text-on-accent);
  --color-border: var(--border);
  --color-border-strong: var(--border-strong);
  --color-accent: var(--accent);
  --color-accent-hover: var(--accent-hover);
  --color-focus: var(--focus-ring);
  --color-success: var(--success);
  --color-on-success: var(--text-on-success);
  --color-warning: var(--warning);
  --color-on-warning: var(--text-on-warning);
  --color-danger: var(--danger);
  --color-on-danger: var(--text-on-danger);
}

/* Static: same in both modes, so give Tailwind the values directly */
@theme {
  --radius-sm: 8px;
  --radius-md: 14px;
  --radius-lg: 20px;
  --font-sans: "Inter", ui-sans-serif, system-ui, sans-serif;
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);
  /* type scale, etc. */
}
```

- **Name colours under `--color-*` and never reuse a runtime variable's name inside `@theme`.** `--radius-sm: var(--radius-sm)` refers to itself and breaks. Static scales get literal values in `@theme`, and themable ones go through `@theme inline` under a different name.
- **If a style's dark set changes the shadows**, apply them in component CSS (`box-shadow: var(--shadow-md)`) rather than through Tailwind's `shadow-*` utilities, which take their value from `@theme` and won't follow the theme.
- **Use the `dark:` variant for one-offs only.** If components are full of `dark:` overrides, the tokens are missing a semantic role.

## Mapping into an existing design system

If the project already has a theme (shadcn/ui CSS variables, MUI or Chakra theme, a company design system, a Figma variables export), **map the chosen style onto its names instead of adding a parallel set.** Two token systems in one codebase means every component author guesses which one is real, and dark mode ends up only half-working.

Example: shadcn/ui variables ← this skill's semantic tokens.

| shadcn/ui | ← semantic token |
|---|---|
| `--background` / `--foreground` | `--surface-base` / `--text-primary` |
| `--card` / `--card-foreground` | `--surface-raised` / `--text-primary` |
| `--popover` / `--popover-foreground` | `--surface-overlay` / `--text-primary` |
| `--primary` / `--primary-foreground` | `--accent` / `--text-on-accent` |
| `--muted-foreground` | `--text-secondary` |
| `--border` / `--input` | `--border` / `--border-strong` |
| `--ring` | `--focus-ring` |
| `--destructive` | `--danger` |
| `--radius` | `--radius-md` |

**Watch the name collision.** shadcn/ui's `--accent` is a *subtle hover background*, not the brand accent. Map this skill's `--accent` to shadcn's `--primary`, and map shadcn's `--accent` to a subtle surface such as `--accent-subtle` where the style defines one.

## Contrast validation rule

Before handing tokens off, check every pair the required-set table names, **in every theme**:

- Compute the WCAG 2.x contrast ratio from relative luminance. Never eyeball it. Thresholds: 4.5:1 for text, 3:1 for large text (≥ 24px, or ≥ 18.66px bold) and for non-text UI.
- **Composite semi-transparent colours over their real background before checking.** For a scrim or overlay, use the worst case beneath it (e.g. a white sky in a photo).
- **Gradients and images:** check text against the lightest point under light text and the darkest point under dark text.
- **When a pair fails, fix the token, not the component**, so the fix applies everywhere at once.
- **Record the result in the design brief.** Note "all pairs pass" or list exceptions with the reason, e.g. a decorative-only use.

A minimal checker, enough to run in a scratch script or a unit test:

```js
// WCAG 2.x contrast ratio for two #RRGGBB colours
const luminance = (hex) => {
  const [r, g, b] = [1, 3, 5]
    .map((i) => parseInt(hex.slice(i, i + 2), 16) / 255)
    .map((c) => (c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ** 2.4));
  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
};
const contrast = (a, b) => {
  const [hi, lo] = [luminance(a), luminance(b)].sort((x, y) => y - x);
  return (hi + 0.05) / (lo + 0.05);
};
// contrast("#5B6070", "#F5F6F8") → 5.79
```
