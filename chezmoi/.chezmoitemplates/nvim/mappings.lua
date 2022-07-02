local M = {}

M.bufferline = {
   n = {
      ["<S-b>"] = "",
   },
}

M.telescope = {
   n = {
      ["<leader>fz"] = { "<cmd> Telescope zoxide list<CR>", "Open zoxide" },
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
