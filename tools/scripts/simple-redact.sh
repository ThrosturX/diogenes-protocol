#!/bin/bash
# Diogenes Protocol – simple-redact.sh (Redact Guardian)
# Minimalist offline PII redaction helper – zero dependencies
# Always creates a timestamped REDACTED copy. Never modifies originals.
# Aligns with doctrine: verifiable, auditable, local-first, share-safe.

set -euo pipefail

VERSION="0.1.0"
TIMESTAMP=$(date -u +"%Y%m%dT%H%M%SZ")
REDACTED_DIR="REDACTED_${TIMESTAMP}"
AUDIT_LOG="${REDACTED_DIR}/redaction-audit.log"
DRY_RUN=0
TARGET="${1:-.}"

usage() {
    cat <<EOF
Diogenes Redact Guardian v${VERSION}

Usage: $(basename "$0") [--dry-run] [TARGET]

TARGET: single .md/.txt file or packet directory (default: current dir)
--dry-run: show what would be redacted, no files written

Patterns redacted (case-insensitive):
  • Email addresses
  • Phone numbers (international + local)
  • IPv4 addresses
  • Account/UUID-like strings (8+ alphanum with dashes)
EOF
    exit 0
}

[[ "$1" == "--dry-run" ]] && { DRY_RUN=1; shift; }
[[ "$1" == "-h" || "$1" == "--help" ]] && usage
[[ ! -e "$TARGET" ]] && { echo "❌ Target not found: $TARGET"; exit 1; }

mkdir -p "$REDACTED_DIR"
echo "🛡️  Diogenes Redact Guardian v${VERSION} – ${TIMESTAMP} UTC" > "$AUDIT_LOG"
echo "Mode: $([[ $DRY_RUN -eq 1 ]] && echo DRY-RUN || echo LIVE)" >> "$AUDIT_LOG"
echo "Target: $TARGET" >> "$AUDIT_LOG"
echo "────────────────────────────────────" >> "$AUDIT_LOG"

# Simple but effective regex patterns
declare -a PATTERNS=(
    's/[[:alnum:]._%+-]\+@[[:alnum:].-]\+\.[[:alpha:]]\{2,\}/[REDACTED_EMAIL]/gI'
    's/\+?[0-9][0-9[:space:]\-\(\)]\{8,\}/[REDACTED_PHONE]/gI'
    's/\b([0-9]{1,3}\.){3}[0-9]{1,3}\b/[REDACTED_IP]/g'
    's/\b[A-Z0-9-]{8,}\b/[REDACTED_ACCOUNT]/gI'
)

process_file() {
    local src="$1"
    local rel="${src#${TARGET}/}"
    local dest="${REDACTED_DIR}/${rel}"
    local hash_tool="sha256sum"
    command -v sha256sum >/dev/null || hash_tool="shasum -a 256"
    local orig_hash=$($hash_tool "$src" 2>/dev/null | cut -d' ' -f1 || echo "N/A")

    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"

    for pat in "${PATTERNS[@]}"; do
        sed -i "$pat" "$dest"
    done

    local new_hash=$(sha256sum "$dest" | cut -d' ' -f1)

    echo "✓ ${rel}" >> "$AUDIT_LOG"
    echo "   Before: ${orig_hash:0:16}..." >> "$AUDIT_LOG"
    echo "   After : ${new_hash:0:16}..." >> "$AUDIT_LOG"
    echo "────────────────────────────────────" >> "$AUDIT_LOG"

    [[ $DRY_RUN -eq 1 ]] && echo "   [DRY] Would redact: ${rel}" || echo "   ✓ Redacted: ${rel}"
}

echo "🔍 Scanning $([[ -d "$TARGET" ]] && echo "directory" || echo "file")..."

if [[ -f "$TARGET" ]]; then
    process_file "$TARGET"
else
    find "$TARGET" -type f \( -name "*.md" -o -name "*.txt" \) ! -path "*/.*" -print0 |
        while IFS= read -r -d '' file; do
            process_file "$file"
        done
fi

if [[ $DRY_RUN -eq 1 ]]; then
    rm -rf "$REDACTED_DIR"
    echo "✅ Dry-run complete – no files written."
else
    echo "✅ Redaction complete → ${REDACTED_DIR}/"
    echo "   Audit log: ${AUDIT_LOG}"
    echo "   Always safe: originals untouched."
fi
