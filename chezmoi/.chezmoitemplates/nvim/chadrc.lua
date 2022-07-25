local M = {}

local userPlugins = require "custom.plugins"

M.ui = {
   theme = "catppuccin",
   transparency = true,
}

M.plugins = {
   override = {
      ["kyazdani42/nvim-tree.lua"] = {
         view = {
            hide_root_folder = false,
         },
         git = {
            enable = true,
         },
      },
      ["nvim-treesitter/nvim-treesitter"] = {
         ensure_installed = "all",
         rainbow = {
            enable = true,
         },
      },
   },
   user = userPlugins,
}

M.mappings = require "custom.mappings"

return M
