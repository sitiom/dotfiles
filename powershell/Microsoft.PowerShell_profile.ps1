# Environment Variables
$Env:EDITOR = "nvim"
$Env:LF_ICONS = @(
    'tw=:'
    'st=:'
    'ow=:'
    'dt=:'
    'di=:'
    'fi=:'
    'ln=:'
    'or=:'
    'ex=:'
    '*.c=:'
    '*.cc=:'
    '*.clj=:'
    '*.coffee=:'
    '*.cpp=:'
    '*.css=:'
    '*.d=:'
    '*.dart=:'
    '*.erl=:'
    '*.exs=:'
    '*.fs=:'
    '*.go=:'
    '*.h=:'
    '*.hh=:'
    '*.hpp=:'
    '*.hs=:'
    '*.html=:'
    '*.java=:'
    '*.jl=:'
    '*.js=:'
    '*.json=:'
    '*.lua=:'
    '*.md=:'
    '*.php=:'
    '*.pl=:'
    '*.pro=:'
    '*.py=:'
    '*.rb=:'
    '*.rs=:'
    '*.scala=:'
    '*.ts=:'
    '*.vim=:'
    '*.cmd=:'
    '*.ps1=:'
    '*.sh=:'
    '*.bash=:'
    '*.zsh=:'
    '*.fish=:'
    '*.tar=:'
    '*.tgz=:'
    '*.arc=:'
    '*.arj=:'
    '*.taz=:'
    '*.lha=:'
    '*.lz4=:'
    '*.lzh=:'
    '*.lzma=:'
    '*.tlz=:'
    '*.txz=:'
    '*.tzo=:'
    '*.t7z=:'
    '*.zip=:'
    '*.z=:'
    '*.dz=:'
    '*.gz=:'
    '*.lrz=:'
    '*.lz=:'
    '*.lzo=:'
    '*.xz=:'
    '*.zst=:'
    '*.tzst=:'
    '*.bz2=:'
    '*.bz=:'
    '*.tbz=:'
    '*.tbz2=:'
    '*.tz=:'
    '*.deb=:'
    '*.rpm=:'
    '*.jar=:'
    '*.war=:'
    '*.ear=:'
    '*.sar=:'
    '*.rar=:'
    '*.alz=:'
    '*.ace=:'
    '*.zoo=:'
    '*.cpio=:'
    '*.7z=:'
    '*.rz=:'
    '*.cab=:'
    '*.wim=:'
    '*.swm=:'
    '*.dwm=:'
    '*.esd=:'
    '*.jpg=:'
    '*.jpeg=:'
    '*.mjpg=:'
    '*.mjpeg=:'
    '*.gif=:'
    '*.bmp=:'
    '*.pbm=:'
    '*.pgm=:'
    '*.ppm=:'
    '*.tga=:'
    '*.xbm=:'
    '*.xpm=:'
    '*.tif=:'
    '*.tiff=:'
    '*.png=:'
    '*.svg=:'
    '*.svgz=:'
    '*.mng=:'
    '*.pcx=:'
    '*.mov=:'
    '*.mpg=:'
    '*.mpeg=:'
    '*.m2v=:'
    '*.mkv=:'
    '*.webm=:'
    '*.ogm=:'
    '*.mp4=:'
    '*.m4v=:'
    '*.mp4v=:'
    '*.vob=:'
    '*.qt=:'
    '*.nuv=:'
    '*.wmv=:'
    '*.asf=:'
    '*.rm=:'
    '*.rmvb=:'
    '*.flc=:'
    '*.avi=:'
    '*.fli=:'
    '*.flv=:'
    '*.gl=:'
    '*.dl=:'
    '*.xcf=:'
    '*.xwd=:'
    '*.yuv=:'
    '*.cgm=:'
    '*.emf=:'
    '*.ogv=:'
    '*.ogx=:'
    '*.aac=:'
    '*.au=:'
    '*.flac=:'
    '*.m4a=:'
    '*.mid=:'
    '*.midi=:'
    '*.mka=:'
    '*.mp3=:'
    '*.mpc=:'
    '*.ogg=:'
    '*.ra=:'
    '*.wav=:'
    '*.oga=:'
    '*.opus=:'
    '*.spx=:'
    '*.xspf=:'
    '*.pdf=:'
    '*.nix=:'
) | Join-String

# Modules
Import-Module posh-git
Import-Module oh-my-posh

Set-PoshPrompt -Theme agnoster

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

# Completions
gh completion -s powershell | Join-String {
    $_ -replace " ''\)$"," ' ')" -replace "(^\s+\)\s-join\s';')",'$1 -replace ";$wordToComplete$"' -replace "(\[CompletionResult\]::new\('[\w-]+)'",'$1 '''
} -Separator "`n" | Invoke-Expression

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path ($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Clear-Host
# posh-winfetch.ps1
