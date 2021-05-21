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
  use 'simnalamburt/vim-mundo'

  -- Navigation
  use 'psliwka/vim-smoothie'
  use 'dstein64/nvim-scrollview'

  -- Syntax highlighting
  use 'sheerun/vim-polyglot' -- TODO: Replace with treesitter
  use 'VebbNix/lf-vim'

  -- Formatting
  use 'sbdchd/neoformat'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
  }

  -- Integrations
  use 'editorconfig/editorconfig-vim'
  use 'ptzz/lf.vim'
  use 'nanotee/zoxide.vim'
  use { 'voldikss/vim-floaterm', opt = true }
  use 'vimsence/vimsence'
  use {
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end
  }

  -- Misc
  use 'ThePrimeagen/vim-be-good'
end)

vim.cmd 'packadd vimpeccable'

-- Appearance
vim.o.termguicolors = true
vim.o.guifont = 'Delugia Nerd Font:' .. (vim.fn.exists('g:started_by_firenvim') ~= 1 and "h15" or "h10")

vim.cmd 'colorscheme codedark'

if vim.fn.has('win32') == 1 then
  vim.o.shell = 'pwsh'
  vim.o.shellquote = ''
  vim.o.shellpipe= '|'
  vim.o.shellxquote = ''
  vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellredir = '| Out-File -Encoding UTF8'
end
-- Add vim-floaterm after shell is set
vim.cmd "packadd vim-floaterm"

-- Configuration
vim.bo.undofile = true
vim.o.undofile = true

vim.wo.number = true
vim.wo.relativenumber = true
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.updatetime = 100
vim.o.mouse = 'a'

vim.g.lf_map_keys = 0
vim.g.lf_replace_netrw = 1
vim.g.lf_width = 0.9
vim.g.lf_height = 0.9

vim.g.neoformat_verbose = 1
vim.g.neoformat_basic_format_retab = 1
vim.g.neoformat_basic_format_trim = 1

vim.g.firenvim_config = {
  localSettings = {
    [".*"] = {
      takeover = 'never'
    }
  }
}

vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"

-- Mappings
vimp.nnoremap('<F5>', ':MundoToggle<CR>')
vimp.nnoremap('<C-p>', ':Lf<CR>')
vimp.nnoremap('<leader>ff', function() require('telescope.builtin').find_files() end)
vimp.nnoremap('<leader>fg', function() require('telescope.builtin').live_grep() end)
vimp.nnoremap('<leader>fb', function() require('telescope.builtin').buffers() end)
vimp.nnoremap('<leader>fh', function() require('telescope.builtin').help_tags() end)

vim.g.floaterm_keymap_new = '<F7>'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F12>'
