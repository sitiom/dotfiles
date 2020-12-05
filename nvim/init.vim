" vim: fdm=marker fml=3

" Plug {{{1
call plug#begin(stdpath('data') . '/plugged')

" Theme and Appearance
Plug 'vim-airline/vim-airline'
Plug 'tomasiser/vim-code-dark'
Plug 'ryanoasis/vim-devicons'

" Enhancements
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'jiangmiao/auto-pairs'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'pgdouyon/vim-evanesco'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Undo tree
Plug 'simnalamburt/vim-mundo'

" Navigation
Plug 'easymotion/vim-easymotion'
Plug 'psliwka/vim-smoothie'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'VebbNix/lf-vim'

" LSP & Completions
Plug 'nvim-lua/completion-nvim'
Plug 'steelsojka/completion-buffers'
Plug 'neovim/nvim-lspconfig'
Plug 'RishabhRD/nvim-lsputils'
Plug 'RishabhRD/popfix'

" Formatting
Plug 'sbdchd/neoformat'

" Integrations
if has('win32')
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
else
	Plug 'usr/bin/fzf'
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim'
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'sitiom/lf.vim', { 'branch': 'floaterm' } " lf.vim should be loaded before vim-floaterm to override vim-floaterm's lf wrapper
Plug 'voldikss/vim-floaterm'

" Background
Plug 'thisisrandy/vim-outdated-plugins' " Use this fork while https://github.com/semanser/vim-outdated-plugins/pull/16 is not merged yet

" Dependencies and Misc
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Appearance {{{1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set guifont=CaskaydiaCove\ NF:h15

colorscheme codedark
if (has("termguicolors"))
	set termguicolors
endif

" Shell {{{1
if has('win32')
	set shell=pwsh shellquote= shellpipe=\| shellxquote=
	set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
	set shellredir=\|\ Out-File\ -Encoding\ UTF8
endif

" Completion {{{1
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

" LSP {{{1
lua require("lsp_config")

" Configuration {{{1
set undofile
set undodir=~/.vim/undo

set notimeout
set number relativenumber
set smartcase ignorecase
set updatetime=100

let g:lf_replace_netrw = 1

let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
" Mappings {{{1
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
