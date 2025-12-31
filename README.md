# CLI-Dot-Config

A small collection of dotfiles and configuration files for my command line workflow, focused on a clean and reproducible setup.

## Contents

- nvim/      Neovim configuration
- neofetch/  Neofetch configuration
- oh-my-bash/ Oh My Bash tweaks and theme
- vscode/    VS Code settings
- themes/    Themes and supporting assets
- font/      Fonts used in the setup

---

## Quick start

Recommendation: review files before applying them.

Clone the repository

```bash
  git clone https://github.com/RafaelVVolkmer/CLI-Dot-Config.git
  cd CLI-Dot-Config
```

Symlink common configs

```bash
  mkdir -p ~/.config
  ln -sfn "$PWD/nvim" ~/.config/nvim
  ln -sfn "$PWD/neofetch" ~/.config/neofetch
```

---

Notes: 
* paths for VS Code and Oh My Bash can vary depending on your system and installation.
* Use the folders in this repo as the source and copy or symlink only what you need.
