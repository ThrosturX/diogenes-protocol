#!/usr/bin/env bash
set -euo pipefail

case_dir="${1:-}"
if [ -z "$case_dir" ]; then
  echo "usage: $0 <case-studies/<slug>> [output.tgz]" >&2
  exit 1
fi

out="${2:-}"
if [ -z "$out" ]; then
  slug="$(basename "$case_dir")"
  out="${slug}__packet.tgz"
fi

tar --exclude-vcs -czf "$out" "$case_dir"
echo "$out"
