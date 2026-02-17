# Publishing rules (case studies)

Goal: publish procedures and failure modes without leaking personal data.

Required:
- Follow docs/redaction.md
- Use UTC timestamps
- Artifact IDs: E1, E2, ...
- Publish only redacted copies of evidence
- Keep originals locally

Do not publish:
- passport/ID scans, MRZ, full addresses, payment details, children’s data
- full PNR/ticket numbers (mask by default)

Recommended:
- Keep a local “master packet”
- Publish a separate “public packet” with only redacted artifacts
