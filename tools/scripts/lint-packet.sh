#!/bin/bash
# Diogenes Protocol – lint-packet.sh
# Offline checklist enforcer – zero dependencies

set -euo pipefail

VERSION="0.1.0"
TARGET="${1:-.}"

echo "🛡️  Diogenes Packet Linter v${VERSION}"
echo "Target: $TARGET"
echo "────────────────────────────────────"

check_file() {
    local file="$1"
    echo "✓ $file"
    grep -qE '\b[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z\b' "$file" || echo "   ⚠️  Missing UTC timestamp"
    grep -qE 'Packet ID:' "$file" || echo "   ⚠️  Missing Packet ID reference"
    grep -qE 'SHA256|sha256' "$file" || echo "   ⚠️  No hash in inventory"
}

if [[ -f "$TARGET" ]]; then
    check_file "$TARGET"
else
    find "$TARGET" -type f \( -name "*.md" -o -name "*.txt" \) ! -path "*/.*" -print0 |
        while IFS= read -r -d '' f; do
            check_file "$f"
        done
fi

echo "────────────────────────────────────"
echo "✅ Lint complete. Address any ⚠️  before sending."
