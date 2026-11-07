# Stack defaults

> **Last reviewed: November 2026. Verify current versions before pinning.** These are starting points, not mandates. Tools and pricing change; check each one's current docs before committing, and never pin a version from memory.

Load this when choosing a stack or a major tool. Each default is a choice that passes the weighing criteria in `SKILL.md` for a typical solo developer or small team shipping a first version. Criterion 1 (familiarity) overrides the table: a team fluent in Rails, Django, Laravel, or .NET ships faster in that than in any default below.

When using a default, state it and the one-line reason, and record it as an ADR if it's hard to reverse.

## By project shape

| Project shape | Default | Why | Deviate when |
|---|---|---|---|
| Full-stack web app / SaaS | **TypeScript + Next.js**, deployed on Vercel or any Node host; **Postgres** on a managed host (Neon, Supabase, AWS RDS, Google Cloud SQL); **Drizzle** or **Prisma** ORM; **Tailwind CSS** | One language end to end, the largest ecosystem, and relational data fits most products | The team knows Django, Rails, or Laravel → use it (batteries-included auth, ORM, admin). It's a logged-in-only internal tool with no SEO needs → React + Vite SPA plus a separate API is simpler. |
| Authentication | **A managed auth provider** (Clerk, Auth0, WorkOS, Supabase Auth) or a maintained library (Better Auth, Auth.js, or the framework's built-in auth) | Auth is the most security-sensitive code in most apps, and the edge cases (MFA, reset flows, session revocation) are where hand-rolled auth breaks | Strict data-residency or cost constraints → self-host an open-source identity server (Keycloak, Ory). Never hand-roll password storage or session handling. |
| Python service / data- or ML-heavy backend | **FastAPI + Pydantic**, **SQLAlchemy 2.x** + Alembic migrations, Postgres; **uv** for environments and dependencies | Typed validation at the boundary, async support, and the Python data ecosystem | Need admin, auth, and ORM out of the box → Django (with Django REST Framework or Django Ninja for APIs) |
| Background jobs / queues | **Postgres-backed queue** first (Graphile Worker or pg-boss in Node; Procrastinate in Python), or a managed workflow service (Inngest, Trigger.dev) | No new infrastructure while volume is modest, and jobs share the database's transactions | High throughput or fan-out → a dedicated broker (SQS, Redis-based queues like BullMQ or Celery, Kafka for event streams) |
| Cross-platform mobile | **Expo (React Native)** with EAS Build | Shares TypeScript and logic with a web codebase, plus over-the-air updates for JS changes | The team knows Dart, or needs pixel-identical custom rendering → Flutter |
| Native mobile, deep platform integration | **SwiftUI** (iOS) / **Jetpack Compose** (Android) | Widgets, background tasks, HealthKit/HealthConnect, AR, and first-day access to new OS APIs | Two platforms on a small team with shallow integration needs → Expo |
| Desktop app reusing web skills | **Tauri** | Small binaries and low memory (uses the system webview), with a Rust core for privileged operations | Need identical rendering on every OS, Node APIs, or a mature plugin ecosystem → Electron |
| Static / marketing / docs site | **Astro** (Starlight for docs) on a CDN host (Cloudflare Pages, Netlify, Vercel) | Ships zero JavaScript by default, and content collections handle Markdown/MDX | Marketing team needs a visual editor → a headless CMS (Sanity, Contentful, Payload) feeding Astro, or a hosted builder (Webflow, Framer) |
| Serverless, spiky or cost-sensitive backend | **AWS Lambda + DynamoDB or Aurora Serverless**, defined with **SST** or **AWS CDK**; or **Cloudflare Workers + D1/R2** for globally distributed, light workloads | Scales to zero, pay per request | Long-running, stateful, or WebSocket-heavy work → a container platform (next row) |
| Long-running / stateful backend, WebSockets | **A container on a managed platform** (Fly.io, Render, Railway, Google Cloud Run, AWS ECS/Fargate) | No cold starts or execution-time limits fighting persistent state | Already on Kubernetes with a platform team → use it. Don't adopt Kubernetes for a first version. |
| Realtime collaboration / presence | **A managed realtime service** (Liveblocks, Ably, Pusher, Supabase Realtime) | Presence, reconnection, and fan-out are hard to get right | Very high volume where per-message pricing dominates → self-hosted WebSockets on the container platform |
| AI / LLM features | **Claude via the Anthropic API and official SDK** (TypeScript or Python). Load the `claude-api` skill for current model IDs, pricing, and features. | Official SDKs handle retries, streaming, and tool-use types | Multi-provider routing is a hard requirement → a thin internal interface over provider SDKs. Avoid heavy frameworks for a single-provider app. |

## Cross-cutting defaults

| Concern | Default | Notes |
|---|---|---|
| Language settings | TypeScript `strict` mode; Python with type hints checked in CI (mypy or Pyright) | Type checking is cheapest at project start |
| Package management | pnpm (JS/TS), uv (Python) | Commit the lockfile, always |
| Lint / format | Biome, or ESLint + Prettier (JS/TS); Ruff (Python) | Run in CI and as a pre-commit hook |
| Unit / integration tests | Vitest (JS/TS), pytest (Python); Testcontainers for a real database in integration tests | Don't mock your own database layer |
| End-to-end tests | Playwright | Reserve for critical journeys |
| CI/CD | GitHub Actions (or the CI built into the existing Git host) | Pin third-party actions to a commit SHA |
| Dependency updates | Renovate or Dependabot | Group minor updates to cut PR noise |
| Secret scanning | Gitleaks in CI and pre-commit, plus the Git host's built-in secret scanning and push protection | Rotate on any hit; deleting the commit isn't enough |
| SAST | Semgrep or CodeQL | Fail the build on high-severity findings only, or the alerts get ignored |
| Infrastructure as code | OpenTofu/Terraform for multi-cloud or mixed providers; SST or AWS CDK for AWS-only TypeScript teams; Pulumi for teams wanting a general-purpose language | One tool per project |
| Secrets management | The hosting platform's encrypted environment variables for small projects; AWS Secrets Manager, GCP Secret Manager, Doppler, or 1Password Secrets Automation when secrets are shared across services | Never a committed `.env` |
| Error tracking | Sentry | Tag events with release and environment |
| Traces / metrics | OpenTelemetry SDK, exported to your chosen backend (Grafana Cloud, Honeycomb, Datadog, or self-hosted) | Instrument with OpenTelemetry so the vendor can change later |
| Product analytics + feature flags + experiments | PostHog (open source, one tool for all three), or Amplitude/Mixpanel plus a flag service (LaunchDarkly, GrowthBook, Unleash) | Server-side events for metrics the PRD depends on |
| Payments | Stripe (or Paddle / Lemon Squeezy as merchant of record, to offload global sales-tax handling) | Never store raw card data; use hosted checkout or elements |
| Transactional email | Resend, Postmark, or Amazon SES | Set up SPF, DKIM, and DMARC before the first send |
| File storage | S3-compatible object storage (AWS S3, Cloudflare R2, GCS) with private buckets and signed URLs | Never public-by-default buckets |
