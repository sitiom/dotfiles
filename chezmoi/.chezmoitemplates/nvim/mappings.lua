return {
  n = {
    ["<Esc>"] = { "<Cmd>noh<CR>", desc = "No Highlight" },
    ["n"] = {
      "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>",
      desc = "Search forward matched pattern",
    },
    ["N"] = {
      "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>",
      desc = "Search backward matched pattern",
    },
    ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", desc = "Search forward word under cursor (exact)" },
    ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", desc = "Search backward word under cursor (exact)" },
    ["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", desc = "Search forward word under cursor" },
    ["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", desc = "Search back word under cursor" },
  },
}
