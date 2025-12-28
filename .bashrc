# --------------------------------------------------------------------
# Early return if shell is NOT interactive
# --------------------------------------------------------------------
case $- in
  *i*) ;;        # keep going (interactive)
  *) return;;    # stop loading (non-interactive shells)
esac

# --------------------------------------------------------------------
# Rust/Cargo path (needed early so eza/binaries are found)
# --------------------------------------------------------------------
# Install (once): curl -fsSL https://sh.rustup.rs | sh -s -- -y
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# --------------------------------------------------------------------
# Oh My Bash (theme + plugins)
# --------------------------------------------------------------------
# Install (once): git clone https://github.com/ohmybash/oh-my-bash.git "$HOME/.oh-my-bash"
export OSH="${OSH:-$HOME/.oh-my-bash}"
export OMB_USE_SUDO=true
# export OMB_CASE_SENSITIVE=false  # case-insensitive completion/search
OSH_THEME="ht"

# Enable Oh My Bash feature packs BEFORE sourcing:
completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source "$OSH/oh-my-bash.sh"

# --------------------------------------------------------------------
# Shell options & history (quality-of-life)
# --------------------------------------------------------------------
shopt -s histappend checkwinsize cmdhist expand_aliases
shopt -s globstar 2>/dev/null
shopt -s autocd dirspell cdspell 2>/dev/null

HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '

# Colors for common tools
if command -v dircolors >/dev/null 2>&1; then
  eval "$(dircolors -b)"
fi
alias grep='grep --color=auto'

# --------------------------------------------------------------------
# Editor defaults & "cat" upgrade (bat/batcat)
# --------------------------------------------------------------------
# Install (once): sudo apt update && sudo apt install -y neovim
if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  alias vi='nvim'
  alias vim='nvim'
else
  export EDITOR="vim"
fi

# Install (once): sudo apt install -y bat   # on Ubuntu 24.04 the binary may be "bat"
#                sudo apt install -y batcat # older Ubuntus, binary "batcat"
if command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --style=plain --paging=never'
elif command -v bat >/devnull 2>&1; then
  alias cat='bat --style=plain --paging=never'
fi

# --------------------------------------------------------------------
# eza (modern ls) with icons + safe fallback
# --------------------------------------------------------------------
# Install (choose one):
#   - Cargo:   cargo install eza --locked
#   - .deb:    VER=0.23.4; ARCH=$(dpkg --print-architecture); \
#              curl -LO "https://github.com/eza-community/eza/releases/download/v${VER}/eza_${VER}_${ARCH}.deb" && \
#              sudo dpkg -i "eza_${VER}_${ARCH}.deb" || sudo apt -f install
# IMPORTANT (Windows Terminal): set profile font to a Nerd Font (e.g. "MesloLGM Nerd Font")
if command -v eza >/dev/null 2>&1; then
  # override oh-my-bash defaults
  unalias ls ll l tree 2>/dev/null
  alias ls='eza --icons --group-directories-first'
  alias l='eza -lha --git --icons --group-directories-first'
  alias ll='eza -lh --git --icons --group-directories-first'
  alias tree='eza --tree --icons'
else
  alias ls='ls --color=auto'
  alias l='ls -lha --color=auto'
  alias ll='ls -lh --color=auto'
  alias tree='tree -C'
fi

# --------------------------------------------------------------------
# Quick system banner (fastfetch/neofetch)
# --------------------------------------------------------------------
# Install (once):
#   sudo apt install -y fastfetch    # preferred (faster)
#   # or: sudo apt install -y neofetch
fetch() { command -v fastfetch >/dev/null 2>&1 && fastfetch "$@" || (command -v neofetch >/dev/null 2>&1 && neofetch "$@"); }
# Clear screen + show banner when you type "cls"
alias cls='clear; fetch || true'
# Auto-banner on new interactive shells (non-SSH, non-tmux) — comment out if you prefer quiet
if [[ -z "$SSH_TTY" && -z "$TMUX" ]]; then fetch; fi

# --------------------------------------------------------------------
# Git power aliases
# --------------------------------------------------------------------
alias gst='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull --rebase --autostash'
alias gdf='git diff'
alias gds='git diff --staged'
alias gcl='git clone'
alias gr='git rebase -i'
alias gl='git log --oneline --decorate --graph --all'

# Pretty git logs
alias lg1="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all"
alias lg2="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'"
alias lg='lg1'

# --------------------------------------------------------------------
# Navigation helpers
# --------------------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --------------------------------------------------------------------
# Handy functions
# --------------------------------------------------------------------
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }     # create dir and cd into it
cdf()  { cd "$(dirname -- "$1")"; }            # cd to a file's directory

# Universal extractor
extract() {
  local f="$1"
  [ -f "$f" ] || { echo "file not found: $f"; return 1; }
  case "$f" in
    *.tar.bz2)   tar xjf "$f"   ;;
    *.tar.gz)    tar xzf "$f"   ;;
    *.tar.xz)    tar xJf "$f"   ;;
    *.tar.zst)   tar --zstd -xvf "$f" ;;
    *.bz2)       bunzip2 "$f"   ;;
    *.rar)       unrar x "$f"   ;;
    *.gz)        gunzip "$f"    ;;
    *.tar)       tar xf "$f"    ;;
    *.tbz2)      tar xjf "$f"   ;;
    *.tgz)       tar xzf "$f"   ;;
    *.zip)       unzip "$f"     ;;
    *.Z)         uncompress "$f";;
    *.7z)        7z x "$f"      ;;
    *)           echo "don't know how to extract '$f'"; return 2 ;;
  esac
}

# --------------------------------------------------------------------
# gpg start
# --------------------------------------------------------------------
export GPG_TTY="$(tty)"
gpgconf --launch gpg-agent
