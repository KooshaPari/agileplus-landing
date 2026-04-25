# agileplus-landing

Landing page at `agileplus.kooshapari.com` for [KooshaPari/AgilePlus](https://github.com/KooshaPari/AgilePlus).

Pulls README at build time from GitHub. Tier 2 of the org-pages tree (Tier 1 is `projects.kooshapari.com`).

## Stack

- Astro 5 + Tailwind 4
- Deployed on Vercel (custom domain via Cloudflare CNAME)
- Build-time fetch of repo metadata + README HTML from GitHub API

## Local dev

```bash
bun install
bun run dev
```

## Path microfrontends (planned)

Per Phenotype org-pages standing policy, this domain hosts:

- `/` — landing (this repo)
- `/docs` — VitePress docs (mounted from AgilePlus/docs)
- `/otel` — OpenTelemetry dashboards
- `/qa` — QA reports
- `/preview/<pr#>` — PR preview deployments
