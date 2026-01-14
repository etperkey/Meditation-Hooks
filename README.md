# Meditation Hooks for Claude Code

Plays a random meditation bell sound when Claude finishes working (Stop event) or needs your attention (Notification event). Also updates the terminal title with status emojis.

## Features

- Plays one of 5 meditation bell sounds randomly
- Updates terminal title with status indicators:
  - Working: rotating arrows emoji
  - Stopped: dove emoji
  - Notification: bell emoji
- Sounds play in background without stealing window focus

## Installation

### 1. Copy the sounds folder

Copy the `sounds` folder to your Claude config directory:

```powershell
Copy-Item -Recurse ".\sounds" "$env:USERPROFILE\.claude\sounds"
```

### 2. Update your settings.json

Open `%USERPROFILE%\.claude\settings.json` and merge the hooks from `settings-template.json`.

Replace `{{SOUNDS_PATH}}` with the actual path, e.g.:
```
C:\Users\YourUsername\.claude\sounds
```

Or copy the template and do a find-replace:
```powershell
$template = Get-Content ".\settings-template.json" -Raw
$template = $template -replace '\{\{SOUNDS_PATH\}\}', "$env:USERPROFILE\.claude\sounds"
$template | Set-Content "$env:USERPROFILE\.claude\settings.json"
```

## Included Sounds

- 1-temple-bell.mp3
- 2-japanese-temple-bell.mp3
- 3-lovely-meditation-bell.mp3
- 4-meditation-bell.mp3
- 5-zen-meditation-bell.mp3

## How It Works

- `play-sound-hidden.vbs` - VBScript wrapper that launches PowerShell hidden (no flash)
- `play-sound.ps1` - PowerShell script using Windows MCI API to play MP3s without stealing focus

## Requirements

- Windows with PowerShell
- Claude Code CLI
