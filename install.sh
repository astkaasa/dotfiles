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

link_file "$repo_dir/zprofile" "$HOME/.zprofile"
link_file "$repo_dir/zshrc" "$HOME/.zshrc"
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
