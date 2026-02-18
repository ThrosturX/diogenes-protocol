# Contributing

Contributions are welcome if they improve procedural clarity, privacy hygiene, and verifiability.

This project has a specific posture:
- facts over feelings
- UTC timelines over relative time
- evidence inventory over narrative persuasion
- procedural restraint over theatrics

## Golden rules

1) Do not introduce defamatory or speculative language.
2) Do not require users to upload sensitive data to third-party services by default.
3) Do not commit personal data. Use synthetic or aggressively redacted examples only.
4) Prefer deterministic outputs in tooling (reproducible inventories, repeatable packs).

---

## Where to contribute

High-value areas
- `templates/` (wording clarity, restraint, completeness)
- `case-studies/` (redacted examples, structure improvements)
- `tools/` (inventory hashing, packing, scaffolding, build reliability)
- `src/pages/` (documentation improvements)

Lower-value / out-of-scope
- “autonomous legal automation”
- aggressive escalation language
- default telemetry or data upload behavior

---

## Template standards

Tone
- neutral, procedural, non-accusatory
- “request + confirmation + deadline awareness” beats “threats”
- avoid legal conclusions unless stable and cited

Structure
- clear subject line / title
- a short factual framing paragraph
- explicit request(s)
- request for confirmation of receipt/handling
- reference to statutory deadlines only when correct and stable (otherwise “within statutory time limits”)

Placeholders
- make placeholders obvious
- document required fields
- avoid embedding personal data in examples

---

## Case studies

Case studies live under `case-studies/`.
Use `_TEMPLATE/` as the base for new packets.

Suggested workflow
- Create packet directory using `tools/scripts/new-case-study.sh` or manually.
- Populate `CASE.md` and `EVIDENCE-INVENTORY.md`.
- Add artifacts under `EVIDENCE/`.
- Run hashing/inventory scripts before publishing/sharing.

Do not publish real data into the public repo.

---

## Tooling contributions

If you touch scripts under `tools/`:
- keep them POSIX-friendly where reasonable
- document inputs/outputs
- avoid dependencies that force cloud services
- prefer simple, auditable implementations

If you add a new script, add it to `tools.html` / `src/pages/tools.md` as appropriate.

---

## Site build contributions

Sources:
- `src/pages/` (Markdown)
- `templates/` (Markdown)
- `case-studies/` (Markdown)

Generated output:
- `docs/` (HTML)

Do not hand-edit `docs/` except as part of the build pipeline.

---

## Code of Conduct

See `CODE_OF_CONDUCT.md`.

---

## License of contributions

By submitting a PR, you agree your contributions can be distributed under the repo’s license scheme.
See `LICENSE`, `LICENSE-CODE`, `LICENSE-DOCS`, and `NOTICE`.

