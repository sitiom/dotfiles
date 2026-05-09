# Fix cursor not changing between Vi modes
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewline "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewline "`e[5 q"
    }
}

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $function:OnViModeChange

# https://github.com/PowerShell/PSReadLine/issues/906
Set-PSReadLineKeyHandler -Chord 'Ctrl+Oem4' -Function ViCommandMode

