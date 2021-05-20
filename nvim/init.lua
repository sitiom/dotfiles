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
  'glepnir/galaxyline.nvim',
    config = function() require 'statusline' end,
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
  use 'jiangmiao/auto-pairs'
  use 'mhinz/vim-signify'
  use 'mhinz/vim-startify'
  use 'pgdouyon/vim-evanesco'
  use 'tyru/caw.vim'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use 'simeji/winresizer'
  use 'onsails/lspkind-nvim'
  use { 'famiu/nvim-reload', requires = 'nvim-lua/plenary.nvim'}

  -- Undo tree
  use 'simnalamburt/vim-mundo'

  -- Navigation
  use 'psliwka/vim-smoothie'
  use 'dstein64/nvim-scrollview'

  -- Syntax highlighting
  use 'sheerun/vim-polyglot'
  use 'VebbNix/lf-vim'

  -- Formatting
  use 'sbdchd/neoformat'

  -- Integrations
  if vim.fn.has('win32') == 1 then
    use {
      'junegunn/fzf',
      run = function()
        vim.fn['fzf#install']()
      end
    }
  else
    use '/usr/bin/fzf'
  end
  use 'editorconfig/editorconfig-vim'
  use 'junegunn/fzf.vim'
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

-- https://github.com/nanotee/nvim-lua-guide#defining-autocommands
vim.cmd "au TextYankPost * silent! lua vim.highlight.on_yank()"

-- Mappings
vimp.nnoremap('<F5>', ':MundoToggle<CR>')
vim.o.pastetoggle = '<F2>'
vim.g.floaterm_keymap_new = '<F7>'
vim.g.floaterm_keymap_prev = '<F8>'
vim.g.floaterm_keymap_next = '<F9>'
vim.g.floaterm_keymap_toggle = '<F12>'
