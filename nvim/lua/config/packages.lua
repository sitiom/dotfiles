-- Bootstrap packer.nvim
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Packages
require('packer').startup(function()
  -- Self manage
  use 'wbthomason/packer.nvim'

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
  use {
    'karb94/neoscroll.nvim',
    config = function() require'neoscroll'.setup() end
  }
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
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons', 'iwataka/cowsay.vim' },
    config = function ()
      local startify = require'alpha.themes.startify'

      startify.section.header.val = vim.fn['cowsay#cowsay'](require'alpha.fortune'(), 'milk')
      startify.section.top_buttons.val = {
        startify.button("e", "New file", ":ene <CR>"),
        startify.button("s", "Open session", ":SearchSession<CR>"),
      }

      require("alpha").setup(startify.opts)
    end
  }
  use 'tpope/vim-sleuth'
  use {
    'rmagatti/auto-session',
    config = function()
      local opts = {
        log_level = 'info',
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
        auto_session_enabled = false,
        auto_save_enabled = nil,
        auto_restore_enabled = nil,
        auto_session_sppress_dirs = nil
      }
      require'auto-session'.setup(opts)
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
  use {
    'winston0410/range-highlight.nvim',
    requires = 'winston0410/cmd-parser.nvim',
    config = function()
      require'range-highlight'.setup{}
    end
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
     config = function() vim.g.indentLine_fileTypeExclude = {'alpha'} end
  }
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
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          })
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        })
      }

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
    end
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use {
    'tami5/lspsaga.nvim',
    branch = 'nvim51',
    config = function() require'lspsaga'.init_lsp_saga() end
  }
  use {
    'williamboman/nvim-lsp-installer',
    config = function()
      local lsp_installer = require'nvim-lsp-installer'
      local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
      -- Use an on_attach function to only map the following keys 
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Mappings.
        vimp.add_buffer_maps(bufnr, function()
          vimp.nnoremap({'silent'}, 'gD', function() vim.lsp.buf.declaration() end)
          vimp.nnoremap({'silent'}, 'gi', function() vim.lsp.buf.implementation() end)
          vimp.nnoremap({'silent'}, '<leader>D', function() vim.lsp.buf.type_definition() end)

          -- lspsaga
          vimp.nnoremap({'silent'}, 'gh', function() require'lspsaga.provider'.lsp_finder() end)
          vimp.nnoremap({'silent'}, '<leader>ca', function() require'lspsaga.codeaction'.code_action() end)
          vimp.vnoremap({'silent'}, '<leader>ca', function() require'lspsaga.codeaction'.range_code_action() end)
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
        end)

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
  use 'folke/lsp-colors.nvim'
  use 'simrat39/symbols-outline.nvim' 

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
    requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim', 'rmagatti/session-lens'},
    config = function()
      vimp.nnoremap('<leader>ff', function() require('telescope.builtin').find_files() end)
      vimp.nnoremap('<leader>fg', function() require('telescope.builtin').live_grep() end)
      vimp.nnoremap('<leader>fb', function() require('telescope.builtin').buffers() end)
      vimp.nnoremap('<leader>fh', function() require('telescope.builtin').help_tags() end)

      require("telescope").load_extension("session-lens")
    end
  }

  -- Integrations
  use 'editorconfig/editorconfig-vim'
  use {
    'voldikss/vim-floaterm',
    config = function()
      vimp.nnoremap({'silent'}, '<F7>', ':FloatermNew<CR>')
      vimp.tnoremap({'silent'}, '<F7>', '<C-\\><C-n>:FloatermNew<CR>')
      vimp.nnoremap({'silent'}, '<F8>', ':FloatermPrev<CR>')
      vimp.tnoremap({'silent'}, '<F8>', '<C-\\><C-n>:FloatermPrev<CR>')
      vimp.nnoremap({'silent'}, '<F9>', ':FloatermNext<CR>')
      vimp.tnoremap({'silent'}, '<F9>', '<C-\\><C-n>:FloatermNext<CR>')
      vimp.nnoremap({'silent'}, '<F12>', ':FloatermToggle<CR>')
      vimp.tnoremap({'silent'}, '<F12>', '<C-\\><C-n>:FloatermToggle<CR>')
    end
  }
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

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd 'packadd vimpeccable'
