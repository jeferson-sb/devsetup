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
