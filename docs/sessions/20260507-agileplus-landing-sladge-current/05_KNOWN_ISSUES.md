# Known Issues

## Canonical Checkout Dirty

Canonical `agileplus-landing` has an unrelated `.github/workflows/ci.yml`
modification. This Sladge refresh stays isolated until that local work is
resolved or a future integration can preserve it safely.

## Validation Blockers

`bun run test` and `bun run build` stop before source execution because
`node_modules` is absent in the isolated worktree: `vitest: command not found`
and `astro: command not found`.

After canonical fast-forward, `node_modules` is present and `bun run test`
passes. `bun run build` reaches Astro static route generation but is blocked by
sandbox DNS resolving `api.github.com`.
