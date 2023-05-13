return {
  -- Vimscript plugins
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "tpope/vim-unimpaired",
    event = "VeryLazy",
  },
  -- Lua plugins
  {
    "sitiom/nvim-numbertoggle",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
  {
    "neoclide/coc.nvim",
    branch = "release",
    event = "VeryLazy",
    init = function()
      vim.g.coc_global_extensions = { "coc-discord-rpc" }
    end
  },
}
