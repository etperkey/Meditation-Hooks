# Meditation Hooks Installer for Claude Code
# Installs sounds and configures hooks for tab emojis + notification sounds

$claudeDir = "$env:USERPROFILE\.claude"
$soundsDir = "$claudeDir\sounds"
$settingsFile = "$claudeDir\settings.json"
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Installing Meditation Hooks for Claude Code..." -ForegroundColor Cyan

# Create .claude directory if needed
if (-not (Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir | Out-Null
    Write-Host "Created $claudeDir"
}

# Copy sounds folder
Write-Host "Copying sounds to $soundsDir..."
if (Test-Path $soundsDir) {
    Remove-Item -Recurse -Force $soundsDir
}
Copy-Item -Recurse "$scriptDir\sounds" $soundsDir
Write-Host "  Copied $(Get-ChildItem $soundsDir -Filter *.mp3 | Measure-Object | Select-Object -ExpandProperty Count) sound files"

# Generate settings.json with correct path
Write-Host "Configuring hooks..."
$template = Get-Content "$scriptDir\settings-template.json" -Raw
$settings = $template -replace '\{\{SOUNDS_PATH\}\}', $soundsDir

# Backup existing settings if present
if (Test-Path $settingsFile) {
    $backup = "$settingsFile.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Copy-Item $settingsFile $backup
    Write-Host "  Backed up existing settings to $backup"
}

$settings | Set-Content $settingsFile -Encoding UTF8
Write-Host "  Wrote hooks to $settingsFile"

Write-Host ""
Write-Host "Installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Tab emoji indicators:" -ForegroundColor Yellow
Write-Host "  Working:     Rotating arrows"
Write-Host "  Stopped:     Dove"
Write-Host "  Idle:        Bell"
Write-Host "  Needs input: Question mark"
Write-Host ""
Write-Host "Restart Claude Code to activate hooks."
