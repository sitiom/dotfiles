vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('data')..'/undo'

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.hidden = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.updatetime = 100
vim.o.mouse = 'a'

-- Indentation
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.completeopt = "menuone,noselect"
