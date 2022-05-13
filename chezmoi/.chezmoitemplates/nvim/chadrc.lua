local M = {}

local userPlugins = require "custom.plugins"

-- Plugins
local cmp = require "cmp"

M.options = {
  user = function()
      vim.opt.clipboard = ""
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
    ["numToStr/Comment.nvim"] = {
      pre_hook = function(ctx)
        local U = require 'Comment.utils'

        local location = nil
        if ctx.ctype == U.ctype.block then
          location = require('ts_context_commentstring.utils').get_cursor_location()
        elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
          location = require('ts_context_commentstring.utils').get_visual_start_location()
        end

        return require('ts_context_commentstring.internal').calculate_commentstring {
          key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
          location = location,
        }
      end
    },
    ["hrsh7th/nvim-cmp"] = {
      formatting = {
        format = function(entry, vim_item)
          local icons = require "plugins.configs.lspkind_icons"
          vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

          vim_item.menu = ({
            copilot = "[COP]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
          })[entry.source.name]

          return vim_item
        end,
      },
      mapping = {
        ["<CR>"] = cmp.mapping.confirm { select = false },
      },
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "nvim_lua" },
        { name = "path" },
      },
      experimental = {
        ghost_text = true,
      },
    },
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

