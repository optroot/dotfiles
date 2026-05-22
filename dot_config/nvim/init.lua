vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = "tab:» ,trail:·,nbsp:␣"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.shortmess:append("c")
vim.opt.showcmd = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undodir = vim.fn.expand("~/.vim/undo")
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wildmenu = true
vim.opt.wildmode = "list:full"
vim.opt.wrap = false

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  rocks = { enabled = false },
  { "folke/tokyonight.nvim", priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "rebelot/kanagawa.nvim", priority = 1000 },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "python", "rust", "go",
          "javascript", "typescript", "html", "css", "json",
          "yaml", "toml", "markdown", "markdown_inline", "bash",
          "dockerfile", "sql", "gitignore", "regex",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", config = true },

  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  { "lewis6991/gitsigns.nvim", config = true },
  { "tpope/vim-fugitive" },

  { "folke/which-key.nvim", config = true },
  { "folke/noice.nvim", config = true },
  { "MunifTanjim/nui.nvim" },
  { "rcarriga/nvim-notify" },

  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },

  { "numToStr/Comment.nvim", config = true },

  { "windwp/nvim-autopairs", config = true },

  { "kylechui/nvim-surround", config = true },

  { "vimwiki/vimwiki" },

  { "mbbill/undotree" },
})

vim.cmd.colorscheme("catppuccin-mocha")

require("lualine").setup({
  options = {
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
})

require("telescope").setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
require("telescope").load_extension("fzf")

require("gitsigns").setup()

require("which-key").setup()
require("which-key").register({
  ["<leader>w"] = { name = "Windows", },
  ["<leader>f"] = { name = "Find", },
  ["<leader>g"] = { name = "Git", },
  ["<leader>l"] = { name = "LSP", },
  ["<leader>s"] = { name = "Snippets", },
  ["<leader>t"] = { name = "Toggle", },
})

require("noice").setup({
  lsp = {
    override = {
      "vim.lsp.util.convert_input_to_markdown_lines",
      "vim.lsp.util.stylify_markdown",
      "vim.lsp.protocol.make_client_capabilities",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
  },
})

require("Comment").setup()
require("nvim-autopairs").setup()
require("nvim-surround").setup()

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lsp_servers = {
  "pyright",
  "ruff",
  "ts_ls",
  "eslint",
  "lua_ls",
  "yamlls",
  "jsonls",
  "marksman",
  "texlab",
  "bashls",
  "dockerls",
  "docker_compose_language_service",
  "terraformls",
  "sqlls",
  "html",
  "cssls",
  "vimls",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
  automatic_installation = true,
})

for _, server in ipairs(lsp_servers) do
  local ok, _ = pcall(function()
    lspconfig[server].setup({
      capabilities = capabilities,
    })
  end)
  if not ok then
    vim.notify("LSP server '" .. server .. "' not available", vim.log.levels.WARN)
  end
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string<CR>")
vim.keymap.set("n", "<leader>fw", "<cmd>Telescope git_status<CR>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope git_commits<CR>")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")
