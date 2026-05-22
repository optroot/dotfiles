#!/bin/bash
set -euo pipefail

info()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
ok()    { printf "\033[1;32m [OK]\033[0m %s\n" "$*"; }

if ! command -v uv &>/dev/null; then
  info "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh 2>/dev/null || true
fi

if ! command -v fnm &>/dev/null; then
  info "Installing fnm..."
  curl -fsSL https://fnm.vercel.app/install | bash 2>/dev/null || true
fi

if ! command -v rustup &>/dev/null; then
  info "Installing rustup..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 2>/dev/null || true
fi

if command -v fnm &>/dev/null; then
  info "Installing Node via fnm..."
  fnm install --lts 2>/dev/null || true
  fnm default lts-latest 2>/dev/null || true
  eval "$(fnm env --use-on-cd --shell bash)"
fi

if command -v npm &>/dev/null && [ -n "$(command -v npm)" ]; then
  info "Installing npm global tools..."
  npm install -g \
    typescript \
    prettier \
    eslint \
    markdownlint-cli \
    sqlite3 \
    bash-language-server 2>/dev/null || true
fi

if ! command -v aws &>/dev/null; then
  info "Installing AWS CLI..."
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
  unzip -q /tmp/awscliv2.zip -d /tmp
  sudo /tmp/aws/install 2>/dev/null || true
  rm -rf /tmp/aws /tmp/awscliv2.zip
fi

if command -v npm &>/dev/null; then
  info "Installing AWS CDK..."
  npm install -g aws-cdk 2>/dev/null || true
fi

info "Installing tmux plugins..."
TMUX_TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_TPM_DIR" ]; then
  git clone --depth 1 https://github.com/tmux-plugins/tpm "$TMUX_TPM_DIR" 2>/dev/null || true
fi
"$TMUX_TPM_DIR/bin/install_plugins" 2>/dev/null || true

if command -v uv &>/dev/null; then
  info "Installing Python tools via uv..."
  uv tool install ruff 2>/dev/null || true
  uv tool install pyright 2>/dev/null || true
fi

ok "Tool installation complete"
