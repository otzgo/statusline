# Claude Code Status Line Test Script (Windows PowerShell)
# Tests ccstatusline configuration and displays sample output

Write-Host "=== Claude Code Status Line Test ===" -ForegroundColor Cyan

# Test 1: Check ccstatusline installation
Write-Host "`nTest 1: Checking ccstatusline installation..." -ForegroundColor Yellow
$ccstatuslineCheck = Get-Command ccstatusline -ErrorAction SilentlyContinue
if ($ccstatuslineCheck) {
    Write-Host "✓ ccstatusline is installed" -ForegroundColor Green
} else {
    Write-Host "✗ ccstatusline is not installed" -ForegroundColor Red
    Write-Host "  Run: npm install -g ccstatusline" -ForegroundColor Gray
}

# Test 2: Test ccstatusline execution
Write-Host "`nTest 2: Testing ccstatusline execution..." -ForegroundColor Yellow
$testInput = '{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 75}}'
try {
    $output = $testInput | ccstatusline 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ ccstatusline executes successfully" -ForegroundColor Green
        Write-Host "  Output: $output" -ForegroundColor Gray
    } else {
        Write-Host "✗ ccstatusline execution failed" -ForegroundColor Red
        Write-Host "  Error: $output" -ForegroundColor Gray
    }
} catch {
    Write-Host "✗ ccstatusline execution error: $_" -ForegroundColor Red
}

# Test 3: Check Claude Code configuration
Write-Host "`nTest 3: Checking Claude Code configuration..." -ForegroundColor Yellow
$claudeConfig = "$env:USERPROFILE\.claude\settings.json"
if (Test-Path $claudeConfig) {
    try {
        $config = Get-Content $claudeConfig -Raw | ConvertFrom-Json
        if ($config.statusLine -and $config.statusLine.command -eq "ccstatusline") {
            Write-Host "✓ Claude Code is configured to use ccstatusline" -ForegroundColor Green
        } else {
            Write-Host "⚠ Claude Code is not configured to use ccstatusline" -ForegroundColor Yellow
            Write-Host "  Update $claudeConfig with:" -ForegroundColor Gray
            Write-Host '  "statusLine": {"type": "command", "command": "ccstatusline"}' -ForegroundColor Gray
        }
    } catch {
        Write-Host "⚠ Could not parse Claude Code configuration" -ForegroundColor Yellow
        Write-Host "  Error: $_" -ForegroundColor Gray
    }
} else {
    Write-Host "⚠ Claude Code configuration file not found" -ForegroundColor Yellow
    Write-Host "  Create $claudeConfig with:" -ForegroundColor Gray
    Write-Host '  {"statusLine": {"type": "command", "command": "ccstatusline"}}' -ForegroundColor Gray
}

# Test 4: Check ccstatusline configuration
Write-Host "`nTest 4: Checking ccstatusline configuration..." -ForegroundColor Yellow
$ccstatuslineConfig = "$env:USERPROFILE\.config\ccstatusline\settings.json"
if (Test-Path $ccstatuslineConfig) {
    try {
        $ccConfig = Get-Content $ccstatuslineConfig -Raw | ConvertFrom-Json
        Write-Host "✓ ccstatusline configuration found" -ForegroundColor Green
        if ($ccConfig.powerline -and $ccConfig.powerline.enabled -eq $true) {
            Write-Host "  Powerline style: Enabled" -ForegroundColor Gray
        } else {
            Write-Host "  Powerline style: Disabled (default)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "⚠ Could not parse ccstatusline configuration" -ForegroundColor Yellow
    }
} else {
    Write-Host "ℹ ccstatusline using default configuration" -ForegroundColor Cyan
    Write-Host "  Default config will be created on first run" -ForegroundColor Gray
}

# Display sample outputs
Write-Host "`n=== Sample Status Line Outputs ===" -ForegroundColor Cyan

Write-Host "`n1. Basic output:" -ForegroundColor Yellow
'{"model": {"display_name": "Claude 3.5 Sonnet"}}' | ccstatusline

Write-Host "`n2. With context usage:" -ForegroundColor Yellow
'{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 65}}' | ccstatusline

Write-Host "`n3. With Git info (simulated):" -ForegroundColor Yellow
Write-Host "   (Git info comes from actual repository status)" -ForegroundColor Gray

Write-Host "`n=== Test Complete ===" -ForegroundColor Cyan
Write-Host "If all tests pass, restart Claude Code to see the status line." -ForegroundColor Yellow
Write-Host "For issues, run: .\scripts\setup-windows.ps1" -ForegroundColor Gray