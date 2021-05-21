-- Bootstrap packer.nvim
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd 'packadd packer.nvim'

-- Packages
require('packer').startup(function()
  -- Self manage
  use { 'wbthomason/packer.nvim', opt = true }

  -- Vimpeccable
  use { 'svermeulen/vimpeccable', opt = true }

  -- Theme and Appearance
  use {
    'famiu/feline.nvim',
    config = function()
      require('feline').setup{
        default_fg = '#D4D4D4',
        default_bg = '#161616'
      }
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
  'akinsho/nvim-bufferline.lua',
    config = function() require("bufferline").setup() end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'tomasiser/vim-code-dark'

  -- Enhancements
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use 'LunarWatcher/auto-pairs'
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
    requires = 'nvim-lua/plenary.nvim'
  }
  use 'mhinz/vim-startify'
  use 'pgdouyon/vim-evanesco'
  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use 'simeji/winresizer'
  use { 'famiu/nvim-reload', requires = 'nvim-lua/plenary.nvim' }
  use 'roxma/vim-paste-easy'

  -- Undo tree
  use {
    'simnalamburt/vim-mundo', 
    config = function() vimp.nnoremap('<F5>', ':MundoToggle<CR>') end
  }

  -- Navigation
  use 'psliwka/vim-smoothie'
  use 'dstein64/nvim-scrollview'

  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = { enable = true },
	incremental_selection = {
	  enable = true,
	  keymaps = {
	    init_selection = "gnn",
	    node_incremental = "grn",
	    scope_incremental = "grc",
	    node_decremental = "grm"
	  }
	},
	context_commentstring = {
          enable = true
        }
      }
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring'
  }
  use 'VebbNix/lf-vim'

  -- Formatting
  use {
    'sbdchd/neoformat',
    config = function()
      vim.g.neoformat_verbose = 1
      vim.g.neoformat_basic_format_retab = 1
      vim.g.neoformat_basic_format_trim = 1
    end
  }

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'},
    config = function()
      vimp.nnoremap('<leader>ff', function() require('telescope.builtin').find_files() end)
      vimp.nnoremap('<leader>fg', function() require('telescope.builtin').live_grep() end)
      vimp.nnoremap('<leader>fb', function() require('telescope.builtin').buffers() end)
      vimp.nnoremap('<leader>fh', function() require('telescope.builtin').help_tags() end)
    end
  }

  -- Integrations
  use 'editorconfig/editorconfig-vim'
  use {
    'ptzz/lf.vim',
    config = function()
      vim.g.lf_map_keys = 0
      vim.g.lf_replace_netrw = 1
      vim.g.lf_width = 0.9
      vim.g.lf_height = 0.9

      vimp.nnoremap('<C-p>', ':Lf<CR>')
    end
  }
  use 'nanotee/zoxide.vim'
  use {
    'voldikss/vim-floaterm',
    setup = function()
      vimp.nnoremap({'silent'}, '<F7>', ':FloatermNew<CR>')
      vimp.tnoremap({'silent'}, '<F7>', '<C-\\><C-n>:FloatermNew<CR>')
      vimp.nnoremap({'silent'}, '<F8>', ':FloatermPrev<CR>')
      vimp.tnoremap({'silent'}, '<F8>', '<C-\\><C-n>:FloatermPrev<CR>')
      vimp.nnoremap({'silent'}, '<F9>', ':FloatermNext<CR>')
      vimp.tnoremap({'silent'}, '<F9>', '<C-\\><C-n>:FloatermNext<CR>')
      vimp.nnoremap({'silent'}, '<F12>', ':FloatermToggle<CR>')
      vimp.tnoremap({'silent'}, '<F12>', '<C-\\><C-n>:FloatermToggle<CR>')
    end,
    opt = true
  }
  use 'vimsence/vimsence'
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
    config = function()
      vim.g.firenvim_config = {
        localSettings = {
          [".*"] = {
            takeover = 'never'
          }
        }
      }
    end
  }

  -- Misc
  use 'ThePrimeagen/vim-be-good'
end)

vim.cmd 'packadd vimpeccable'
vim.cmd 'packadd vim-floaterm'
