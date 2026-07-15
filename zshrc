# Interactive shell configuration without a shell framework.

typeset -gU path PATH
path=(
  "$HOME"/.local/bin(N)
  /opt/homebrew/{,s}bin(N)
  $path
)

autoload -Uz compinit
compinit -i

bindkey -e
setopt auto_cd
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt interactive_comments
setopt no_beep
setopt prompt_subst
setopt share_history

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search
bindkey '^R' history-incremental-search-backward

case "$OSTYPE" in
  darwin*) alias ls='ls -G' ;;
  linux*) alias ls='ls --color=auto' ;;
esac

alias ll='ls -lah'
alias la='ls -A'
alias grep='grep --color=auto'

proxy_on() {
  export http_proxy='http://127.0.0.1:7890'
  export https_proxy='http://127.0.0.1:7890'
  export all_proxy='socks5://127.0.0.1:7890'
}

proxy_off() {
  unset http_proxy https_proxy all_proxy
}

dotfiles_git_prompt() {
  local branch dirty

  command git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

  branch="$(command git symbolic-ref --quiet --short HEAD 2>/dev/null ||
    command git rev-parse --short HEAD 2>/dev/null)" || return 0
  branch="${branch//\%/%%}"

  if [[ -n "$(command git status --porcelain --ignore-submodules=dirty 2>/dev/null)" ]]; then
    dirty='*'
  fi

  printf ' %%F{green}[%%F{cyan}%s%s%%F{green}]%%f' "$branch" "$dirty"
}

PROMPT='%F{cyan}❯%f  %F{green}%c%f$(dotfiles_git_prompt) '

source_first_readable() {
  local file

  for file in "$@"; do
    [ -r "$file" ] || continue
    . "$file"
    return 0
  done

  return 1
}

# Optional: use zsh-syntax-highlighting when it is installed locally.
source_first_readable \
  /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ||
  true
