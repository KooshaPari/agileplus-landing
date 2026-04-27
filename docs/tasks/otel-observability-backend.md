# OTel Backend Task

## Task

Provision the long-term PhenoObservability backend for AgilePlus `/otel` and wire
`agileplus-landing` to the public UI with `PHENO_OTLP_UI_URL`.

## Current Failure

The `/otel` page renders its degraded state because the Vercel deployment does not have
`PHENO_OTLP_UI_URL` set. The page cannot safely guess a backend URL because iframe embeds
also depend on host reachability and frame/CSP policy.

## Durable Solution

1. Deploy `PhenoObservability` as the shared Phenotype observability backend.
2. Expose a stable HTTPS UI endpoint for the trace/metric/log surface, preferably the
   Grafana UI backed by Tempo and the shared OTLP collector.
3. Configure `PHENO_OTLP_UI_URL` in Vercel for the `agileplus-landing` project.
4. Redeploy `agileplus-landing` so Astro bakes the iframe URL into `/otel`.
5. Keep `PHENO_OBSERVABILITY_UI_URL` as a secondary alias only for deploy compatibility;
   `PHENO_OTLP_UI_URL` remains the canonical landing env var.

## Acceptance Criteria

- `PhenoObservability` has a public HTTPS UI URL suitable for iframe embedding from the
  AgilePlus landing domain.
- Vercel environments for `agileplus-landing` set `PHENO_OTLP_UI_URL` in Production and
  Preview.
- `/otel` renders the embedded observability UI instead of `Backend not configured`.
- The embedded UI has a working open-in-new-tab link to the same backend URL.
- AgilePlus services export telemetry to the same backend through
  `OTEL_EXPORTER_OTLP_ENDPOINT` or the repo-standard equivalent.
- A production smoke check verifies that `/otel` no longer contains the degraded-state
  text after deployment.

## Operator Commands

```bash
vercel env add PHENO_OTLP_UI_URL production
vercel env add PHENO_OTLP_UI_URL preview
vercel --prod
```

Use the Vercel dashboard instead if project linking or team selection is ambiguous. This
task does not require secrets; the value is the public UI URL.

