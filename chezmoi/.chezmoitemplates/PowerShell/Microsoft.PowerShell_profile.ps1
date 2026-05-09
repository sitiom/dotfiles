. $PSScriptRoot\Microsoft.PowerShell_environment.ps1

if ($env:CODEX_SHELL) {
    return
}

Get-ChildItem $PSScriptRoot\Imports
    | ForEach-Object { . $_ }
Get-ChildItem $PSScriptRoot\Completions
    | ForEach-Object { . $_ }
Get-ChildItem $PSScriptRoot\Keybindings
    | ForEach-Object { . $_ }
