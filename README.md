# Diogenes Protocol

A **local-first**, **evidence-forward** protocol for DSAR/privacy requests and modern bureaucracy.

The goal is not “legal wizardry.” The goal is to turn messy support interactions into a **verifiable case file**:
- a facts-only narrative
- a UTC timeline
- an evidence inventory (with hashes where appropriate)
- restrained, procedural templates
- a share-safe redaction posture

Project site (GitHub Pages):
https://throsturx.github.io/diogenes-protocol/

> Not legal advice. See `DISCLAIMER.md`.

---

## What this repo contains

- `templates/`  
  Source templates in Markdown (DSAR, privacy requests, airline/EU261 flows).

- `src/pages/`  
  Source pages for the static site (Markdown).

- `docs/`  
  Built site output (HTML) served by GitHub Pages.

- `case-studies/`  
  Example and template case packets (Markdown).

- `tools/`  
  Build scripts and helper scripts (packet hashing, new packet scaffolding, packing, release gates).

---

## Quickstart (use the protocol)

1) Create a new case packet directory (recommended structure):

    case-studies/<case-name>/
      CASE.md
      EVIDENCE-INVENTORY.md
      EVIDENCE/

2) Populate:
- `CASE.md`: facts-only narrative (no speculation)
- `EVIDENCE-INVENTORY.md`: list artifacts, dates, and context
- `EVIDENCE/`: files (emails, screenshots, PDFs, audio, etc.)

3) Apply redaction guidance before sharing:
- read: `docs/redaction.html` (or `src/pages/redaction.md`)

---

## Quickstart (build the site locally)

This repo generates the site from `src/pages/*.md` and template Markdown into `docs/*.html`.

Common flows:

- One-shot build (if you use the repo scripts):

    ./run_me.sh

- Update/rebuild protocol content (if this is your intended entrypoint):

    ./update_protocol.sh

- Direct python build (if you prefer explicit tooling):

    python tools/build_static.py

If your environment expects dependencies, keep them documented in `run_me.sh` and/or a future `DEVELOPMENT.md`.

---

## Templates

Templates live in `templates/` (Markdown) and are mirrored into the built site under `docs/templates/` (HTML).

Guidance:
- Keep tone procedural and restrained.
- Prefer “request + confirmation + deadline awareness” over threats.
- Avoid legal conclusions unless you cite an authority and the claim is stable.

---

## Case studies

Case studies are in `case-studies/` and may be published into `docs/case-studies/`.

Scaffolding helpers exist in:

- `tools/scripts/new-case-study.sh`
- `tools/scripts/new-packet.sh`

Hash/inventory helpers exist in:

- `tools/scripts/hash-inventory.sh`
  - `tools/scripts/simple-redact.sh` – safe offline PII redaction helper (Redact Guardian)
- `tools/scripts/pack.sh`

---

## Repository hygiene (privacy)

Do not commit real personal data.
- Use synthetic data or aggressive redaction.
- Treat audio, screenshots, and PDFs as sensitive by default.

If you need to share a “real” packet with a collaborator, do it out-of-band and keep the public repo clean.

---

## Licensing (at a glance)

This repo uses multiple license scopes. The authoritative files are:

- `LICENSE` (top-level notice)
- `LICENSE-CODE` (code/tooling)
- `LICENSE-DOCS` (documentation/templates)
- `NOTICE` (attribution / notices)
- `COMMERCIAL-LICENSE.md` (separate commercial terms, if applicable)

If you’re contributing, see `CONTRIBUTING.md`.

---

## Security

If you discover a vulnerability or privacy hazard, follow `SECURITY.md`.
Do not open public issues with sensitive material.

---

## Roadmap

See `ROADMAP.md` for milestone-driven deliverables.
