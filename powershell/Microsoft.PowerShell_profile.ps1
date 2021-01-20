# Environment Variables
& $PSScriptRoot\Microsoft.PowerShell_environment.ps1
# Completions
Get-ChildItem $PSScriptRoot\Completions | % {  & $_.FullName }

# Modules
Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme slim

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi

# Fix cursor not changing between Vi modes
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewline "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewline "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $function:OnViModeChange

Import-Module PSFzf

# Keybindings
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl+o -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lfcd.ps1')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

# Clear-Host
# posh-winfetch.ps1
