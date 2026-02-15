# DEBUG.md (Evidence-first Debug Protocol)

## Golden rule
- No guessing without evidence. Collect proof first.

## Required inputs for any bug
1) What I expected
2) What happened (exact error text)
3) Environment (OS, shell, versions)
4) Steps to reproduce (minimal)
5) Relevant files (only those needed)

## Workflow
A) Reproduce
B) Minimize (make an MRE)
C) Hypothesize (max 3 hypotheses)
D) Test (one test per hypothesis)
E) Fix
F) Prevent (add 1–3 lines to the right policy file)

