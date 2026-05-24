local map = vim.keymap.set
local vscode = require("vscode")

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<CR>", "o<Esc>")
map("n", "<S-CR>", "O<Esc>")

map({ "n", "v" }, "H", "g^", { desc = "Go to the first character of the line" })
map({ "n", "v" }, "L", "g$", { desc = "Go to the last character of the line" })

-- Leap.nvim Configuration
map({ "n", "x", "o" }, "s", "<Plug>(leap-anywhere)")
local clever = require("leap.user").with_traversal_keys
map({ "n", "x", "o" }, "<tab>", function()
	require("leap").leap({
		["repeat"] = true,
		opts = clever("<cr>", "<bs>"),
	})
end)
map({ "n", "x", "o" }, "<S-tab>", function()
	require("leap").leap({
		["repeat"] = true,
		opts = clever("<bs>", "<cr>"),
		backward = true,
	})
end)

-- Vscode commands
-- Ensure Space is configured as your leader key

-- ============================================================================
-- GENERAL / NAVIGATION
-- ============================================================================

-- Show Which Key info after waiting
map({ "n", "v" }, "<leader>", function()
	vscode.call("whichkey.show")
end)

-- Focus File Explorer Sidebar
map("n", "<leader>e", function()
	vscode.call("workbench.files.action.focusFilesExplorer")
end, { desc = "Focus Explorer" })

-- Global Search (Find in Files)
map("n", "<leader>/", function()
	vscode.call("workbench.action.findInFiles")
end, { desc = "Find in Files" })

-- Open Source Control (Git Panel)
map("n", "<leader>go", function()
	vscode.call("workbench.view.scm")
end, { desc = "Open Git Sidebar" })

-- Open Debug View Sidebar
map("n", "<leader>do", function()
	vscode.call("debug.openView")
end, { desc = "Open Debug Sidebar" })

-- Open Copilot / AI Chat Panels
map("n", "<leader>ao", function()
	vscode.call("workbench.action.chat.open")
end, { desc = "Open AI Chat" })

map("n", "gI", function()
	vscode.call("editor.action.goToImplementation")
end, { desc = "LSP: Go to Implementation" })

-- ============================================================================
-- UI / TOGGLES
-- ============================================================================

-- Toggle Code Fold
map("n", "<leader>f", function()
	vscode.call("editor.toggleFold")
end, { desc = "Toggle Code Fold" })

-- Show Hover Documentation / Diagnostic Popup
map("n", "<leader>k", function()
	vscode.call("editor.action.showHover")
end, { desc = "LSP: Show Hover Documentation" })

-- ============================================================================
-- LANGUAGE SERVER PROTOCOL (LSP) & EDITING
-- ============================================================================

-- Go to Definition
map("n", "<leader>ld", function()
	vscode.call("editor.action.revealDefinition")
end, { desc = "LSP: Go to Definition" })

-- Go to Implementation
map("n", "<leader>li", function()
	vscode.call("editor.action.goToImplementation")
end, { desc = "LSP: Go to Implementation" })

-- Symbol Rename
map("n", "<leader>lr", function()
	vscode.call("editor.action.rename")
end, { desc = "LSP: Rename Symbol" })

-- Quick Fix / Code Actions
map("n", "<leader>la", function()
	vscode.call("editor.action.quickFix")
end, { desc = "LSP: Code Actions" })

-- Format Document
map("n", "<leader>lf", function()
	vscode.call("editor.action.formatDocument")
end, { desc = "LSP: Format Document" })

-- Focus Problems View (Diagnostics List)
map("n", "<leader>le", function()
	vscode.call("workbench.action.problems.focus")
end, { desc = "LSP: Focus Problems Panel" })

-- ============================================================================
-- GIT INTERACTIONS
-- ============================================================================

-- Open File Changes / Diff View
map("n", "<leader>gd", function()
	vscode.call("git.openChange")
end, { desc = "Git: Open Diff View" })

-- Git Checkout Branch / Tag
map("n", "<leader>gb", function()
	vscode.call("git.checkout")
end, { desc = "Git: Checkout Branch" })

-- Git Commit Changes
map("n", "<leader>gc", function()
	vscode.call("git.commit")
end, { desc = "Git: Commit" })

-- Git Push
map("n", "<leader>gp", function()
	vscode.call("git.push")
end, { desc = "Git: Push" })

-- ============================================================================
-- DEBUGGER ENGINE
-- ============================================================================

-- Start Debugging Session / Continue
map("n", "<leader>dc", function()
	vscode.call("workbench.action.debug.start")
end, { desc = "Debug: Start/Continue" })

-- Step Over
map("n", "<leader>ds", function()
	vscode.call("workbench.action.debug.stepOver")
end, { desc = "Debug: Step Over" })

-- Step Into
map("n", "<leader>di", function()
	vscode.call("workbench.action.debug.stepInto")
end, { desc = "Debug: Step Into" })

-- Step Out
map("n", "<leader>du", function()
	vscode.call("workbench.action.debug.stepOut")
end, { desc = "Debug: Step Out" })

-- Toggle Breakpoint on Current Line
map("n", "<leader>db", function()
	vscode.call("editor.debug.action.toggleBreakpoint")
end, { desc = "Debug: Toggle Breakpoint" })

-- Stop Debugging Session
map("n", "<leader>dq", function()
	vscode.call("workbench.action.debug.stop")
end, { desc = "Debug: Stop Session" })

-- ============================================================================
-- EXTENSIONS & MACROS
-- ============================================================================

-- Code Runner: Run current script and focus terminal automatically
map("n", "<leader>r", function()
	vscode.call("code-runner.run")
	vscode.call("workbench.action.terminal.focus")
end, { desc = "Code Runner: Run & Focus Terminal" })
