# hooks/block-dangerous.ps1
# Purpose: Block obviously dangerous shell commands before they run.

try {
  $inputJson = [Console]::In.ReadToEnd() | ConvertFrom-Json
} catch {
  # stdin 파싱 실패 시 차단 (fail-closed)
  Write-Output '{"decision":"block","message":"Hook input parsing failed; blocking for safety."}'
  exit 0
}

# Extract the command string from the hook payload
$cmd = if ($inputJson.input.command) { $inputJson.input.command } elseif ($inputJson.command) { $inputJson.command } else { $inputJson | Out-String }

$dangerPatterns = @(
  'rm\s+-rf',                 # nukes
  'del\s+/s',                 # windows recursive delete
  'rmdir\s+/s',               # windows recursive delete
  'format\s+',                # format disk
  'reg\s+add|reg\s+delete',   # registry edits
  'curl\s+|wget\s+',          # network exfil / downloads
  'ssh\s+|scp\s+',            # remote access
  'git\s+push',               # publish code
  '\.env|secrets|id_rsa'      # sensitive files
)

$hit = $false
foreach ($p in $dangerPatterns) {
  if ($cmd -match $p) { $hit = $true; break }
}

if ($hit) {
  # Claude Code hooks can block actions; return structured response.
  # (Exact response schema is documented in hooks reference/guide.)
  $out = @{
    decision = "block"
    message  = "Blocked by hook: command matches a dangerous pattern. If you really need this, ask explicitly and explain why."
  } | ConvertTo-Json -Compress

  Write-Output $out
  exit 0
}

# Allow by default
$out = @{ decision = "allow" } | ConvertTo-Json -Compress
Write-Output $out
exit 0

