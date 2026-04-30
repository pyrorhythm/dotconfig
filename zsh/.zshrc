typeset -U path cdpath fpath manpath

if command -v brew >/dev/null 2>&1; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

autoload -Uz compinit
compinit -d "$ZDOTDIR/.zcompdump"

if [[ -d "$HOME/.oh-my-zsh" ]]; then
  export ZSH="$HOME/.oh-my-zsh"
  plugins=(git sudo docker)
  source "$ZSH/oh-my-zsh.sh"
fi

if [[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history)
fi

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY
unsetopt APPEND_HISTORY EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST
unsetopt HIST_FIND_NO_DUPS HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS

gacp () {
  git add . && git commit -m "$1" && git push
}

if command -v oh-my-posh >/dev/null 2>&1; then
  omp_theme=""
  if command -v brew >/dev/null 2>&1; then
    omp_theme="$(brew --prefix oh-my-posh 2>/dev/null)/themes/pure.omp.json"
  fi
  if [[ -r "$omp_theme" ]]; then
    eval "$(oh-my-posh init zsh --config "$omp_theme")"
  else
    eval "$(oh-my-posh init zsh)"
  fi
  unset omp_theme
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if command -v carapace >/dev/null 2>&1; then
  source <(carapace _carapace zsh)
fi

alias -- d=docker
alias -- dc='docker compose'
alias -- dcf='docker compose -f'

if [[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
fi
