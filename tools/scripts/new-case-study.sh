#!/usr/bin/env bash
set -euo pipefail

name="${1:-}"
if [ -z "$name" ]; then
  echo "usage: $0 <case-slug>" >&2
  exit 1
fi

base="case-studies/$name"
mkdir -p "$base/evidence/letters" \
         "$base/evidence/screenshots" \
         "$base/evidence/receipts" \
         "$base/evidence/calls" \
         "$base/evidence/logs" \
         "$base/evidence/misc" \
         "$base/notes"

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
- EVIDENCE-INVENTORY.md
- evidence/ (see packet spec)

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

| ID | File | Type | Source | Timestamp (UTC) | Hash | Notes |
|---|---|---|---|---|---|---|
| E1 |  |  |  |  |  |  |
EOT

echo "created: $base"
