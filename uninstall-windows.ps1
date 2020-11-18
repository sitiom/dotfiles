$CONFIG = "install-windows.conf.yaml"

$confObj = ConvertFrom-Yaml ([string](Get-Content $CONFIG -Raw))
foreach ($target in ($confObj | Where-Object Keys -eq link).Values.Keys) {
    if ((Test-Path $target) -and (Get-Item $target).Attributes -match "ReparsePoint") {
        Write-Host "Removing $target" -ForegroundColor Red
        Remove-Item $target
    }
}