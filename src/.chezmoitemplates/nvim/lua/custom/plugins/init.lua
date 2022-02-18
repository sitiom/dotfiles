return {
   "jeffkreeftmeijer/vim-numbertoggle",
   {
     "karb94/neoscroll.nvim",
     opt = true,
     config = function()
       require"neoscroll".setup()
     end,
     setup = function()
       require"core.utils".packer_lazy_load "neoscroll.nvim"
     end,
    },
    "tpope/vim-sleuth",
    {
      'kevinhwang91/nvim-hlslens',
      config = function()
        require"custom.plugins.configs.nvim-hlslens".setup()
      end
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require"todo-comments".setup()
    end
  },
  "tpope/vim-repeat",
  {
    "blackCauldron7/surround.nvim",
    config = function()
      require"surround".setup{ mappings_style = "surround" }
    end
  },
  "tpope/vim-unimpaired",
  {
    "winston0410/range-highlight.nvim",
    requires = 'winston0410/cmd-parser.nvim',
    config = function()
      require'range-highlight'.setup{}
    end
  },
  "yamatsum/nvim-cursorline",
  {
    "lambdalisue/suda.vim",
    config = function()
      vim.g.suda_smart_edit = 1
    end
  },
  {
    "petertriho/nvim-scrollbar",
    after = 'nvim-hlslens',
    config = function()
      require"scrollbar".setup()
      require"scrollbar.handlers.search".setup()
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
      after = "nvim-treesitter",
      config = function()
        require'nvim-treesitter.configs'.setup {
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          }
        }
      end
  },
  "VebbNix/lf-vim",
  "gpanders/editorconfig.nvim",
  {
    "andweeb/presence.nvim",
    config = function()
      require"presence":setup { main_image = "file" }
    end,
  },
  { "raghur/vim-ghost", run = ":GhostInstall" },
  {
    "luukvbaal/stabilize.nvim",
    config = function() require"stabilize".setup() end
  },
  "williamboman/nvim-lsp-installer",
  {
    "j-hui/fidget.nvim",
    config = function()
      require"fidget".setup {
        window = {
          blend = 0,
        }
      }
    end,
  },
  {
    "gelfand/copilot.vim",
    config = function()
      -- Copilot assume mapped
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim",
    after = "nvim-lspconfig",
    config = function()
      require"custom.plugins.configs.null-ls".setup()
    end
  },
  "hrsh7th/cmp-copilot",
  {
    "p00f/nvim-ts-rainbow",
    after = "nvim-treesitter"
  },
  {
    "jvgrootveld/telescope-zoxide",
    after = "telescope.nvim",
    requires = "nvim-lua/popup.nvim",
    config =function ()
      require"telescope".load_extension("zoxide")
    end
  }
}
