oh-my-posh --init --shell pwsh --config "$(Split-Path (Get-Command oh-my-posh).Path)\..\themes\iterm2.omp.json" | Invoke-Expression
Enable-PoshTransientPrompt
