# hooks/block-dangerous.ps1
# Purpose: Block obviously dangerous shell commands before they run.

$inputJson = [Console]::In.ReadToEnd() | ConvertFrom-Json

# Claude Code hook payloads include the tool name and the tool input.
# We'll be defensive and search likely fields.
$tool = ($inputJson.tool_name, $inputJson.tool, $inputJson.name | Where-Object { $_ })[0]
$cmd  = ($inputJson.input.command, $inputJson.command, $inputJson.input, $inputJson | Out-String)

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

