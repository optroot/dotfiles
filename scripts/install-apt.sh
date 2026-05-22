#!/bin/bash
set -euo pipefail

info()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }

info "Updating package lists..."
sudo apt-get update -qq

info "Installing system packages..."
sudo apt-get install -y -qq \
  zsh \
  tmux \
  build-essential \
  curl \
  wget \
  git \
  unzip \
  ca-certificates \
  software-properties-common \
  gnupg \
  lsb-release \
  tree \
  htop \
  ripgrep \
  fzf \
  jq \
  pkg-config \
  task \
  vivid \
  libssl-dev \
  libreadline-dev \
  libsqlite3-dev \
  libbz2-dev \
  libncurses-dev \
  xclip \
  xsel

info "Adding Neovim PPA..."
sudo add-apt-repository -y ppa:neovim-ppa/unstable 2>/dev/null || true
sudo apt-get install -y -qq neovim

if [ ! -d ~/.local/share/zinit/zinit.git ]; then
  info "Installing zinit..."
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)" 2>/dev/null || true
fi

info "Installing bat..."
wget -q "https://github.com/sharkdp/bat/releases/latest/download/bat-musl_amd64.deb" -O /tmp/bat.deb
sudo dpkg -i /tmp/bat.deb 2>/dev/null || sudo apt-get install -fy -qq
rm -f /tmp/bat.deb

info "Installing eza..."
wget -q "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz" -O /tmp/eza.tar.gz
sudo tar -xzf /tmp/eza.tar.gz -C /usr/local/bin eza
rm -f /tmp/eza.tar.gz

info "Installing fd..."
wget -q "https://github.com/sharkdp/fd/releases/latest/download/fd-musl_amd64.deb" -O /tmp/fd.deb
sudo dpkg -i /tmp/fd.deb 2>/dev/null || sudo apt-get install -fy -qq
rm -f /tmp/fd.deb

info "Installing delta..."
wget -q "https://github.com/dandavison/delta/releases/latest/download/git-delta-musl_amd64.deb" -O /tmp/delta.deb
sudo dpkg -i /tmp/delta.deb 2>/dev/null || sudo apt-get install -fy -qq
rm -f /tmp/delta.deb

info "Installing zoxide..."
wget -q "https://github.com/ajeetdsouza/zoxide/releases/latest/download/zoxide_x86_64-unknown-linux-musl.tar.gz" -O /tmp/zoxide.tar.gz
sudo tar -xzf /tmp/zoxide.tar.gz -C /usr/local/bin zoxide
rm -f /tmp/zoxide.tar.gz

info "Installing glow..."
wget -q "https://github.com/charmbracelet/glow/releases/latest/download/glow_linux_amd64.deb" -O /tmp/glow.deb
sudo dpkg -i /tmp/glow.deb 2>/dev/null || sudo apt-get install -fy -qq
rm -f /tmp/glow.deb

info "Installing du-dust..."
wget -q "https://github.com/bootandy/dust/releases/latest/download/dust-x86_64-unknown-linux-gnu.tar.gz" -O /tmp/dust.tar.gz
sudo tar -xzf /tmp/dust.tar.gz -C /usr/local/bin dust 2>/dev/null || true
rm -f /tmp/dust.tar.gz

info "Installing taskwarrior..."
sudo apt-get install -y -qq task

info "Installing navi..."
wget -q "https://github.com/denisidoro/navi/releases/latest/download/navi-x86_64-unknown-linux-gnu.tar.gz" -O /tmp/navi.tar.gz
sudo tar -xzf /tmp/navi.tar.gz -C /usr/local/bin navi 2>/dev/null || true
rm -f /tmp/navi.tar.gz

info "Installing zellij..."
wget -q "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" -O /tmp/zellij.tar.gz
sudo tar -xzf /tmp/zellij.tar.gz -C /usr/local/bin
rm -f /tmp/zellij.tar.gz

info "Installing starship..."
curl -sS https://starship.rs/install.sh | sh -s -- -y 2>/dev/null || true

info "Installing terraform..."
wget -q "https://releases.hashicorp.com/terraform/1.11.4/terraform_1.11.4_linux_amd64.zip" -O /tmp/terraform.zip
sudo unzip -o /tmp/terraform.zip -d /usr/local/bin terraform 2>/dev/null || true
rm -f /tmp/terraform.zip

if ! command -v docker &>/dev/null; then
  info "Installing Docker..."
  curl -fsSL https://get.docker.com | sh 2>/dev/null || true
  sudo usermod -aG docker "$USER" 2>/dev/null || true
fi
