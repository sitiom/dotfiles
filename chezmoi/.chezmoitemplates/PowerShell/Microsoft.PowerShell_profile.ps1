& $PSScriptRoot\Microsoft.PowerShell_environment.ps1

Get-ChildItem $PSScriptRoot\Imports | ForEach-Object { & $_.FullName }
Get-ChildItem $PSScriptRoot\Completions | ForEach-Object { & $_.FullName }
Get-ChildItem $PSScriptRoot\Keybindings | ForEach-Object { & $_.FullName }

# Initialize zoxide in $profile. Why does it not work when sourced? I don't know.
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

