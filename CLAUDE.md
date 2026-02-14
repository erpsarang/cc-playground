# CLAUDE.md (Project Constitution)

## Goal
- This repo is a small sandbox to practice Claude Code workflows on Windows.
- Optimize for: correctness > clarity > speed.

## Operating Environment (Windows)
- If you propose shell commands, prefer PowerShell first.
- If you propose bash commands, also provide a PowerShell equivalent.
- Never assume tools are installed; check with version commands BEFORE using them.
  - Example: `pwsh --version`, `git --version`, `node --version`
- **PowerShell Version**:
  - Prefer PowerShell 7 (`pwsh`) over PowerShell 5.x (`powershell.exe`) for better UTF-8 support.
  - Always check which version is available first: `pwsh --version`
  - If PowerShell 7 is not available, explicitly handle encoding for PowerShell 5.x.

## Working Rules
1) **Check environment first**: Verify tool versions and capabilities before starting work.
2) **Plan first** for any task bigger than a single command or single-file edit.
3) When uncertain, **verify by reading files / running commands**.
4) Make **small, reversible changes** (small commits).
5) If you hit confusion or errors:
   - **Stop and analyze the root cause** (don't "patch spiral")
   - Re-plan with a different approach if needed
   - Document the solution if it reveals an environmental issue

## Output Style
- Use short sections and concrete steps.
- When you write code: include how to run it on Windows.

## Encoding & Language Support (Windows)
- **Always use UTF-8** for files containing non-ASCII characters (Korean, emoji, etc.)
- **PowerShell 7** (`pwsh`): Uses UTF-8 by default - preferred for Korean text
- **PowerShell 5.x** (`powershell.exe`): Uses code page 949 (EUC-KR) - requires UTF-8 BOM for Korean
- **File Creation**:
  - When creating scripts with Korean text, prefer PowerShell 7
  - If using PowerShell 5.x, save files with UTF-8 BOM encoding
  - Test the script immediately after creation to catch encoding issues early
- **Git Configuration** (already set):
  - `core.quotepath = false` (show Korean filenames correctly)
  - `i18n.commitencoding = utf-8` (UTF-8 commit messages)
- **Best Practice**: If encoding errors occur repeatedly, check tool version and switch to better alternative (e.g., pwsh instead of powershell.exe)

## Safety / Guardrails
- Do not fabricate results or data. If real data isn't available, say so.
- Do not run destructive commands (rm -rf, format, registry edits) unless explicitly asked and explained.

## Continuous Improvement
- **After completing a coding task**, reflect on the work and identify lessons learned.
- **Update this CLAUDE.md** if you discover:
  - Better practices or patterns that should be standard
  - Common pitfalls that can be avoided
  - Environmental issues or tool-specific behaviors
  - Workflow improvements that increase quality or efficiency
- **What to capture**:
  - Concrete, actionable rules (not vague principles)
  - Context-specific guidelines (Windows, encoding, tool versions, etc.)
  - Solutions to problems that might recur
- **What NOT to capture**:
  - One-off issues unlikely to repeat
  - Project-specific business logic
  - Temporary workarounds
- **Format**: Keep rules concise, organized by section, with examples when helpful.
- **Commit**: Update CLAUDE.md as a separate commit with clear explanation of the improvement.

