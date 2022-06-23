local M = {}

local userPlugins = require "custom.plugins"

M.options = {
  user = function()
      require'custom.options'
  end
}

M.ui = {
  theme = "catppuccin",
  transparency = true
}

M.plugins = {
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.configs.lspconfig"
    }
  },
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
      rainbow = {
        enable = true
      },
    },
  },
  user = userPlugins,
}


M.mappings = require "custom.mappings"

return M

