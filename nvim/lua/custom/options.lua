vim.o.guifont = 'Delugia Nerd Font:h10'
vim.wo.list = true
local listchars = {
  'tab:» ',
  'eol:↲',
  'nbsp:␣',
  'trail:•',
}
vim.o.listchars = table.concat(listchars, ',')
