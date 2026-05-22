#!/bin/bash
set -euo pipefail

DOTFILES_REPO="https://github.com/optroot/dotfiles.git"

info()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
ok()    { printf "\033[1;32m [OK]\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
err()   { printf "\033[1;31m[ERR]\033[0m %s\n" "$*"; exit 1; }

detect_os() {
  case "$(uname -s)" in
    Linux)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS="$ID"
        OS_LIKE="$ID_LIKE"
      else
        OS="linux"
        OS_LIKE=""
      fi
      ;;
    Darwin)
      OS="macos"
      OS_LIKE=""
      ;;
    *)
      err "Unsupported OS: $(uname -s)"
      ;;
  esac
  info "Detected OS: $OS"
}

install_chezmoi() {
  if command -v chezmoi &>/dev/null; then
    ok "chezmoi already installed"
    return
  fi
  info "Installing chezmoi..."
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin
  ok "chezmoi installed"
}

run_installer() {
  local script="$1"
  shift
  if [ -x "$script" ]; then
    "$script" "$@"
  elif command -v bash &>/dev/null; then
    bash "$script" "$@"
  fi
}

install_system_packages() {
  case "$OS" in
    ubuntu|debian|pop|linuxmint)
      run_installer "scripts/install-apt.sh"
      ;;
    fedora|rhel|centos|rocky|almalinux)
      run_installer "scripts/install-yum.sh"
      ;;
    macos)
      run_installer "scripts/install-brew.sh"
      ;;
    *)
      warn "No package installer for $OS, skipping system packages"
      ;;
  esac
}

install_tools() {
  run_installer "scripts/install-tools.sh"
}

setup_shell() {
  run_installer "scripts/setup-shell.sh"
}

main() {
  detect_os

  if [ ! -d ~/.local/share/chezmoi ]; then
    install_chezmoi
    info "Cloning dotfiles..."
    chezmoi init --apply "$DOTFILES_REPO"
  else
    info "Dotfiles already cloned, updating..."
    chezmoi update -v
  fi

  install_system_packages
  install_tools
  setup_shell

  info "Running Neovim headless plugin install..."
  nvim --headless "+Lazy! sync" +qa 2>/dev/null || warn "Neovim plugin install failed (run manually later)"

  ok "Bootstrap complete! Restart your shell or run: exec zsh"
}

main "$@"
