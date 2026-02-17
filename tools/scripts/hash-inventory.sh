#!/usr/bin/env bash
set -euo pipefail

inv="${1:-EVIDENCE-INVENTORY.md}"
dir="${2:-.}"
mode="${3:-print}"

python - "$inv" "$dir" "$mode" << 'PY'
import sys, re, hashlib
from pathlib import Path

inv = Path(sys.argv[1])
root = Path(sys.argv[2])
mode = sys.argv[3]

s = inv.read_text(encoding="utf-8").splitlines()
out = []
changed = False

def sha256(p: Path) -> str:
    h = hashlib.sha256()
    with p.open("rb") as f:
        for chunk in iter(lambda: f.read(1024*1024), b""):
            h.update(chunk)
    return h.hexdigest()

row_re = re.compile(r"^\|\s*([^|]+)\|\s*([^|]+)\|\s*([^|]*)\|\s*([^|]*)\|\s*([^|]*)\|\s*([^|]*)\|\s*([^|]*)\|\s*$")

for line in s:
    m = row_re.match(line)
    if not m or m.group(1).strip() in ("ID", "---"):
        out.append(line)
        continue

    file_cell = m.group(2).strip()
    if not file_cell or file_cell == "evidence/":
        out.append(line)
        continue

    p = (root / file_cell).resolve()
    if not p.exists() or p.is_dir():
        out.append(line)
        continue

    digest = sha256(p)
    old_hash = m.group(6).strip()
    if old_hash != digest:
        line = f"| {m.group(1).strip()} | {file_cell} | {m.group(3).strip()} | {m.group(4).strip()} | {m.group(5).strip()} | {digest} | {m.group(7).strip()} |"
        changed = True
    out.append(line)

new = "\n".join(out) + "\n"

if mode == "inplace":
    if changed:
        inv.write_text(new, encoding="utf-8")
    print(str(inv))
else:
    sys.stdout.write(new)
PY
