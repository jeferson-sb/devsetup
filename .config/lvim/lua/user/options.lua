vim.opt.foldmethod = "syntax"

lvim.log.level = "warn"
-- lvim.format_on_save = { pattern = "*", timeout = 2000 }
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.breadcrumbs.active = true
vim.diagnostic.config({ virtual_text = false, underline = true });

-- treesitter
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
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

-- telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
  "vendor/*",
  "node_modules/*",
  "__pycache__/"
}

-- lualine statusline config
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_z = {
  { 'location', separator = { left = '' }, icons_enabled = true, },
  {
    "os.date('🕔 %I:%M %p')",
    separator = { left = '' },
    icons_enabled = true,
    color = { bg = '#3b4261', fg = '#7aa2f7', gui = 'bold' },
  }
}
lvim.builtin.lualine.sections.lualine_a = { { 'mode', separator = { right = '', }, left_padding = 2 } }
lvim.builtin.lualine.sections.lualine_b = {
  { 'branch', separator = { right = '', }, color = { bg = '#373f49' } },
  { 'diff', separator = { right = '', }, color = { bg = '#373f49' } },
  { 'diagnostics', separator = { right = '', }, color = { bg = '#373f49' } }
}
lvim.builtin.lualine.options.component_separators = ''
