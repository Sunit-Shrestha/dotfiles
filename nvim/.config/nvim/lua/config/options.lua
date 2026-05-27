local opt = vim.opt

opt.ignorecase = true
opt.smartcase = true

-- Tab Settings
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.foldmethod = "indent"
opt.foldlevel = 99

-- Line Numbers
opt.number = true
opt.relativenumber = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Disable Netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
