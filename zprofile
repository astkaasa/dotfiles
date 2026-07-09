export LANG="${LANG:-en_US.UTF-8}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export PAGER="${PAGER:-less}"

if [ -r "$HOME/.zprofile.local" ]; then
  . "$HOME/.zprofile.local"
fi
