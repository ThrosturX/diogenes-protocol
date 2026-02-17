#!/usr/bin/env bash
set -euo pipefail

name="${1:-}"
if [ -z "$name" ]; then
  echo "usage: $0 <case-slug>" >&2
  exit 1
fi

src="case-studies/_TEMPLATE"
dst="case-studies/$name"

if [ ! -d "$src" ]; then
  echo "missing template: $src" >&2
  exit 2
fi

if [ -e "$dst" ]; then
  echo "already exists: $dst" >&2
  exit 3
fi

mkdir -p "$dst"
cp -a "$src/." "$dst/"

echo "created: $dst"
