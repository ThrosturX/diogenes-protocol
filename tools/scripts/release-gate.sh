#!/usr/bin/env bash
set -euo pipefail

patterns=(
  "prefer the complete text stored locally"
  "I'll provide commands"
  "I’ll provide commands"
  "as an AI"
  "placeholder"
  "TO_BE_REPLACED"
  "FIXME"
  "TBD"
)

echo "== status =="
git status --porcelain=v1 || true
echo

echo "== last commit =="
git --no-pager log -1 --stat
echo

echo "== diff (staged) =="
git --no-pager diff --cached --stat
echo

echo "== diff (working tree) =="
git --no-pager diff --stat
echo

echo "== scan (staged + working tree) =="
tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
( git diff --cached; git diff ) > "$tmp" || true

hit=0
for p in "${patterns[@]}"; do
  if grep -nF -- "$p" "$tmp" >/dev/null 2>&1; then
    echo "HIT: $p"
    grep -nF -- "$p" "$tmp" || true
    hit=1
  fi
done

if [ "$hit" -ne 0 ]; then
  echo
  echo "release-gate: FAIL"
  exit 2
fi

echo
echo "release-gate: OK"
