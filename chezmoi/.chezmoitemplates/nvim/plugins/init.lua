return {
   -- Extra builtin plugins
   ["goolord/alpha-nvim"] = {
      disable = false,
   },
   ["NvChad/nvim-colorizer.lua"] = {
      disable = false,
   },
   -- User plugins
   ["jeffkreeftmeijer/vim-numbertoggle"] = {},
   ["karb94/neoscroll.nvim"] = {
      opt = true,
      config = function()
         require"neoscroll".setup()
      end,
   },
   ["tpope/vim-sleuth"] = {},
   ['kevinhwang91/nvim-hlslens'] = {},
   ["folke/todo-comments.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      config = function()
         require"todo-comments".setup()
      end
   },
   ["tpope/vim-repeat"] = {},
   ["ur4ltz/surround.nvim"] = {
      config = function()
         require"surround".setup{ mappings_style = "surround" }
      end
   },
   ["tpope/vim-unimpaired"] = {},
   ["winston0410/range-highlight.nvim"] = {
      requires = 'winston0410/cmd-parser.nvim',
      config = function()
         require'range-highlight'.setup{}
      end
   },
   ["yamatsum/nvim-cursorline"] = {},
   ["lambdalisue/suda.vim"] = {
      config = function()
         vim.g.suda_smart_edit = 1
      end
   },
   ["petertriho/nvim-scrollbar"] = {
      after = 'nvim-hlslens',
      config = function()
         require"scrollbar".setup()
         require"scrollbar.handlers.search".setup()
      end
   },
   ["VebbNix/lf-vim"] = {},
   ["editorconfig/editorconfig-vim"] = {},
   ["andweeb/presence.nvim"] = {
      config = function()
         require"presence":setup { main_image = "file" }
      end,
   },
   ["raghur/vim-ghost"] = { run = ":GhostInstall" },
   ["luukvbaal/stabilize.nvim"] = {
      config = function() require"stabilize".setup() end
   },
   ["j-hui/fidget.nvim"] = {
      config = function()
         require"fidget".setup {
            window = {
               blend = 0,
            }
         }
      end,
   },
   -- ["gelfand/copilot.vim"] = {
   --    config = function()
   --       -- Copilot assume mapped
   --       vim.g.copilot_assume_mapped = true
   --       vim.g.copilot_no_tab_map = true
   --    end,
   -- },
   -- ["hrsh7th/cmp-copilot"] = {},
   ["jose-elias-alvarez/null-ls.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      after = "nvim-lspconfig",
      config = function()
         require"custom.plugins.configs.null-ls".setup()
      end
   },
   ["p00f/nvim-ts-rainbow"] = {
      after = "nvim-treesitter"
   },
   ["jvgrootveld/telescope-zoxide"] = {
      after = "telescope.nvim",
      requires = "nvim-lua/popup.nvim",
      config =function ()
         require"telescope".load_extension("zoxide")
      end
   },
   ["alker0/chezmoi.vim"] = {},
}
