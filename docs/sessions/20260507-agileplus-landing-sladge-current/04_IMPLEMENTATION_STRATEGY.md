# Implementation Strategy

## Scope

Keep the downstream change to `README.md` plus session documentation. Do not
edit the canonical checkout or reuse stale worktree evidence.

## Validation

- Run `git diff --check`.
- Verify badge presence with `rg`.
- Run repo-native tests/build where dependencies are available.

