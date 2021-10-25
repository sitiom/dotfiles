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
          colors = {
            fg = '#D4D4D4',
            bg = '#161616'
          }
      }
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
  'akinsho/nvim-bufferline.lua',
    config = function() require("bufferline").setup() end,
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'Mofiqul/vscode.nvim'

  -- Enhancements
  use 'jeffkreeftmeijer/vim-numbertoggle'
  use 'tversteeg/registers.nvim'
  use {
    'windwp/nvim-autopairs',
    config = function() require'nvim-autopairs'.setup{} end
  }
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
  use {
    'blackCauldron7/surround.nvim',
    config = function()
      require"surround".setup{ mappings_style = "surround" }
    end
  }
  use 'tpope/vim-unimpaired'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'simeji/winresizer'
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
    'hrsh7th/nvim-cmp',
    after = 'nvim-autopairs',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'onsails/lspkind-nvim' },
    config = function()
      local cmp = require 'cmp'
      local lspkind = require'lspkind'
      cmp.setup {
        formatting = {
          format = lspkind.cmp_format{
            with_text = true,
            menu = {
              buffer = "[Buffer]",
              nvim_lsp = "[LSP]",
              luasnip = "[LuaSnip]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Latex]",
            }
          }
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
    }

    require'nvim-autopairs.completion.cmp'.setup{
      map_cr = true,
      map_complete = false,
      auto_select = true,
      insert = false,
      map_char = {
        all = '(',
        tex = '{'
      }
    }
    end
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      local lsp_installer = require'nvim-lsp-installer'
      local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
        print'LSP Started.'
      end

      lsp_installer.on_server_ready(function(server)
        local opts = {
          on_attach = on_attach,
          capabilities = capabilities
        }

        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
      end)
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
  use {
    'nanotee/zoxide.vim',
    requires = {
      {
        'junegunn/fzf.vim',
        requires = {
          'junegunn/fzf',
          run = function() vim.fn['fzf#install']() end 
        }
      }
    }
  }
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
    'andweeb/presence.nvim',
    setup = function() vim.g.presence_main_image = "file" end,
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
