# optroot/dotfiles

Managed with [chezmoi](https://www.chezmoi.io/).

## Quick Start

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply optroot
```

Or for a full bootstrap with tools:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/optroot/dotfiles/master/bootstrap.sh)
```

## What's Inside

- **Shell**: Zsh with zinit (modern plugin manager), Starship prompt
- **Editor**: Neovim (Lua config with lazy.nvim) + Vim (legacy vimrc)
- **Terminal**: Tmux + Zellij side by side
- **Tools**: bat, eza, fd, ripgrep, delta, zoxide, fzf, glow, du-dust
- **Languages**: uv (Python), fnm (Node), rustup (Rust)
- **Infra**: Docker, Terraform, AWS CLI/CDK
- **Notes**: taskwarrior, navi cheatsheets, neorg/vimwiki
- **AI**: OpenCode with MCP servers (Playwright, GitHub, Filesystem, Web Search, Fetch, Memory, Code Search, AWS)

## Structure

```
~/.local/share/chezmoi/
├── dot_zshenv              # env vars (API keys excluded)
├── dot_zshrc               # shell config
├── dot_bashrc              # minimal bash -> exec zsh
├── dot_config/
│   ├── starship.toml       # prompt
│   ├── nvim/init.lua       # Neovim
│   ├── zellij/config.kdl   # terminal multiplexer
│   ├── opencode/           # AI config
│   └── navi/cheat/         # cheatsheets
├── dot_local/bin/          # scripts (project, tmux-sessionizer)
├── dot_vimrc               # legacy Vim config
├── .chezmoiscripts/        # bootstrap scripts
└── bootstrap.sh            # entry point
```
