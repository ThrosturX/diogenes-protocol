# Roadmap

This roadmap is written to be skimmable by reviewers and contributors: clear milestones, bounded scope, objective acceptance criteria.

## North Star (v1)

A user can generate a shareable, redacted **evidence packet** that is:
- procedurally coherent (facts + UTC timeline + inventory)
- verifiable (artifact hashing / manifest)
- exportable (zip bundle; optional PDF later)
- local-first by default

---

## Milestone 0 — Repo readiness

Deliverables
- README / roadmap clarity (this file)
- Contribution and security policy clarity
- At least one redacted example packet under `case-studies/example-toy/`

Acceptance criteria
- A new user understands what to do within 60 seconds
- A reviewer can locate: templates, packet structure, and build tooling quickly

---

## Milestone 1 — Packet structure hardening

Goal: make the packet structure consistent and enforceable.

Deliverables
- A stable packet “minimum required files” definition
- A canonical inventory format for `EVIDENCE-INVENTORY.md`
- Scripted helpers:
  - hash inventory generation (or verification)
  - “pack” script produces a share bundle deterministically

Relevant tooling (already present)
- `tools/scripts/hash-inventory.sh`
- `tools/scripts/pack.sh`
- `tools/scripts/release-gate.sh`

Acceptance criteria
- Two runs over the same packet yield identical inventory output (except explicitly allowed timestamps)
- Packed output includes an inventory and hashes for included artifacts

---

## Milestone 2 — Template engine discipline (content level)

Goal: templates become consistently safe and contributor-friendly.

Deliverables
- Template conventions documented (variables, optional blocks, tone constraints)
- A lint/check step (even minimal) that catches:
  - missing placeholders
  - “dangerous defaults” (e.g., accusations, overclaims, excessive demands)
- Core template set maintained:
  - DSAR access request
  - DSAR follow-up / identity check handling
  - retention hold / preservation notice
  - account deletion request
  - rectification request
  - airline escalation cover note (procedural, non-defamatory)
- [ ] Escalation Ladder template (general procedural chain for any bureaucracy)

Acceptance criteria
- Templates have consistent headers, placeholders, and disclaimers where needed
- Contributors can add a template without guessing tone or structure

---

## Milestone 3 — Site build reliability

Goal: the published site remains faithful to the Markdown sources.

Deliverables
- Documented build command(s) and expected outputs
- Build produces `docs/` deterministically from `src/pages/` + `templates/` + `case-studies/`
- Postprocessing step documented (if required)

Relevant tooling
- `tools/build_static.py`
- `tools/p2_postprocess.py`
- `run_me.sh`
- `update_protocol.sh`

Acceptance criteria
- Clean build from a fresh checkout produces a coherent `docs/` tree
- No manual editing required under `docs/` (generated output only)

---

## Milestone 4 — v0.5 release gate

Goal: a tagged release that is usable by non-technical users.

Deliverables
- A “Start Here” walkthrough that ends in a packed evidence bundle
- One or more example packets (redacted) demonstrating end-to-end flow
- A release checklist enforced by `tools/scripts/release-gate.sh`

Acceptance criteria
- A non-technical user can follow the docs and create a packet without improvising structure
- Release gate rejects common mistakes (missing files, un-hashed artifacts, etc.)

---

## Stretch goals

- Jurisdiction modules (deadlines and required elements) with citations
- Optional PDF export tooling (keep local-first)
- Template localization variants (while preserving restraint and safety)

---

## Credits usage note (for sponsorship applications)

If applying for API credits (e.g., Codex Open Source Fund), the highest-value usage is:
- refactoring and test generation for deterministic packet tooling
- build tooling improvements and automation
- template validation/linting for safe defaults

