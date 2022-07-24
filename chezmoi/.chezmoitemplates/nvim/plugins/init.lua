local not_in_vscode = function()
   return not vim.g.vscode
end

return {
   -- Core plugins
   ["lukas-reineke/indent-blankline.nvim"] = {
      cond = not_in_vscode,
   },
   ["NvChad/nvim-colorizer.lua"] = {
      cond = not_in_vscode,
   },
   ["nvim-treesitter/nvim-treesitter"] = {
      cond = not_in_vscode,
   },
   ["nvim-telescope/telescope.nvim"] = {
      cond = not_in_vscode,
   },
   -- Extra builtin plugins
   ["goolord/alpha-nvim"] = {
      disable = false,
      cond = not_in_vscode,
   },
   -- User plugins
   ["sitiom/nvim-numbertoggle"] = {
      config = function()
         require("numbertoggle").setup()
      end,
   },
   ["NMAC427/guess-indent.nvim"] = {
      config = function()
         require("guess-indent").setup {}
      end,
   },
   ["kevinhwang91/nvim-hlslens"] = {
      cond = not_in_vscode,
   },
   ["tpope/vim-repeat"] = {},
   ["kylechui/nvim-surround"] = {
      config = function()
         require("nvim-surround").setup {}
      end,
   },
   ["tpope/vim-unimpaired"] = {},
   ["winston0410/range-highlight.nvim"] = {
      requires = "winston0410/cmd-parser.nvim",
      config = function()
         require("range-highlight").setup {}
      end,
   },
   ["yamatsum/nvim-cursorline"] = {
      cond = not_in_vscode,
   },
   ["lambdalisue/suda.vim"] = {
      config = function()
         vim.g.suda_smart_edit = 1
      end,
      cond = not_in_vscode,
   },
   ["petertriho/nvim-scrollbar"] = {
      after = "nvim-hlslens",
      config = function()
         require("scrollbar").setup()
         require("scrollbar.handlers.search").setup()
      end,
   },
   ["VebbNix/lf-vim"] = {},
   ["gpanders/editorconfig.nvim"] = {
      cond = not_in_vscode,
   },
   ["andweeb/presence.nvim"] = {
      config = function()
         require("presence"):setup { main_image = "file" }
      end,
   },
   ["luukvbaal/stabilize.nvim"] = {
      config = function()
         require("stabilize").setup()
      end,
      cond = not_in_vscode,
   },
   ["j-hui/fidget.nvim"] = {
      config = function()
         require("fidget").setup {
            window = {
               blend = 0,
            },
         }
      end,
      cond = not_in_vscode,
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.configs.null-ls").setup()
      end,
      cond = not_in_vscode,
   },
   ["p00f/nvim-ts-rainbow"] = {
      after = "nvim-treesitter",
      cond = not_in_vscode,
   },
   ["alker0/chezmoi.vim"] = {},
}
