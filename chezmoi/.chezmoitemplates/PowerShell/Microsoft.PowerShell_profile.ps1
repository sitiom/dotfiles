# Environment Variables
& $PSScriptRoot\Microsoft.PowerShell_environment.ps1
# Completions
Get-ChildItem $PSScriptRoot\Completions | % { & $_.FullName }
# Aliases
Function passgen { echo "$(password-generator -p "[a-zA-Z0-9]" -l 6)-$(password-generator -p "[a-zA-Z0-9]" -l 6)-$(password-generator -p "[a-zA-Z0-9]" -l 6)" }
Function passphrasegen { echo "$(password-generator -l 6)-$(password-generator -l 6)-$(password-generator -l 6)" }

# Initialize zoxide
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

Import-Module posh-git
Import-Module git-aliases -DisableNameChecking
oh-my-posh --init --shell pwsh --config "$(scoop prefix oh-my-posh3)\themes\iterm2.omp.json" | Invoke-Expression

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi

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
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $function:OnViModeChange
# https://github.com/PowerShell/PSReadLine/issues/906
Set-PSReadLineKeyHandler -Chord 'Ctrl+Oem4' -Function ViCommandMode

Import-Module Terminal-Icons

# Keybindings
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl+o -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lfcd.ps1')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}

Enable-PoshTransientPrompt
# Clear-Host
# winfetch.ps1

