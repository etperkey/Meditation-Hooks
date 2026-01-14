# Meditation Hooks for Claude Code

Plays random meditation/world instrument sounds when Claude finishes working or needs your attention. Also shows **status emojis in your PowerShell tab** so you know Claude's state at a glance.

## Features

### Tab Emoji Indicators
Your terminal tab shows Claude's current status:
| Status | Emoji | When |
|--------|-------|------|
| Working | 🔄 | Claude is processing/using tools |
| Stopped | 🕊️ | Claude finished responding |
| Idle | 🔔 | Waiting for your input at prompt |
| Needs Input | ❓ | Claude asked you a question mid-task |

### Notification Sounds
- Plays one of 11 meditation/world instrument sounds randomly
- Triggers on Stop, idle prompt, and mid-conversation questions
- Sounds play in background without stealing window focus

## Quick Install

Run the installer script:

```powershell
.\install.ps1
```

This will:
1. Copy sounds to `%USERPROFILE%\.claude\sounds`
2. Configure hooks in `%USERPROFILE%\.claude\settings.json`
3. Backup any existing settings

Restart Claude Code after installing.

## Manual Installation

### 1. Copy the sounds folder

```powershell
Copy-Item -Recurse ".\sounds" "$env:USERPROFILE\.claude\sounds"
```

### 2. Update your settings.json

Copy the template with your path:
```powershell
$template = Get-Content ".\settings-template.json" -Raw
$template = $template -replace '\{\{SOUNDS_PATH\}\}', "$env:USERPROFILE\.claude\sounds"
$template | Set-Content "$env:USERPROFILE\.claude\settings.json"
```

## Included Sounds

### Temple/Meditation Bells
- 1-temple-bell.mp3
- 2-japanese-temple-bell.mp3
- 3-lovely-meditation-bell.mp3
- 4-meditation-bell.mp3
- 5-zen-meditation-bell.mp3

### World Instruments
- duduk-armenia.mp3 - Armenian duduk (archive.org)
- duduk-eastern-morning.mp3 - Short duduk logo (archive.org)
- oud-kanun-nai.mp3 - Oud, kanun and nai ensemble (archive.org)
- kanun-nai.mp3 - Kanun and nai duet (archive.org)
- rain-stick.mp3 - Rain stick (bigsoundbank.com, CC0)
- bansuri-meditation.mp3 - Indian bansuri flute (archive.org)

## How It Works

- `play-sound-hidden.vbs` - VBScript wrapper that launches PowerShell hidden (no flash)
- `play-sound.ps1` - PowerShell script using Windows MCI API to play MP3s without stealing focus

## Requirements

- Windows with PowerShell
- Claude Code CLI
