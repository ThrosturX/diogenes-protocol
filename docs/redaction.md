---
title: Redaction policy
---

# Redaction policy (publish-safe)

This project values procedural clarity without doxxing, over-sharing, or contaminating evidence.

## Never publish
- passport/ID numbers, scans, MRZ lines
- full addresses, personal phone numbers
- payment card data, full IBAN (mask), bank statements
- PNRs/ticket numbers unless you are sure they cannot be abused (mask by default)
- full email headers that expose third-party personal data
- children’s data
- medical data

## Default masking rules
- emails: keep domain, mask local part (e.g., j***@example.com)
- reference codes: keep first/last 2 characters (e.g., AB******YZ)
- timestamps: keep UTC timestamps (these matter), but remove location precision if risky
- names: initials unless necessary

## Evidence integrity
- keep originals locally
- publish only redacted copies
- if you reference an artifact publicly, assign a stable ID (E1, E2, …) and keep it consistent

## Audio/legal note
Recording laws vary by jurisdiction. Do not publish call recordings unless you are confident it is lawful and appropriate.

## Publish checklist
- all identifiers masked
- no third-party personal data
- timeline uses UTC
- claims are supported by artifacts
- links do not leak private tokens or session identifiers
