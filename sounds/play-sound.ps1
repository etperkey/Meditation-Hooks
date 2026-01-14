param(
    [string]$soundFile = ""
)

# Use script's directory to find sounds
$soundsDir = $PSScriptRoot

# Get all sound files and pick randomly if not specified
if (-not $soundFile) {
    $sounds = @(
        # Temple/Meditation bells
        "1-temple-bell.mp3",
        "2-japanese-temple-bell.mp3",
        "3-lovely-meditation-bell.mp3",
        "4-meditation-bell.mp3",
        "5-zen-meditation-bell.mp3",
        # World instruments
        "duduk-armenia.mp3",
        "duduk-eastern-morning.mp3",
        "oud-kanun-nai.mp3",
        "kanun-nai.mp3",
        "rain-stick.mp3",
        "bansuri-meditation.mp3"
    )
    $soundFile = $sounds | Get-Random
}

$soundPath = Join-Path $soundsDir $soundFile

# Use mciSendString without type specification - plays without stealing focus
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class AudioPlayer {
    [DllImport("winmm.dll")]
    public static extern int mciSendString(string command, StringBuilder buffer, int bufferSize, IntPtr hwnd);
}
"@

# Generate unique alias to avoid conflicts
$alias = "sound" + (Get-Random -Maximum 99999)

[AudioPlayer]::mciSendString("open `"$soundPath`" alias $alias", $null, 0, [IntPtr]::Zero)
[AudioPlayer]::mciSendString("play $alias wait", $null, 0, [IntPtr]::Zero)
[AudioPlayer]::mciSendString("close $alias", $null, 0, [IntPtr]::Zero)
