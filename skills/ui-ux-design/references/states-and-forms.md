# UI states, forms and microcopy

Load this when designing any screen that shows data, takes input, or performs an action that can fail, which is nearly every product screen. The happy path is the one state that always gets designed. The rest are where users actually get stuck, and where builders improvise inconsistently when they aren't specified.

## The state set

For every data-bearing screen or component, design and hand off each of these:

| State | When it happens | Design rule |
|---|---|---|
| **Empty: first use** | No data yet because the user is new | This is onboarding, not an error. Say what will appear here and offer the one action that creates the first item. An illustration is optional; the action isn't. |
| **Empty: no results** | A search or filter matched nothing | Echo the query or filters back, and offer to clear or broaden them. Never reuse the first-use message, because it tells a returning user they have nothing at all. |
| **Empty: cleared** | The user finished or archived everything (inbox zero, all tasks done) | Acknowledge the completion. It's a positive moment, not a blank screen. |
| **Loading** | A fetch is in progress | See the loading table below. |
| **Partial** | Some data loaded; some failed or is still streaming | Show what's there and mark the missing part inline with its own retry. Don't blank the whole screen because one widget failed. |
| **Error** | A request failed | See the error rules below. |
| **Disabled** | An action is unavailable right now | Say why and how to enable it (helper text, or a tooltip that also opens on focus). Often better: keep the control enabled and explain on click. A silently greyed button is a dead end, is skipped by keyboard focus, and usually fails contrast. |
| **Success** | An action completed | Confirm in proportion to the consequence: an inline change for small actions, a toast for background ones, and a confirmation screen saying what happens next for high-stakes ones (payment, submission, publishing). |
| **Offline / stale** | Mobile, flaky networks, long-open tabs | Show the last-updated time, queue writes and say they're queued, and never show stale data as if it were live. |

Every interactive *component* also specifies its interaction states: default, hover (pointer devices only), focus-visible, active/pressed, disabled, loading, and for inputs, error.

## Loading: skeleton vs spinner vs optimistic

| Situation | Use | Why |
|---|---|---|
| Expected under ~300ms | Nothing. Delay any indicator ~300ms | A spinner that flashes on and off reads as jank |
| Layout is known (list, card grid, profile) | Skeleton matching the real layout | Structure appears immediately, so it feels faster, and there's no layout shift when content lands |
| A discrete action (save, submit, send) | Spinner or label change *inside the triggering control*, with the control locked while pending | Ties feedback to its cause and prevents double submission |
| Long (over ~10s) or multi-step (upload, export, import, AI generation) | Determinate progress or a step list, with cancel and "you can leave this page" if true | Indeterminate spinners past ~10s look broken |
| Reversible, high-success-rate action (like, toggle, rename, reorder) | Optimistic UI: apply immediately, then roll back with an inline error if the server rejects | Feels instant. Only safe when failure is rare and rollback is clean, so never for payments, sends, deletes or anything with external side effects |
| Streaming output (LLM responses, live feeds) | Render progressively, with a visible stop control | Users read as it arrives, and stopping saves their time (and tokens) |

## Errors

- **Inline over page-level**: an error belongs next to what caused it (field, card, row). Use a full-page error only when nothing on the page can work, such as a session that expired, a 404 or an outage.
- **Every error offers a next step** as a real control: retry, edit, go back, contact support. An error message with no action is a dead end.
- **Plain language, no blame, no codes up front**: "We couldn't save your changes. Check your connection and try again." A reference ID can go in a secondary line for support. **Never show stack traces or internal messages.** They confuse users and leak implementation detail to attackers (`security-engineer` flags this).
- **Preserve what the user entered.** Never clear a form because submission failed.
- **Separate user-fixable errors from system errors**: validation says how to fix it; a system error apologises, offers retry, and links to status if there is one.
- **Never colour alone**: an icon and text, as in `accessibility.md`.

## Forms

- **Labels go above fields**, visible and persistent. They scan fastest and survive zoom, translation and autofill. Placeholders are only for format hints ("name@example.com"), never the label.
- **Validation timing**: validate a field when the user leaves it, not on every keystroke, since "Invalid email" while someone is still typing is hostile. Once a field is in an error state, re-validate as they type so the error clears the moment it's fixed. Validate everything on submit and move focus to the first error.
- **Error placement and wording**: put the error directly below the field and link it with `aria-describedby`. Say what to do, not what's wrong: "Enter a date after today", not "Invalid date".
- **Required vs optional**: mark whichever is the minority. If most fields are required, mark the few optional ones "(optional)". Better still, cut optional fields: each one costs completions.
- **Input types and autocomplete**: `type="email"` / `tel` / `url`, `inputmode="numeric"` for codes, and the right `autocomplete` token on every personal-data field. Mobile keyboards and password managers depend on them.
- **Accept forgiving input**: allow spaces in card and phone numbers and normalise on the server. Don't split one value across several inputs unless the platform's native picker does.
- **Single column** on every platform. Multi-column forms get fields skipped.
- **The primary button says the outcome** ("Create account", "Pay £40", "Send invite"), not "Submit". Use one primary button per form.
- **Long forms**: break them into steps with a progress indicator, save drafts automatically, and let users go back without losing input.
- **Sensitive fields** (passwords, payment, government IDs, health data): give passwords a show/hide toggle, allow paste, and don't set a maximum length below 64. List these screens in the design brief's security handoff so `security-engineer` reviews masking, autocomplete and storage before build.

## Destructive actions

Make the friction proportionate to what's lost:

| Action | Pattern |
|---|---|
| Reversible (archive, remove from list, soft delete) | Do it immediately and offer **Undo** in a toast (≥ 5–10s, keyboard-reachable, pauses on hover/focus). No confirm dialog. |
| Irreversible, small (delete one item) | A confirm dialog that names the object ("Delete 'Q3 report'?"), a button labelled with the verb ("Delete", not "OK"), and Cancel as the default focus. |
| Irreversible, large (delete account, workspace or production data; revoke all keys) | Type-to-confirm the object's name. State the consequences: what's lost, who's affected, whether billing changes. Offer an export first. |

Confirm dialogs on reversible actions train users to click through, so by the time a dialog really matters, nobody reads it.

## Microcopy

- **Say what happens, in the user's words**: buttons are verb + object ("Save draft", "Invite teammate"), never "OK", "Yes" or "Submit".
- **Front-load the key word** in labels, headings and errors. People scan the first two words.
- **Use one name per concept.** Don't let "workspace", "project" and "team" drift into meaning the same thing. Keep a glossary in the design brief and hold the build to it.
- **Sentence case for UI text**: it's easier to read and translates better. The exception is styles that specify uppercase eyebrow labels (Swiss Technical, Bold Flat Blocks).
- **No blame, no jokes in errors.** Humour belongs in empty states only, only if the brand allows it, and never where the user has just lost something.
- **Numbers, dates and currency follow the user's locale.** Relative times ("2 min ago") show the absolute time on hover, focus or long-press.
- **Leave room for translation**: German and Finnish UI text runs roughly 30% longer than English, so don't design labels that only fit in English.
