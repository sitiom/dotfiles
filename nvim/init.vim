" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/vimfiles/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'matze/vim-move'
Plug 'hugolgst/vimsence'
" Plug 'ThePrimeagen/vim-be-good' " v0.5.0 only
Plug 'easymotion/vim-easymotion'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'simnalamburt/vim-mundo'
Plug 'pgdouyon/vim-evanesco'
Plug 'tpope/vim-surround'
Plug 'tomasiser/vim-code-dark'
Plug '/usr/bin/fzf' " Point to right path
Plug 'junegunn/fzf.vim'

" Initialize plugin system
call plug#end()

" airline
let g:airline_powerline_fonts = 1
" smarter tab line
let g:airline#extensions#tabline#enabled = 1

"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
   "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

colorscheme codedark

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

set number relativenumber
set tabstop=4 shiftwidth=4 expandtab

nnoremap <F5> :MundoToggle<CR>
