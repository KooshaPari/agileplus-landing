# agileplus-landing

Landing page at `agileplus.kooshapari.com` for [KooshaPari/AgilePlus](https://github.com/KooshaPari/AgilePlus).

Pulls README at build time from GitHub. Tier 2 of the org-pages tree (Tier 1 is `projects.kooshapari.com`).

## Stack

- Astro 6 + Tailwind 4
- Deployed on Vercel (custom domain via Cloudflare CNAME)
- Build-time fetch of repo metadata + README HTML from GitHub API

## Local dev

```bash
cd apps/landing
bun install
bun run dev
```

## Build-time GitHub fetch

The landing page (`/`) and QA dashboard (`/qa`) fetch from `api.github.com` at
build time. To avoid the 60 req/hr unauthenticated rate limit (which produces
`README unavailable at build time` and `GitHub API error: 429`), set
`GITHUB_TOKEN` in the Vercel project's environment variables (Settings →
Environment Variables → Production + Preview). Any token with `public_repo`
read scope works.

If the token is missing or the API still fails, the build falls back to the
committed snapshots in `src/data/`:

- `src/data/readme.html` — rendered AgilePlus README
- `src/data/repo.json` — repo metadata
- `src/data/releases.json` — last 5 releases
- `src/data/qa-snapshot.json` — QA panel placeholders

Refresh snapshots with:

```bash
GITHUB_TOKEN=<your-token> bun run data:refresh
```

## Path microfrontends (planned)

Per Phenotype org-pages standing policy, this domain hosts:

- `/` — landing (this repo)
- `/docs` — VitePress docs (mounted from `docs/`)
- `/otel` — OpenTelemetry dashboards
- `/qa` — QA reports
- `/preview/<pr#>` — PR preview deployments

## Observability `/otel`

The `/otel` route embeds the externally hosted PhenoObservability UI. Set
`PHENO_OTLP_UI_URL` in Vercel for Production and Preview deployments, then redeploy.
`PHENO_OBSERVABILITY_UI_URL` is accepted as a secondary alias, but the canonical landing
variable is `PHENO_OTLP_UI_URL`.

The embedded UI must allow iframe embedding. Public app pages that send
`frame-ancestors 'none'` or `X-Frame-Options: DENY/SAMEORIGIN` will be blocked by the
browser and should not be used as the `PHENO_OTLP_UI_URL` target.

See `docs/tasks/otel-observability-backend.md` for the long-term backend task,
deployment checklist, and acceptance criteria.
