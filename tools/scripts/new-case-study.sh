#!/usr/bin/env bash
set -euo pipefail

name="${1:-}"
if [ -z "$name" ]; then
  echo "usage: $0 <case-slug>" >&2
  exit 1
fi

base="case-studies/$name"
mkdir -p "$base/evidence" "$base/notes"

cat > "$base/CASE.md" << 'EOT'
# Case Study: <Title>

## Context
- Jurisdiction:
- Counterparty:
- Topic:

## Timeline (UTC)
- YYYY-MM-DDThh:mm:ssZ —

## Claims vs Verifiable State
- Claim:
  - Evidence:
  - Verifiable state:

## Evidence Inventory
- evidence/ —

## Mechanism Invoked
- Policy/contract:
- Statute/regulation:
- Regulator:

## Outcome
- Result:
- Dates:

## Lessons
- What worked:
- What failed:
- What to do next time:
EOT

cat > "$base/EVIDENCE-INVENTORY.md" << 'EOT'
# Evidence Inventory

| Item | Type | Source | Timestamp (UTC) | Hash | Notes |
|---|---|---|---|---|---|
|  |  |  |  |  |  |
EOT

echo "created: $base"
