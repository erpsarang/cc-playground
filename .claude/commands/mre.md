# /mre
Follow Evidence-first debugging (MRE).

Ask for (in order):
1) Expected vs actual
2) Exact error text (verbatim)
3) Environment (Windows? versions?)
4) Minimal reproduction steps
5) Relevant files (only what’s needed)

Then output (<= 14 lines):
- MRE plan (3 bullets)
- Hypotheses (max 3)
- For each hypothesis: 1 PowerShell check command
- Next fix step (1 bullet)

