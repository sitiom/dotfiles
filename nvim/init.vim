" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'matze/vim-move'
Plug 'ThePrimeagen/vim-be-good'
Plug 'easymotion/vim-easymotion'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'simnalamburt/vim-mundo'
Plug 'pgdouyon/vim-evanesco'
Plug 'tpope/vim-surround'
Plug 'tomasiser/vim-code-dark'
Plug '/usr/bin/fzf' " Point to right path
Plug 'junegunn/fzf.vim'
Plug 'ptzz/lf.vim'
Plug 'VebbNix/lf-vim'
Plug 'neoclide/coc.nvim'
Plug 'rbgrouleff/bclose.vim'
Plug 'sheerun/vim-polyglot'
Plug 'thisisrandy/vim-outdated-plugins' " Use this fork while https://github.com/semanser/vim-outdated-plugins/pull/16 is not merged yet

" Initialize plugin system
call plug#end()

" airline
let g:airline_powerline_fonts = 1
" smarter tab line
let g:airline#extensions#tabline#enabled = 1

colorscheme codedark
if (has("termguicolors"))
   set termguicolors
endif

" Persistent undo
set undofile
set undodir=~/.vim/undo

set number relativenumber

" Maps
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>
