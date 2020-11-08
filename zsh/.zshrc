source ~/.zplug/init.zsh

# Change with your preferred editor
export EDITOR=nvim

zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"

# Support oh-my-zsh plugins and the like
zplug "lib/clipboard", from:oh-my-zsh
zplug "lib/completion", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/git", from:oh-my-zsh
zplug "lib/grep", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize", from:oh-my-zsh
zplug "plugins/git-extras", from:oh-my-zsh, if:"which git"
zplug "plugins/last-working-dir", from:oh-my-zsh

# Powerlevel10k Theme. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
zplug "romkatv/powerlevel10k", as:theme, depth:1
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Python Plugins
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/python", from:oh-my-zsh
zplug "plugins/virtualenv", from:oh-my-zsh

# Vim
zplug "softmoth/zsh-vim-mode"
export MODE_CURSOR_VIINS="blinking bar"
export MODE_CURSOR_REPLACE="underline"
export MODE_CURSOR_VICMD="block"
export MODE_CURSOR_SEARCH="underline"
export MODE_CURSOR_VISUAL="block"
export MODE_CURSOR_VLINE="block"

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

# Enable fzf key-bindings and completion after the plugins are loaded
# zplug "plugins/fzf", from:oh-my-zsh
source $HOME/.zsh/plugins/fzf/fzf.plugin.zsh

neofetch
