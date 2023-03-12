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
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      main_image = "file",
    },
  },
}
