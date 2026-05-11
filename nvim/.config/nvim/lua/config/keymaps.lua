local map = vim.keymap.set
local modes = { "n", "i", "v", "x", "c", "t" }

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- CTRL BACKSPACE BEHAVIOUR
--
-- Ctrl+Backspace to delete word
map("i", "<C-BS>", "<C-w>")
map("c", "<C-BS>", "<C-w>")
map("i", "<C-H>", "<C-w>")
map("c", "<C-H>", "<C-w>")

-- BUFFER SHORTCUTS
--
-- Next buffer
map("n", "<M-C-D-J>", function()
	vim.cmd.bprevious()
end, { desc = "Next buffer" })
-- Previous buffer
map("n", "<M-C-D-K>", function()
	vim.cmd.bnext()
end, { desc = "Previous buffer" })
-- Close Neovim
map("n", "<M-C-D-Q>", function()
	vim.cmd.qall()
end, { desc = "Quit Neovim" })
-- Close current buffer
map("n", "<M-C-D-'>", function()
	Snacks.bufdelete({ focus = "prev" })
end, { desc = "Close buffer", nowait = true })

-- WINDOW MANAGEMENT
--
-- Ctrl+w Remap
map("n", "<M-C-S-D-H>", "<C-w>h", { desc = "Go to the left window", noremap = true })
map("n", "<M-C-S-D-L>", "<C-w>l", { desc = "Go to the right window", noremap = true })
map("n", "<M-C-S-D-J>", "<C-w>j", { desc = "Go to the down window", noremap = true })
map("n", "<M-C-S-D-K>", "<C-w>k", { desc = "Go to the up window", noremap = true })
map("n", "<A-Y>", "<C-w>H", { desc = "Move window to far left", noremap = true })
map("n", "<A-O>", "<C-w>L", { desc = "Move window to far right", noremap = true })
map("n", "<A-U>", "<C-w>J", { desc = "Move window to far bottom", noremap = true })
map("n", "<A-I>", "<C-w>K", { desc = "Move window to far top", noremap = true })
map("n", "<M-C-S-D-'>", "<C-w>q", { desc = "Quit a window", noremap = true })
map("n", "<M-C-S-D-I>", "<C-w>s", { desc = "Split window", noremap = true })
map("n", "<M-C-S-D-O>", "<C-w>v", { desc = "Split window vertically", noremap = true })
map("n", "<C-Space>o", "<C-w>o", { desc = "Close all other windows", noremap = true })
map("n", "<C-Space>T", "<C-w>T", { desc = "Break out into a new tab", noremap = true })
map("n", "<C-Space>w", "<C-w>c", { desc = "Close split window", noremap = true })
map("n", "<C-Space>x", "<C-w>x", { desc = "Swap current with next", noremap = true })
map("n", "<C-Space>W", "<C-w>W", { desc = "Move to previous window", noremap = true })
map("n", "<C-Space>+", "<C-w>+", { desc = "Increase height", noremap = true })
map("n", "<C-Space>-", "<C-w>-", { desc = "Decrease height", noremap = true })
map("n", "<C-Space>>", "<C-w>>", { desc = "Increase width", noremap = true })
map("n", "<C-Space><", "<C-w><", { desc = "Decrease width", noremap = true })
map("n", "<C-Space>=", "<C-w>=", { desc = "Equally high and wide", noremap = true })
map("n", "<C-Space>_", "<C-w>_", { desc = "Max out the height", noremap = true })
map("n", "<C-Space>|", "<C-w>|", { desc = "Max out the width", noremap = true })
map("n", "<C-Space>d", "<C-w>d", { desc = "Show diagnostics under the cursor", noremap = true })
map("n", "<C-Space>^D", "<C-w>^D", { desc = "Show diagnostics under the cursor", noremap = true })
-- Terminal window focus
map("t", "<C-Space>h", "<C-\\><C-n><C-w>h", { desc = "Go to the left window", noremap = true })
map("t", "<C-Space>l", "<C-\\><C-n><C-w>l", { desc = "Go to the right window", noremap = true })
map("t", "<C-Space>j", "<C-\\><C-n><C-w>j", { desc = "Go to the down window", noremap = true })
map("t", "<C-Space>k", "<C-\\><C-n><C-w>k", { desc = "Go to the up window", noremap = true })

-- LSP COMMANDS
--
--map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
--map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
--map("n", "gr", vim.lsp.buf.references, { desc = "Show references" })
--map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Show hover info" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })

-- COMMENT CODE
--
map("n", "<C-/>", "gcc", { desc = "Toggle comment line", remap = true })
map("v", "<C-/>", "gc", { desc = "Toggle comment block", remap = true })

map("n", "<M-C-D-H>", "<C-o>", { noremap = true })
map("n", "<M-C-D-L>", "<C-i>", { noremap = true })
map("n", "<leader>f", "za", { noremap = true })

map("n", "<CR>", "o<Esc>")
map("n", "<S-CR>", "O<Esc>")

map("n", "s", "<Plug>(easymotion-s2)")
map("v", "s", "<Plug>(easymotion-s2)")

map("n", "S", "<Plug>(nvim-surround-normal)iw")
