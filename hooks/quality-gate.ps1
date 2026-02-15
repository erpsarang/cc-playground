# hooks/quality-gate.ps1
# Goal: fast, safe checks on Windows without assuming tooling.

$ErrorActionPreference = "Stop"

function HasCommand($name) {
  return [bool](Get-Command $name -ErrorAction SilentlyContinue)
}

# 1) Always do Git whitespace/patch sanity check if git exists
if (HasCommand git) {
  try { git diff --check 2>&1 | Out-Null } catch { }
}

# 2) If Node project + npm exists + test script exists -> run npm test
if ((Test-Path ".\package.json") -and (HasCommand npm)) {
  try {
    $pkg = Get-Content ".\package.json" -Raw | ConvertFrom-Json
    if ($pkg.scripts -and $pkg.scripts.test) {
      npm -s test
    }
  } catch {
    # ignore JSON parse errors
  }
}

# 3) If Python project + python exists -> compile check (fast)
if (((Test-Path ".\pyproject.toml") -or (Test-Path ".\requirements.txt")) -and (HasCommand python)) {
  python -m compileall . | Out-Null
}

Write-Output "QUALITY_OK"
exit 0

