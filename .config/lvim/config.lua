local kOpts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
vim.opt.foldmethod = "syntax"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

keymap("n", "<C-s>", ":w<cr>", kOpts)

-- tab navigation
keymap("n", "<S-h>", ":bprev<cr>", kOpts)
keymap("n", "<S-l>", ":bnext<cr>", kOpts)

-- resize with ctrl + arrow
keymap("n", "<C-Left>", ":vertical resize -2<CR>", kOpts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", kOpts)
keymap("n", "<C-Up>", ":resize +2<CR>", kOpts)
keymap("n", "<C-Down>", ":resize -2<CR>", kOpts)

-- move lines
keymap("n", "<A-j>", "<Esc>:m .+1<CR>=gi", kOpts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>=gi", kOpts)

-- split
keymap("n", "<C-\\>", ":split", kOpts)

-- misc
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", kOpts)

-- builtins
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "vue" }
  },
  { command = "black", filetypes = { "python" } }
}

-- linters
local linters = require "lvim.lsp.null-ls.linters"

linters.setup = {
  { command = "flake8" },
  { command = "eslint" },
  { command = "shellcheck", args = { "--severity", "warning" } },
  { command = "codespell", filetypes = { "javascript", "python" } }
}

-- plugins
lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "lunarvim/colorscheme" },
  { "sainnhe/sonokai" },
  {
    "RRethy/vim-illuminate"
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "Pocco81/AutoSave.nvim",
    config = function()
      require("autosave").setup()
    end,
  },
  {
    "aca/emmet-ls",
    config = function()
      local lspconfig = require("lspconfig")
      local configs = require("lspconfig/configs")

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
          "documentation",
          "detail",
          "additionalTextEdits",
        },
      }

      if not lspconfig.emmet_ls then
        configs.emmet_ls = {
          default_config = {
            cmd = { "emmet-ls", "--stdio" },
            filetypes = {
              "html",
              "css",
              "javascript",
              "typescript",
              "eruby",
              "typescriptreact",
              "javascriptreact",
              "svelte",
              "vue",
            },
            root_dir = function(fname)
              return vim.loop.cwd()
            end,
            settings = {},
          },
        }
      end
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
    end,
  },
}
