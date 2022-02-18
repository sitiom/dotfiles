# Install zgenom if not installed
if [ ! -d ~/.zgenom ]; then
    echo "\e[33mInstalling zgenom...\033[0m"
    git clone https://github.com/jandamm/zgenom ~/.zgenom
fi
source ~/.zgenom/zgenom.zsh

if ! zgenom saved; then
    echo "\e[33mCreating a zgenom save...\033[0m"

    zgenom ohmyzsh
    zgenom ohmyzsh lib/clipboard.zsh
    zgenom ohmyzsh lib/completion.zsh
    zgenom ohmyzsh lib/directories.zsh
    zgenom ohmyzsh lib/git.zsh
    zgenom ohmyzsh lib/grep.zsh
    zgenom ohmyzsh lib/history.zsh
    zgenom ohmyzsh lib/termsupport.zsh
    zgenom ohmyzsh lib/spectrum.zsh
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/git-extras
    zgenom ohmyzsh plugins/last-working-dir

    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zdharma-continuum/fast-syntax-highlighting
    zgenom load zsh-users/zsh-history-substring-search
    zgenom load MichaelAquilina/zsh-you-should-use
    (( $+commands[lf] )) && zgenom load gokcehan/lf etc/lfcd.sh
    zgenom load jeffreytse/zsh-vi-mode

    # Powerlevel10k Theme. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    zgenom load romkatv/powerlevel10k powerlevel10k

    # Distro specific config
    dist=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release)
    if [[ $dist == "arch" || $dist == "manjaro" ]]; then
        zgenom ohmyzsh plugins/archlinux
    fi

    (( $+commands[fzf] )) && zgenom ohmyzsh plugins/fzf

    zgenom save
fi

# Until https://github.com/ohmyzsh/ohmyzsh/pull/10440 is merged
if (( $+commands[paru] )); then
  alias parin='paru -S'
  alias parins='paru -U'
  alias parinsd='paru -S --asdeps'
  alias parloc='paru -Qi'
  alias parlocs='paru -Qs'
  alias parorph='paru -Qtd'
  alias parmir='paru -Syy'
  alias pare='paru -R'
  alias parem='paru -Rns'
  alias parep='paru -Si'
  alias pareps='paru -Ss'
  alias parph='sudo sh -c "paru -Rs $(paru -Qtdq)"'
  alias parupd='paru -Sy'
  alias update='paru -Sy'
  alias parupg='paru -Syu'
  alias upgrade='paru -Syu'
  alias parls='paru -Ql'
  alias parsu='paru -Syu --noconfirm'
fi

# Load theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Key-bindings
function zvm_after_init() {
  [ -f $ZGEN_DIR/ohmyzsh/ohmyzsh/___/plugins/fzf/fzf.plugin.zsh ] && source $ZGEN_DIR/ohmyzsh/ohmyzsh/___/plugins/fzf/fzf.plugin.zsh
  bindkey -s '^o' 'lfcd\n'
}

# Init zoxide
eval "$(zoxide init zsh)"

# neofetch
