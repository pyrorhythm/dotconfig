typeset -U path cdpath fpath manpath

path=(
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.bun/bin"
  "$HOME/.cargo/bin"
  /opt/homebrew/bin
  /opt/homebrew/sbin
  "$HOME/.mint/bin"
  $path
)

export PATH

. "$HOME/.cargo/env"
