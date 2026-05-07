# Testing Strategy

## Checks

- Diff hygiene: `git diff --check`.
- Badge proof: `rg -n "AI Slop Inside|sladge" README.md docs/sessions/20260507-agileplus-landing-sladge-current`.
- Repo-native tests/build: `bun run test` and `bun run build` when local
  dependencies are present.

## Scope

This is a docs-only governance change, so source-level tests are used as
regression proof only where the local environment can run them without network
or dependency bootstrap.
