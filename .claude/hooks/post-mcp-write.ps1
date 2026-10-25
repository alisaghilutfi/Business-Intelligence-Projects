$ErrorActionPreference = 'SilentlyContinue'
$raw = [Console]::In.ReadToEnd()
try { $in = $raw | ConvertFrom-Json } catch { exit 0 }
if (-not $in -or -not $in.tool_name) { exit 0 }
$op = $in.tool_input.request.operation
if (-not $op) { $op = $in.tool_input.operation }
if ($op -and $op -notmatch '^(Get|List|Connect|Describe|Export|Query|Execute|Evaluate|Validate|Refresh)') {
  $tool = $in.tool_name -replace '^mcp__plugin_powerbi-authoring_powerbi-modeling-mcp__', ''
  $msg = "DRIFT GUARD: Power BI Desktop model changed via MCP ($tool / $op). Save in Power BI Desktop (Ctrl+S) so the PBIP files reflect it, then review git diff before committing."
  @{ hookSpecificOutput = @{ hookEventName = "PostToolUse"; additionalContext = $msg } } | ConvertTo-Json -Compress -Depth 3
}
exit 0