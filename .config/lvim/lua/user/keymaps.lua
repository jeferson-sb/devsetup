local kOpts = { noremap = true, silent = true }
local keymap = vim.keymap.set

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

-- misc
keymap("n", "<C-z>", "<cmd>ZenMode<cr>", kOpts)
