return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = require "user.header"
      return opts
    end,
  },
  { "max397574/better-escape.nvim", enabled = false },
  {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        Copilot = "",
      },
    },
  },
}
