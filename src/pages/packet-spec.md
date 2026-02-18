---
title: Packet spec
layout: default
---

# Packet spec (MVP)

## Packet checklist

- Timeline (UTC timestamps if possible)
- Tickets / confirmations / receipts / invoices
- Screenshots + original emails (exported)
- Call notes (who/when/what)
- Copies of letters sent + proofs of sending
- Hash inventory (optional, for integrity)

A “packet” is a shareable directory layout that keeps evidence coherent, referenced, and exportable.

## Required structure

- CASE.md
- EVIDENCE-INVENTORY.md
- evidence/
  - letters/
  - screenshots/
  - receipts/
  - calls/
  - logs/
  - misc/

## Naming
- Use ISO 8601 UTC timestamps where possible:
  - YYYY-MM-DDThhmmssZ__short-label.ext
- Examples:
  - 2026-02-17T031500Z__denied-boarding-email.eml
  - 2026-02-17T034200Z__checkin-error.png
  - 2026-02-17T051200Z__taxi-receipt.pdf

## Referencing artifacts
In CASE.md, reference artifacts by stable IDs:
- E1, E2, E3 …
and map them in EVIDENCE-INVENTORY.md.

## Integrity (optional but recommended)
Maintain hashes for originals in EVIDENCE-INVENTORY.md where feasible.
