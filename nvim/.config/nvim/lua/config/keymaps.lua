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
map("n", "<C-j>", function()
	vim.cmd.bprevious()
end, { desc = "Next buffer" })
-- Previous buffer
map("n", "<C-k>", function()
	vim.cmd.bnext()
end, { desc = "Previous buffer" })
-- Close Neovim
map("n", "<C-q>", function()
	vim.cmd.qall()
end, { desc = "Quit Neovim" })
-- Close current buffer
map("n", "<C-w>", function()
	Snacks.bufdelete({ focus = "prev" })
end, { desc = "Close buffer", nowait = true })

-- WINDOW MANAGEMENT
--
-- Ctrl+w Remap
map("n", "<C-Space>h", "<C-w>h", { desc = "Go to the left window", noremap = true })
map("n", "<C-Space>l", "<C-w>l", { desc = "Go to the right window", noremap = true })
map("n", "<C-Space>j", "<C-w>j", { desc = "Go to the down window", noremap = true })
map("n", "<C-Space>k", "<C-w>k", { desc = "Go to the up window", noremap = true })
map("n", "<C-Space>H", "<C-w>H", { desc = "Move window to far left", noremap = true })
map("n", "<C-Space>L", "<C-w>L", { desc = "Move window to far right", noremap = true })
map("n", "<C-Space>J", "<C-w>J", { desc = "Move window to far bottom", noremap = true })
map("n", "<C-Space>K", "<C-w>K", { desc = "Move window to far top", noremap = true })
map("n", "<C-Space>o", "<C-w>o", { desc = "Close all other windows", noremap = true })
map("n", "<C-Space>q", "<C-w>q", { desc = "Quit a window", noremap = true })
map("n", "<C-Space>s", "<C-w>s", { desc = "Split window", noremap = true })
map("n", "<C-Space>v", "<C-w>v", { desc = "Split window vertically", noremap = true })
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
