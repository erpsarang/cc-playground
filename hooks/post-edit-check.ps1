# hooks/post-edit-check.ps1
# Run fast checks after file edits (Edit/Write)
# Output: JSON with additionalContext (fed back to Claude)

$ErrorActionPreference = "SilentlyContinue"
$messages = @()

# 1) Show changed files
if (Get-Command git -ErrorAction SilentlyContinue) {
  $changed = git diff --name-only
  if ($changed) {
    $messages += "Changed files: $($changed -join ', ')"
  }
  # whitespace check
  $checks = git diff --check 2>&1
  if ($checks) {
    $messages += "Whitespace issues: $($checks -join '; ')"
  }
}

# 2) npm test if available
if ((Test-Path ".\package.json") -and (Get-Command npm -ErrorAction SilentlyContinue)) {
  try {
    $pkg = Get-Content ".\package.json" -Raw | ConvertFrom-Json
    if ($pkg.scripts -and $pkg.scripts.test) {
      $messages += "npm test triggered"
      npm -s test
    }
  } catch {}
}

# Output JSON for Claude Code to consume
if ($messages.Count -gt 0) {
  $context = $messages -join "`n"
} else {
  $context = "No issues found"
}

$json = @{
  hookSpecificOutput = @{
    hookEventName = "PostToolUse"
    additionalContext = $context
  }
} | ConvertTo-Json -Depth 3

Write-Output $json
exit 0
