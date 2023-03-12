return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot-cmp",
  },
  opts = function(_, opts)
    local cmp = require "cmp"
    return require("astronvim.utils").extend_tbl(opts, {
      sources = cmp.config.sources {
        { name = "copilot",  priority = 1250 },
        { name = "nvim_lsp", priority = 1000 },
        { name = "buffer",   priority = 500 },
        { name = "path",     priority = 250 },
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
