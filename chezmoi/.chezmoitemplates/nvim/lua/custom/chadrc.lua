local M = {}

local userPlugins = require "custom.plugins"

M.options = {
  clipboard = "",
  relativenumber = true
}

M.ui = {
  theme = "catppuccin",
  transparency = true
}

M.plugins = {
  status = {
    colorizer = true,
    dashboard = true,
  },
  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.configs.lspconfig"
    }
  },
  default_plugin_config_replace = {
    nvim_comment = {
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
    nvim_cmp = {
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
    nvim_tree = {
      view = {
        hide_root_folder = false,
      },
      git = {
        enable = true,
      },
    },
    nvim_treesitter = {
      rainbow = {
        enable = true
      },
    },
  },
  install = userPlugins,
}

return M

