call plug#begin(stdpath('data') . '/plugged')

" Theme and Appearance
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'matze/vim-move'
Plug 'easymotion/vim-easymotion'

" Interface
Plug 'sheerun/vim-polyglot'
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'neovim/nvim-lspconfig'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'pgdouyon/vim-evanesco'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

" Commands
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-surround'

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
Plug 'rbgrouleff/bclose.vim'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

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
:lua << END
local nvim_lsp = require'lspconfig'
nvim_lsp.vimls.setup{on_attach=require'completion'.on_attach}
nvim_lsp.omnisharp.setup{on_attach=require'completion'.on_attach}
END

" Setup Appearance
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

colorscheme codedark
if (has("termguicolors"))
   set termguicolors
endif

" Persistent undo
set undofile
set undodir=~/.vim/undo

set number relativenumber

" Mappings
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
