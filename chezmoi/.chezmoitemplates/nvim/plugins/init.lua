return {
  -- Theme
  ["catppuccin/nvim"] = {
    as = "catppuccin",
    config = function()
      require("catppuccin").setup {}
    end,
  },
  -- Vimscript plugins
  ["tpope/vim-repeat"] = {},
  ["camnw/lf-vim"] = {},
  ["alker0/chezmoi.vim"] = {},
  -- Lua plugins
  ["sitiom/nvim-numbertoggle"] = {
    config = function()
      require("numbertoggle").setup()
    end,
  },
  ["kevinhwang91/nvim-hlslens"] = {},
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  ["yamatsum/nvim-cursorline"] = {},
  ["petertriho/nvim-scrollbar"] = {
    after = "nvim-hlslens",
    config = function()
      require("scrollbar").setup()
      require("scrollbar.handlers.search").setup()
    end,
  },
  ["gpanders/editorconfig.nvim"] = {},
  ["andweeb/presence.nvim"] = {
    config = function()
      require("presence"):setup { main_image = "file" }
    end,
  },
  ["luukvbaal/stabilize.nvim"] = {
    config = function()
      require("stabilize").setup()
    end,
  },
  ["j-hui/fidget.nvim"] = { -- https://github.com/j-hui/fidget.nvim/issues/62
    config = function()
      require("fidget").setup {
        window = {
          blend = 0,
        },
      }
    end,
  },
}
