call plug#begin(stdpath('data') . '/plugged')

" Theme and Appearance
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Navigation
Plug 'easymotion/vim-easymotion'

" Interface
Plug 'mhinz/vim-startify'
Plug 'psliwka/vim-smoothie'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'pgdouyon/vim-evanesco'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-signify'
Plug 'editorconfig/editorconfig-vim'

" Commands
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'sbdchd/neoformat'

" Integrations
if has('win32')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
else
	Plug 'usr/bin/fzf'
endif
Plug 'junegunn/fzf.vim'
Plug 'ptzz/lf.vim'
Plug 'VebbNix/lf-vim'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

" Background
Plug 'thisisrandy/vim-outdated-plugins' " Use this fork while https://github.com/semanser/vim-outdated-plugins/pull/16 is not merged yet

" Dependencies and Misc
Plug 'tpope/vim-repeat'
Plug 'rbgrouleff/bclose.vim'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Setup Appearance
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set guifont=CaskaydiaCove\ NF:h15

colorscheme codedark
if (has("termguicolors"))
 	set termguicolors
endif

" Set Powershell as shell in Windows
if has('win32')
		set shell=pwsh shellquote= shellpipe=\| shellxquote=
		set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
		set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif

" Completion options
autocmd BufEnter * lua require'completion'.on_attach()
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c

let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippets']},
		\{'complete_items': ['buffer']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\] 
let g:completion_auto_change_source = 1

" Setup LSP
:lua << EOF
local lsp = require'lspconfig'

local map = function(type, key, value)
	vim.fn.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local on_attach_common = function(_)
	print("LSP started.");

	-- GOTO mappings
	map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
	map('n','<leader>gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
	map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
	map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

	-- ACTION mappings
	map('n','<leader>ah',  '<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n','<leader>ee', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
	map('n','<leader>ar',  '<cmd>lua vim.lsp.buf.rename()<CR>')

	-- Few language severs support these three
	map('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	map('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

end

lsp.vimls.setup{on_attach=on_attach_common}
lsp.omnisharp.setup{on_attach=on_attach_common}

local border_chars = {
	TOP_LEFT = '┌',
	TOP_RIGHT = '┐',
	MID_HORIZONTAL = '─',
	MID_VERTICAL = '│',
	BOTTOM_LEFT = '└',
	BOTTOM_RIGHT = '┘',
}
vim.g.lsp_utils_location_opts = {
	height = 24,
	mode = 'split',
	list = {
		border = true,
		numbering = true
	},
	preview = {
		title = 'Location Preview',
		border = true,
		border_chars = border_chars
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k',
		}
	}
}
vim.g.lsp_utils_symbols_opts = {
	height = 24,
	mode = 'editor',
	list = {
		border = true,
	},
	preview = {
		title = 'Symbols Preview',
		border = true,
		border_chars = border_chars
	},
	keymaps = {
		n = {
			['<C-n>'] = 'j',
			['<C-p>'] = 'k',
		}
	}
}

vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF

" Persistent undo
set undofile
set undodir=~/.vim/undo

set notimeout
set number relativenumber
set smartcase ignorecase
set updatetime=100

let g:lf_replace_netrw = 1
" Fix lf causing problems on Scoop ps1 shim
if has('win32')
	let g:lf_command_override = 'lf.exe'
endif

" Mappings
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>
