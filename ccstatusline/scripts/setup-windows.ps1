# Claude Code Status Line Setup Script (Windows PowerShell)
# Uses ccstatusline tool for rich status line display

Write-Host "=== Claude Code Status Line Setup ===" -ForegroundColor Cyan

# Check if npm is installed
$npmCheck = Get-Command npm -ErrorAction SilentlyContinue
if (-not $npmCheck) {
    Write-Host "Error: npm is not installed. Please install Node.js and npm first." -ForegroundColor Red
    Write-Host "Visit https://nodejs.org/ to download and install" -ForegroundColor Yellow
    exit 1
}

Write-Host "✓ npm is installed" -ForegroundColor Green

# Install or update ccstatusline
Write-Host "Installing/updating ccstatusline..." -ForegroundColor Cyan
npm install -g ccstatusline

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ ccstatusline installation failed" -ForegroundColor Red
    exit 1
}

Write-Host "✓ ccstatusline installed successfully" -ForegroundColor Green

# Test ccstatusline
Write-Host "Testing ccstatusline..." -ForegroundColor Cyan
$testInput = '{"model": {"display_name": "test"}}'
$testResult = $testInput | ccstatusline 2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ ccstatusline test passed" -ForegroundColor Green
} else {
    Write-Host "✗ ccstatusline test failed" -ForegroundColor Red
    exit 1
}

# Determine configuration file path
$claudeConfig = "$env:USERPROFILE\.claude\settings.json"

if (-not (Test-Path $claudeConfig)) {
    Write-Host "Creating Claude Code configuration file..." -ForegroundColor Cyan
    $configDir = Split-Path $claudeConfig -Parent
    if (-not (Test-Path $configDir)) {
        New-Item -ItemType Directory -Path $configDir -Force | Out-Null
    }

    $configContent = @'
{
  "language": "中文",
  "statusLine": {
    "type": "command",
    "command": "ccstatusline"
  }
}
'@

    $configContent | Out-File -FilePath $claudeConfig -Encoding UTF8
    Write-Host "✓ Created new configuration file" -ForegroundColor Green
} else {
    Write-Host "Updating existing configuration file..." -ForegroundColor Cyan

    try {
        # Read existing configuration
        $configJson = Get-Content $claudeConfig -Raw | ConvertFrom-Json
    } catch {
        # If JSON parsing fails, create new configuration object
        $configJson = New-Object PSObject
    }

    # Update or add statusLine configuration
    $configJson | Add-Member -MemberType NoteProperty -Name "statusLine" -Value @{
        type = "command"
        command = "ccstatusline"
    } -Force

    # Write back to file
    $configJson | ConvertTo-Json -Depth 10 | Out-File -FilePath $claudeConfig -Encoding UTF8
    Write-Host "✓ Configuration file updated" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Cyan
Write-Host "1. Completely exit and restart Claude Code" -ForegroundColor Yellow
Write-Host "2. Status line will show model info, Git status, etc." -ForegroundColor Yellow
Write-Host ""
Write-Host "Customization options:" -ForegroundColor Cyan
Write-Host "- ccstatusline config: $env:USERPROFILE\.config\ccstatusline\settings.json" -ForegroundColor Gray
Write-Host "- Enable Powerline style: Set powerline.enabled to true" -ForegroundColor Gray
Write-Host "- Choose colors suitable for your terminal theme (dark/light)" -ForegroundColor Gray
Write-Host "- More options: Refer to ccstatusline documentation" -ForegroundColor Gray

# Show current status line example
Write-Host ""
Write-Host "Status line example:" -ForegroundColor Cyan
$exampleInput = '{"model": {"display_name": "Claude 3.5 Sonnet"}, "context_window": {"remaining_percentage": 85}}'
$exampleInput | ccstatusline