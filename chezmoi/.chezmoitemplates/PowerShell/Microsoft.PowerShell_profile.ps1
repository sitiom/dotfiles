. $PSScriptRoot\Microsoft.PowerShell_environment.ps1

Get-ChildItem $PSScriptRoot\Imports
    | ForEach-Object { . $_ }
Get-ChildItem $PSScriptRoot\Completions
    | ForEach-Object { . $_ }
Get-ChildItem $PSScriptRoot\Keybindings
    | ForEach-Object { . $_ }
