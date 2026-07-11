# Personal dotfiles

Small, explicit dotfiles for my local development environment.

This repo keeps only the dotfiles I actively use. It avoids shell frameworks,
editor plugins, terminal themes, and other bundled tooling unless they are
clearly needed.

Design principle: keep global dotfiles for personal machine and editor defaults;
leave project-specific build artifacts and team conventions to each project's
own configuration. Target macOS first, while keeping the configuration
Linux-friendly where practical; platform-specific settings should be explicit
and harmless on other systems.

## Contents

- `zprofile` and `zshrc`: framework-free shell environment, prompt, history,
  completion, and aliases.
- `vimrc`: plain Vim configuration without plugins.
- `gitconfig` and `gitignore`: global Git defaults and ignores.
- `inputrc` and `editrc`: command-line editing defaults.
- `hushlogin`: quiet login shells.
- `config/alacritty/alacritty.toml`: Alacritty terminal preferences.
- `config/herdr/config.toml`: Herdr terminal workspace preferences.

## Requirements

The installer only creates symlinks; it does not install applications, packages,
fonts, or Herdr plugins.

- Zsh, Vim, and Git.
- Alacritty and Herdr for the managed terminal configuration.
- Cascadia Code NF, selected explicitly by the Alacritty configuration.
- `zsh-syntax-highlighting` for optional interactive command highlighting.
- The Tokscale Dashboard Herdr plugin for the `Cmd-U` binding.

On macOS, install the optional Zsh highlighter with:

```sh
brew install zsh-syntax-highlighting
```

Install the Herdr plugin with:

```sh
herdr plugin install astkaasa/herdr-tokscale-dashboard
```

## Install

Run:

```sh
./install.sh
```

The installer creates symlinks in `$HOME`. Existing files are moved to a
timestamped backup directory under `~/.dotfiles.backup/`.

Keep machine-specific Git identity and credential helpers in
`~/.gitconfig.user`, for example:

```gitconfig
[user]
  name = your-name
  email = your-email@example.com
```
