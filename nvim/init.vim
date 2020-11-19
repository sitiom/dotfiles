call plug#begin(stdpath('data') . '/plugged')

" Theme and Appearance
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'easymotion/vim-easymotion'

" Interface
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'neovim/nvim-lspconfig'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'pgdouyon/vim-evanesco'
Plug 'jiangmiao/auto-pairs'

" Commands
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Integrations
if has('win32')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
else
	Plug 'usr/bin/fzf'
endif
Plug 'junegunn/fzf.vim'
Plug 'ptzz/lf.vim'
Plug 'VebbNix/lf-vim'

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
local nvim_lsp = require'lspconfig'

-- Utility servers
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
	map('n','<leader>af', '<cmd>lua vim.lsp.buf.code_action()<CR>')
	map('n','<leader>ar',  '<cmd>lua vim.lsp.buf.rename()<CR>')
	-- Few language severs support these three
	map('n','<leader>=',  '<cmd>lua vim.lsp.buf.formatting()<CR>')
	map('n','<leader>ai',  '<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
	map('n','<leader>ao',  '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
	-- Diagnostics mapping
	map('n','<leader>ee', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	map('n','<leader>en', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
	map('n','<leader>ep', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
end

nvim_lsp.vimls.setup{on_attach=on_attach_common}
nvim_lsp.omnisharp.setup{on_attach=on_attach_common}
EOF

" Persistent undo
set undofile
set undodir=~/.vim/undo

set number relativenumber
set smartcase ignorecase
let g:lf_replace_netrw = 1

" Mappings
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>
