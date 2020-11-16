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
Plug 'neovim/nvim-lspconfig'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'pgdouyon/vim-evanesco'

" Commands
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-surround'

" Integrations
Plug '/usr/bin/fzf' " Point to right path
Plug 'junegunn/fzf.vim'
Plug 'ptzz/lf.vim'
Plug 'VebbNix/lf-vim'

" Background
Plug 'thisisrandy/vim-outdated-plugins' " Use this fork while https://github.com/semanser/vim-outdated-plugins/pull/16 is not merged yet

" Dependencies and Misc
Plug 'rbgrouleff/bclose.vim'
Plug 'ThePrimeagen/vim-be-good'

call plug#end()

" Completion options
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
set shortmess+=c

" Setup LSP
:lua << END
local nvim_lsp = require'nvim_lsp'
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
imap <silent> <c-Space> <Plug>(completion_trigger)
