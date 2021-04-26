#!/bin/zsh -f

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
    zgenom load zdharma/fast-syntax-highlighting
    zgenom load zsh-users/zsh-history-substring-search
    zgenom load MichaelAquilina/zsh-you-should-use
    (( $+commands[lf] )) && zgenom load gokcehan/lf etc/lfcd.sh
    zgenom load softmoth/zsh-vim-mode

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

# Load theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Visual Vim Cursor
export MODE_CURSOR_VIINS="blinking bar"
export MODE_CURSOR_REPLACE="underline"
export MODE_CURSOR_VICMD="block"
export MODE_CURSOR_SEARCH="underline"
export MODE_CURSOR_VISUAL="block"
export MODE_CURSOR_VLINE="block"

# Key-bindings
(( $+commands[lf] )) && bindkey -s '^o' 'lfcd\n'

# neofetch
