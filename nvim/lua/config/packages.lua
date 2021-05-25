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
  use {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_session_persistence = 1
      vim.g.startify_fortune_use_unicode = 1
      -- Use nvim-web-devicons instead
      function _G.webDevIcons(path)
        local filename = vim.fn.fnamemodify(path, ':t')
        local extension = vim.fn.fnamemodify(path, ':e')
        return require'nvim-web-devicons'.get_icon(filename, extension, { default = true })
      end
      vim.cmd [[
      function! StartifyEntryFormat() abort
        return 'v:lua.webDevIcons(absolute_path) . " " . entry_path'
      endfunction
      ]]
    end
  }
  use 'pgdouyon/vim-evanesco'
  use 'b3nj5m1n/kommentary'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
  use 'simeji/winresizer'
  use { 'famiu/nvim-reload', requires = 'nvim-lua/plenary.nvim' }
  use 'yamatsum/nvim-cursorline'
  use 'roxma/vim-paste-easy'

  -- Undo tree
  use {
    'simnalamburt/vim-mundo', 
    config = function() vimp.nnoremap('<F5>', ':MundoToggle<CR>') end
  }

  -- Navigation
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
      indent = { enable = true },
	  context_commentstring = {
          enable = true
        }
      }
    end,
    requires = 'JoosepAlviste/nvim-ts-context-commentstring'
  }
  use 'VebbNix/lf-vim'

  -- Completion
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require'compe'.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,

        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
          vsnip = true,
          treesitter = true,
          ultisnips = true
        }
    }

    -- Mappings
    vimp.inoremap({'silent', 'expr'}, '<C-Space>', "compe#complete()")
    vimp.inoremap({'silent', 'expr'}, '<CR>', "compe#confirm('<CR>')")
    vimp.inoremap({'silent', 'expr'}, '<C-f>', "compe#scroll({ 'delta': +4 })")
    vimp.inoremap({'silent', 'expr'}, '<C-d>', "compe#scroll({ 'delta': -4 })")
    end
  }

  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = function()
      local nvim_lsp = require'lspconfig'

      -- Use an on_attach function to only map the following keys 
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        --Enable completion triggered by <c-x><c-o>
        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        local opts = { noremap=true, silent=true }
        buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        print('LSP Started.')
      end

      -- Setup servers
      local pid = vim.fn.getpid()

      local omnisharp_bin = vim.fn.exepath('omnisharp')
      nvim_lsp.omnisharp.setup{
          cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
          on_attach = on_attach
      }
    end
  }
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require'lspsaga'.init_lsp_saga()

      vimp.nnoremap({'silent'}, 'gh', function() require'lspsaga.provider'.lsp_finder() end)
      vimp.nnoremap({'silent'}, '<leader>ca', function() require'lspsaga.codeaction'.code_action() end)
      vimp.vnoremap({'silent'}, '<leader>ca', function() require'lspsaga.codeaction'.range_code() end)
      vimp.nnoremap({'silent'}, 'K', function() require'lspsaga.hover'.render_hover_doc() end)
      vimp.nnoremap({'silent'}, '<C-f>', function() require'lspsaga.action'.smart_scroll_with_saga(1) end)
      vimp.nnoremap({'silent'}, '<C-b>', function() require'lspsaga.action'.smart_scroll_with_saga(-1) end)
      vimp.nnoremap({'silent'}, 'gs', function() require'lspsaga.signaturehelp'.signature_help() end)
      vimp.nnoremap({'silent'}, 'gr', function() require'lspsaga.rename'.rename() end)
      vimp.nnoremap({'silent'}, 'gd', function() require'lspsaga.provider'.preview_definition() end)
      vimp.nnoremap({'silent'}, '<leader>cd', function() require'lspsaga.diagnostic'.show_line_diagnostics() end)
      vimp.nnoremap({'silent'}, '<leader>cc', function() require'lspsaga.diagnostic'.show_cursor_diagnostics() end)
      vimp.nnoremap({'silent'}, '[d', function() require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev() end)
      vimp.nnoremap({'silent'}, ']d', function() require'lspsaga.diagnostic'.lsp_jump_diagnostic_next() end)
    end
  }
  use 'folke/lsp-colors.nvim'
  use {
    'onsails/lspkind-nvim',
    config = function() require('lspkind').init() end
  }
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      vim.g.symbols_outline = {
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false, -- experimental
        position = 'right',
        keymaps = {
          close = "<Esc>",
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          rename_symbol = "r",
          code_actions = "a"
        },
        lsp_blacklist = {}
      }
    end
  }

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
  use {
    'vimsence/vimsence',
    cond = function() return vim.fn.exists('g:started_by_firenvim') ~= 1 end
  }
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
