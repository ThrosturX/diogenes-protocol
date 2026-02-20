# Adversarial Robustness for Frontier Systems

**Version:** 0.1.0  
**Last updated:** [YYYY-MM-DDThh:mm:ssZ UTC]  
**Packet ID reference:** Use with any evidence packet

## Core Principle
Opaque systems (especially AI/LLM providers, surveillance-heavy platforms, and automated bureaucracies) will attempt to:
- Delay, fragment, or ignore verifiable requests
- Inject ambiguity or emotional framing
- Exploit missing timestamps, hashes, or packet references

The Diogenes response: **pre-emptive procedural hardening**.

## Mandatory Checklist (run `tools/scripts/lint-packet.sh` before every send)

1. **UTC timestamps only** — every date, every event  
2. **Packet ID referenced** in every message  
3. **Evidence inventory** with SHA256 hashes present  
4. **Redaction complete** (via `simple-redact.sh`)  
5. **Tone audit**: facts-only, no conclusions, no legal threats  
6. **Escalation step documented** (if applicable)  
7. **Attachment list** explicit and minimal  

## Recommended Pre-Send Flow
```bash
./tools/scripts/utc-now.sh          # copy timestamp
./tools/scripts/simple-redact.sh .  # produce REDACTED_ copy
./tools/scripts/lint-packet.sh .    # final checklist
```

## When Facing Common Adversarial Responses
- “We need more information” → Reply with Packet ID + exact section referenced  
- Silence → Escalate using escalation-ladder.md at documented interval  
- Partial compliance → Log discrepancy in timeline + re-request with new Packet ID  

**Never improvise.** Every interaction must remain reproducible and share-safe.

This section will be referenced from the main README and all templates once merged.
