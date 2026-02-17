#!/usr/bin/env bash
set -euo pipefail

name="${1:-}"
if [ -z "$name" ]; then
  echo "usage: $0 <packet-slug>" >&2
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

cat > "$base/EVIDENCE-INVENTORY.md" << 'EOT'
# Evidence Inventory

| ID | File | Type | Source | Timestamp (UTC) | Hash | Notes |
|---|---|---|---|---|---|---|
| E1 |  |  |  |  |  |  |
EOT

cat > "$base/README.md" << 'EOT'
# Packet

This directory is an evidence packet.

- Put artifacts under evidence/
- Record them in EVIDENCE-INVENTORY.md
- Keep timestamps in UTC
- Publish only redacted copies
EOT

echo "created: $base"
