#!/bin/bash
set -euo pipefail

CURRENT_SHELL=$(basename "$SHELL" 2>/dev/null || echo "")

if [ "$CURRENT_SHELL" != "zsh" ]; then
  if command -v zsh &>/dev/null; then
    ZSH_PATH=$(command -v zsh)
    if [ -x "$ZSH_PATH" ]; then
      if chsh -s "$ZSH_PATH" "$USER" 2>/dev/null; then
        printf "\033[1;32m [OK]\033[0m Default shell set to zsh\n"
      else
        printf "\033[1;33m[WARN]\033[0m Could not set default shell to zsh. You may need to:\n"
        printf "       sudo chsh -s %s %s\n" "$ZSH_PATH" "$USER"
      fi
    fi
  fi
else
  printf "\033[1;32m [OK]\033[0m Shell already zsh\n"
fi
