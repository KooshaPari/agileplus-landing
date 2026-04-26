#!/usr/bin/env bash
# 5-line shell justification: refresh the committed GitHub snapshots used as
# build-time fallbacks. Pure curl + cp; a Rust binary buys nothing here.
set -euo pipefail
REPO="KooshaPari/AgilePlus"
DATA_DIR="$(cd "$(dirname "$0")/.." && pwd)/src/data"
AUTH=()
[[ -n "${GITHUB_TOKEN:-}" ]] && AUTH=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
UA=(-H "User-Agent: agileplus-landing-snapshot")

curl -fsSL "${AUTH[@]}" "${UA[@]}" -H "Accept: application/vnd.github.html+json" \
  "https://api.github.com/repos/${REPO}/readme" -o "${DATA_DIR}/readme.html"
curl -fsSL "${AUTH[@]}" "${UA[@]}" -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/${REPO}" -o "${DATA_DIR}/repo.json"
curl -fsSL "${AUTH[@]}" "${UA[@]}" -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/${REPO}/releases?per_page=5" -o "${DATA_DIR}/releases.json"

echo "[fetch-readme] refreshed snapshots in ${DATA_DIR}"
