# /review
Review recent changes safely and briefly.

Rules:
- Do NOT paste full diffs or long logs.
- Output <= 12 lines.
- Include:
  1) Key issues (max 5 bullets)
  2) Suggested next step (1 bullet)
  3) Risk level: low/med/high
- If available, prefer using git diff --name-only and git diff --check.
- Windows-first: PowerShell commands when suggesting commands.

