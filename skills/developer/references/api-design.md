# API design

Load this when designing a new API surface, adding endpoints to an existing one, or reviewing an API. **If the project already has conventions, follow them.** Consistency within one API beats any rule below.

## Resources and naming

- **Plural nouns for collections, IDs for members**: `/projects`, `/projects/{id}`. Nest at most one level (`/projects/{id}/tasks`). Deeper nesting couples URLs to a hierarchy that will change.
- **Verbs only for actions that aren't CRUD**: `POST /invoices/{id}/send`, not `POST /sendInvoice`.
- **Pick one JSON field casing** (snake_case or camelCase) and never mix within an API.
- **Timestamps are ISO 8601 in UTC** (`2026-11-07T14:30:00Z`). Money is integer minor units plus a currency code (`{"amount": 1999, "currency": "USD"}`), never a float.
- **Expose IDs as opaque strings** (UUIDv7, ULID, or prefixed IDs like `inv_…`) rather than sequential integers. Sequential IDs leak volume and invite enumeration, which turns any missing authorization check into a mass data leak. They don't replace authorization checks, though.

## HTTP semantics and status codes

- GET is safe; GET, PUT, and DELETE are idempotent; POST is not, unless it takes an idempotency key (below).
- Use status codes consistently:

  | Code | Meaning |
  |---|---|
  | 400 or 422 | Validation failed. Pick one and use it everywhere. |
  | 401 | Not authenticated |
  | 403 | Authenticated but not allowed |
  | 404 | Not found, *including* resources that exist but the caller may not see, so existence isn't leaked |
  | 409 | Conflict (version mismatch, duplicate) |
  | 429 | Rate limited, with a `Retry-After` header |
  | 5xx | Server faults only, never for bad input |

## Error envelope

Every error uses one shape, so clients handle errors in one place. RFC 9457 Problem Details (`application/problem+json`) is a good default:

```json
{
  "type": "https://api.example.com/errors/validation",
  "title": "Request validation failed",
  "status": 422,
  "detail": "2 fields are invalid.",
  "request_id": "req_01J…",
  "errors": [
    { "field": "email", "code": "invalid_format", "message": "Must be a valid email address." }
  ]
}
```

- Include a stable machine-readable `code` per field error, so clients don't parse human-readable messages.
- Include the `request_id`, so a user-reported error can be found in the logs.
- Never include stack traces, SQL, internal hostnames, or library versions. Log those server-side only.

## Validation at the boundary

- **Parse each request into a typed schema at the handler** (Zod, Valibot, Pydantic, or similar). The business layer receives typed, validated objects, never raw request bodies.
- **Reject unknown fields on writes.** This prevents mass assignment (a client setting `role: "admin"` or `owner_id` because the ORM accepted every field).
- **Bound everything**: string lengths, array sizes, numeric ranges, and page sizes. Unbounded input is an availability problem.
- **Generate the API docs (OpenAPI) from the same schemas**, so docs and validation can't drift.

## Pagination, filtering, sorting

- **Cursor pagination** for large or frequently changing collections. Take an opaque `cursor` and a `limit`, and return `next_cursor` plus `has_more`. Offset pagination skips or duplicates rows when data changes between pages, and gets slow at deep offsets.
- **Offset pagination** only for small, stable, admin-style lists where jumping to page N matters.
- **Enforce a maximum `limit` server-side**, whatever the client asks for.
- **Allowlist filter and sort fields.** Never pass raw client-supplied field names or expressions into a query. That's an injection path.

## Idempotency

For POST requests that clients may retry (payments, orders, sending messages, anything with side effects):

- Accept an `Idempotency-Key` header (a client-generated UUID).
- Store the key with a hash of the request body and the response, for a window such as 24 hours.
- **Same key, same body** → return the stored response without re-executing.
- **Same key, different body** → reject with 409 or 422. It's a client bug.
- Scope keys per authenticated user or tenant.

## Versioning

Decide before the first external consumer exists:

| Strategy | Fits | Trade-off |
|---|---|---|
| URL prefix (`/v1/…`) | Most public APIs | Simple and visible. Major versions are coarse. |
| Date- or header-based (`API-Version: 2026-11-01`) | APIs that evolve often, with many integrators | Fine-grained, but needs version-translation code on the server |
| No versioning, always backward-compatible | Internal APIs where you deploy all clients | Only works if every change is additive |

- **Non-breaking changes**: new endpoints, new optional request fields, new response fields. Clients must ignore unknown response fields; document that requirement.
- **Breaking changes**: removing or renaming fields, changing types or meaning, new required inputs, or tighter validation. These require a new version and a deprecation window, announced with `Deprecation` and `Sunset` headers.
- Even internal APIs should ship backward-compatible changes, so the server and its clients can deploy independently and roll back independently.

## Timeouts and resilience for outbound calls

- **Every outbound call has a connect timeout and a total timeout.** A missing timeout turns a slow dependency into exhausted threads or connections across your whole service.
- **Retry only idempotent operations**, or ones carrying an idempotency key. Use exponential backoff with jitter and a maximum attempt count. Retrying a non-idempotent POST creates duplicates.
- **Propagate deadlines**. If the caller's request has 2s left, don't start a 5s downstream call.
- **Use a circuit breaker** for dependencies that fail often, so a known-down service is failed fast instead of waited on.

## Webhooks (sending and receiving)

- **Sending**:
  - sign payloads with HMAC, including a timestamp, so receivers can verify origin and reject replays
  - retry with backoff
  - include an event ID
- **Receiving**:
  - verify the signature and timestamp before parsing
  - treat processing as idempotent, keyed on the event ID, because senders retry
  - respond 2xx quickly and do the work asynchronously

## GraphQL notes

If the API is GraphQL rather than REST:
- authorize per field or resolver, not per endpoint
- set query depth and complexity limits
- prefer persisted queries for public clients
- disable introspection in production if the schema is private

The validation, error-shape, and pagination principles above still apply. Use connections/cursors for pagination.
