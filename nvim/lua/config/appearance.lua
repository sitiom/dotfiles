vim.o.termguicolors = true
vim.o.guifont = 'Delugia Nerd Font:' .. (vim.fn.exists('g:started_by_firenvim') ~= 1 and "h15" or "h10")
vim.o.background = 'dark'
vim.cmd 'colorscheme vscode'
vim.wo.list = true
local listchars = {
  'tab:» ',
  'eol:↲',
  'nbsp:␣',
  'trail:•',
}
vim.o.listchars = table.concat(listchars, ',')
