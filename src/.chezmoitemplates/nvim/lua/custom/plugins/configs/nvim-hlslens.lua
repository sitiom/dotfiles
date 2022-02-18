local map = require("core.utils").map

local M = {}

M.setup = function()
  map("n", "n", "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
  map("n", "N", "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
  map("n", "*", "*<Cmd>lua require('hlslens').start()<CR>", { silent = false })
  map("n", "#", "#<Cmd>lua require('hlslens').start()<CR>", { silent = false })
  map("n", "g*", "g*<Cmd>lua require('hlslens').start()<CR>", { silent = false })
  map("n", "g#", "g#<Cmd>lua require('hlslens').start()<CR>", { silent = false })
end

return M
