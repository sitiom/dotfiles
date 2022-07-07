local M = {}

M.bufferline = {
   n = {
      ["<S-b>"] = "",
   },
}

M.hlslens = {
   n = {
      ["n"] = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", "" },
      ["N"] = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "" },
      ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", "" },
      ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", "" },
      ["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", "" },
      ["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", "" },
   },
}

return M
