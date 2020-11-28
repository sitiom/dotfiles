#!/bin/zsh -f

# Check if zplug is installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Support oh-my-zsh plugins and the like
zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/git", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "lib/termsupport", from:oh-my-zsh
zplug "lib/spectrum", from:oh-my-zsh
zplug 'plugins/git', from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/git-extras", from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/last-working-dir", from:oh-my-zsh

# Misc plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"
zplug "gokcehan/lf", use:'etc/lfcd.sh'

# Powerlevel10k Theme. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zplug "romkatv/powerlevel10k", as:theme, depth:1
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Python Plugins
zplug "plugins/pip", from:oh-my-zsh, if:"(( $+commands[python] ))"
zplug "plugins/python", from:oh-my-zsh, if:"(( $+commands[python] ))"
zplug "plugins/virtualenv", from:oh-my-zsh, if:"(( $+commands[python] ))"

# Vim mode
zplug "softmoth/zsh-vim-mode"
export MODE_CURSOR_VIINS="blinking bar"
export MODE_CURSOR_REPLACE="underline"
export MODE_CURSOR_VICMD="block"
export MODE_CURSOR_SEARCH="underline"
export MODE_CURSOR_VISUAL="block"
export MODE_CURSOR_VLINE="block"

# Distro specific config
dist=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release)

if [[ $dist == "arch" ]]; then
    zplug "plugins/archlinux", from:oh-my-zsh
    # pacmatic needs to be run as root: https://github.com/keenerd/pacmatic/issues/35
    alias pacmatic='sudo --preserve-env=pacman_program /usr/bin/pacmatic'
    # Downgrade permissions as AUR helpers expect to be run as a non-root user. $UID is read-only in {ba,z}sh.
    alias yay='pacman_program="sudo -u #$UID /usr/bin/yay --pacman powerpill" pacmatic'
fi

# Source local config
if [[ -e ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
       echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
ZPLUG_USE_CACHE=true ZPLUG_LOG_LOAD_SUCCESS=false zplug load

# Key-bindings
bindkey -s '^o' 'lfcd\n'
# Enable fzf key-bindings and completion after the plugins are loaded
# zplug "plugins/fzf", from:oh-my-zsh
source $HOME/.zsh/plugins/fzf/fzf.plugin.zsh

neofetch
