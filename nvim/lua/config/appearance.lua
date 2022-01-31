vim.o.termguicolors = true
vim.o.guifont = 'Delugia Nerd Font:h10'
vim.g.vscode_style = "dark"
vim.cmd 'colorscheme vscode'
vim.wo.list = true
local listchars = {
  'tab:» ',
  'eol:↲',
  'nbsp:␣',
  'trail:•',
}
vim.o.listchars = table.concat(listchars, ',')
