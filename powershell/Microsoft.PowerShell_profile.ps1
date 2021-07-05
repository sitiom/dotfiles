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
    (zoxide init --hook $hook powershell) -join "`n"
})

# Initialize oh-my-posh from chocolatey
Invoke-Expression (oh-my-posh --init --shell pwsh --config "$(( Get-Item (Get-Command oh-my-posh).Path).Directory.Parent.FullName )\themes\slim.omp.json")

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

Import-Module PSFzf
Import-Module Terminal-Icons

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

