#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_dir="$HOME/.dotfiles.backup/$(date +%Y%m%d%H%M%S)"

link_file() {
  src=$1
  dst=$2

  if [ ! -e "$src" ]; then
    printf 'missing source: %s\n' "$src" >&2
    exit 1
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    printf 'ok: %s -> %s\n' "$dst" "$src"
    return
  fi

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$backup_dir"
    mv "$dst" "$backup_dir/"
    printf 'backup: %s -> %s/\n' "$dst" "$backup_dir"
  fi

  ln -s "$src" "$dst"
  printf 'link: %s -> %s\n' "$dst" "$src"
}

ensure_source() {
  entry_file=$1
  managed_rel=$2
  source_line=". \"\$HOME/$managed_rel\""

  if [ -L "$entry_file" ]; then
    mkdir -p "$backup_dir"
    mv "$entry_file" "$backup_dir/"
    printf 'backup: %s -> %s/\n' "$entry_file" "$backup_dir"
  fi

  if [ ! -e "$entry_file" ]; then
    printf '%s\n' "$source_line" >"$entry_file"
    printf 'create: %s\n' "$entry_file"
    return
  fi

  if grep -F "\$HOME/$managed_rel" "$entry_file" >/dev/null 2>&1; then
    printf 'ok: %s sources %s\n' "$entry_file" "$HOME/$managed_rel"
    return
  fi

  mkdir -p "$backup_dir"
  cp -p "$entry_file" "$backup_dir/"
  printf 'backup: %s -> %s/\n' "$entry_file" "$backup_dir"

  entry_tmp="$entry_file.dotfiles.$$"
  {
    printf '%s\n\n' "$source_line"
    cat "$entry_file"
  } >"$entry_tmp"
  cat "$entry_tmp" >"$entry_file"
  rm -f "$entry_tmp"
  printf 'update: %s now sources %s\n' "$entry_file" "$HOME/$managed_rel"
}

mkdir -p "$HOME/.config/zsh"
link_file "$repo_dir/zprofile" "$HOME/.config/zsh/zprofile"
link_file "$repo_dir/zshrc" "$HOME/.config/zsh/zshrc"
ensure_source "$HOME/.zprofile" ".config/zsh/zprofile"
ensure_source "$HOME/.zshrc" ".config/zsh/zshrc"

link_file "$repo_dir/vimrc" "$HOME/.vimrc"
link_file "$repo_dir/gitconfig" "$HOME/.gitconfig"
link_file "$repo_dir/gitignore" "$HOME/.gitignore"
link_file "$repo_dir/inputrc" "$HOME/.inputrc"
link_file "$repo_dir/editrc" "$HOME/.editrc"
link_file "$repo_dir/hushlogin" "$HOME/.hushlogin"

mkdir -p "$HOME/.config/alacritty"
mkdir -p "$HOME/.config/herdr"
link_file "$repo_dir/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"
link_file "$repo_dir/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"
