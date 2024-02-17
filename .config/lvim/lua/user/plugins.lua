-- These are additional plugins to supercharge lunarvim
-- Lunarvim core plugins list: https://www.lunarvim.org/docs/plugins/core-plugins-list
lvim.plugins = {
  -- Colorschemes
  { "folke/tokyonight.nvim" },
  { "jeferson-sb/amethyst" },
  -- Diagnostics
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end
  },
  -- AutoSave
  {
    "pocco81/auto-save.nvim",
    config = function()
      require("autosave").setup()
    end
  },
  -- Autocompletion
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  -- Handful find and replace panel
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  -- Markdown browser preview
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = { "markdown" },
    setup = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  -- Color highlighting
  {
    "NvChad/nvim-colorizer.lua"
  },
  -- Smooth Scroll
  {
    "karb94/neoscroll.nvim"
  },
  -- Flash messages / notifications
  {
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim",
    },
  },
  -- Emmet
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
