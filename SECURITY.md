# Security Policy

This project is privacy-adjacent by nature. Security issues often look like “accidental data exposure” rather than classic exploits.

## Supported versions

Security fixes are applied to `main` and included in the next tagged release.

## Reporting a vulnerability

Do not open a public issue for vulnerabilities.

Preferred reporting channels (pick one and fill it in):
- GitHub private vulnerability reporting (recommended if enabled)
- Email: sparog+diogenes@gmail.com

Include:
- a clear description of the issue and impact
- steps to reproduce
- affected paths/files
- proof-of-concept (safe and minimal)
- suggested remediation (optional)

## Data-handling requirements for reports

Do not include real personal data.
- No names, addresses, ticket numbers, passport IDs, email contents, or raw screenshots.
- Use synthetic or heavily redacted artifacts only.

If the issue involves a real packet, provide a minimal synthetic reproduction.

## What qualifies as a security issue here

- Any default behavior that exfiltrates or uploads user data
- Unsafe logging of sensitive inputs
- Path traversal / arbitrary file read/write in scripts
- Injection risks in template rendering or build steps
- Packaging errors that misrepresent artifacts (e.g., manifest/hash mismatch)
- “Telemetry by default” or unclear analytics in tooling

## Coordinated disclosure

- Receipt will be acknowledged within a reasonable time.
- A remediation plan and timeline will be communicated.
- Reporter credit can be provided if requested and appropriate.

## Non-security issues

Disputes about legal interpretation are handled as documentation issues unless they create a concrete safety risk (e.g., systematically unsafe instructions).

