$CONFIG = "install-windows.conf.yaml"

$confObj = ConvertFrom-Yaml ([string](Get-Content $CONFIG -Raw))
foreach ($target in ($confObj | Where-Object Keys -eq link).Values.Keys) {
    if ((Get-Item $target -Force -ErrorAction SilentlyContinue).LinkType -eq "SymbolicLink") {
        Write-Host "Removing $target" -ForegroundColor Red
        Remove-Item $target
    }
}