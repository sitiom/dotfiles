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
