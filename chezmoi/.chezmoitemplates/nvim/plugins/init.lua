local not_in_vscode = function()
   return not vim.g.vscode
end

return {
   -- Core plugins
   ["nvim-treesitter/nvim-treesitter"] = {
      cond = not_in_vscode,
   },
   -- Extra builtin plugins
   ["goolord/alpha-nvim"] = {
      disable = false,
   },
   ["NvChad/nvim-colorizer.lua"] = {
      disable = false,
   },
   -- User plugins
   ["sitiom/nvim-numbertoggle"] = {},
   ["karb94/neoscroll.nvim"] = {
      opt = true,
      config = function()
         require("neoscroll").setup()
      end,
   },
   ["tpope/vim-sleuth"] = {},
   ["kevinhwang91/nvim-hlslens"] = {
      cond = not_in_vscode,
   },
   ["folke/todo-comments.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      config = function()
         require("todo-comments").setup()
      end,
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
   ["yamatsum/nvim-cursorline"] = {},
   ["lambdalisue/suda.vim"] = {
      config = function()
         vim.g.suda_smart_edit = 1
      end,
   },
   ["petertriho/nvim-scrollbar"] = {
      after = "nvim-hlslens",
      config = function()
         require("scrollbar").setup()
         require("scrollbar.handlers.search").setup()
      end,
      cond = not_in_vscode,
   },
   ["VebbNix/lf-vim"] = {},
   ["editorconfig/editorconfig-vim"] = {},
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
   ["j-hui/fidget.nvim"] = {
      config = function()
         require("fidget").setup {
            window = {
               blend = 0,
            },
         }
      end,
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.configs.null-ls").setup()
      end,
   },
   ["p00f/nvim-ts-rainbow"] = {
      after = "nvim-treesitter",
      cond = not_in_vscode,
   },
   ["jvgrootveld/telescope-zoxide"] = {
      after = "telescope.nvim",
      requires = "nvim-lua/popup.nvim",
      config = function()
         require("telescope").load_extension "zoxide"
      end,
   },
   ["alker0/chezmoi.vim"] = {},
}
