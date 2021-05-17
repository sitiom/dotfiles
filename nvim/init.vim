" vim: fdm=marker fml=3
" Plug {{{1
if &compatible
  set nocompatible
endif

function! s:packager_init(packager) abort
  " Self manage
  call a:packager.add('kristijanhusak/vim-packager', { 'type': 'opt' })

  " Theme and Appearance
  call a:packager.add('vim-airline/vim-airline')
  call a:packager.add('tomasiser/vim-code-dark')
  call a:packager.add('ryanoasis/vim-devicons')

  " Enhancements
  call a:packager.add('jeffkreeftmeijer/vim-numbertoggle')
  call a:packager.add('jiangmiao/auto-pairs')
  call a:packager.add('mhinz/vim-signify')
  call a:packager.add('mhinz/vim-startify')
  call a:packager.add('pgdouyon/vim-evanesco')
  call a:packager.add('tyru/caw.vim')
  call a:packager.add('tpope/vim-repeat')
  call a:packager.add('tpope/vim-surround')
  call a:packager.add('tpope/vim-unimpaired')
  call a:packager.add('lukas-reineke/indent-blankline.nvim', {'branch': 'lua'})

  " Undo tree
  call a:packager.add('simnalamburt/vim-mundo')

  " Navigation
  call a:packager.add('psliwka/vim-smoothie')

  " Syntax highlighting
  call a:packager.add('sheerun/vim-polyglot')
  call a:packager.add('VebbNix/lf-vim')

  " LSP & Completions
  call a:packager.add('nvim-lua/completion-nvim')
  call a:packager.add('steelsojka/completion-buffers')
  call a:packager.add('neovim/nvim-lspconfig')
  call a:packager.add('RishabhRD/nvim-lsputils', {'requires': ['RishabhRD/popfix']})

  " Formatting
  call a:packager.add('sbdchd/neoformat')

  " Integrations
  if has('win32')
    call a:packager.add('junegunn/fzf', {'do': { -> fzf#install() }})
  else
    call a:packager.local('usr/bin/fzf')
  endif
  call a:packager.add('editorconfig/editorconfig-vim')
  call a:packager.add('junegunn/fzf.vim')
  call a:packager.add('ptzz/lf.vim')
  call a:packager.add('nanotee/zoxide.vim')
  call a:packager.add('voldikss/vim-floaterm', {'type': 'opt'})
  call a:packager.add('glacambre/firenvim', { 'do':{ _ -> firenvim#install(0) }})

  " Misc
  call a:packager.add('ThePrimeagen/vim-be-good')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))

" Appearance {{{1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let &guifont = "Delugia Nerd Font:" . (!exists('g:started_by_firenvim') ? "h15" : "h10")

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
" Add vim-floaterm after shell is set
packadd vim-floaterm
" Completion & LSP {{{1
if !exists('g:vscode')
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

  lua require("lsp_config")
endif

" Configuration {{{1
set undofile

set notimeout
set number relativenumber
set smartcase ignorecase
set updatetime=100
set mouse=a

let g:lf_replace_netrw = 1
let g:lf_width = 0.9
let g:lf_height = 0.9

let g:neoformat_verbose = 1 " only affects the verbosity of Neoformat
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1

let g:firenvim_config = { 
    \ 'localSettings': {
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }

au TextYankPost * silent! lua vim.highlight.on_yank()

" Mappings {{{1
nnoremap <F5> :MundoToggle<CR>
set pastetoggle=<F2>
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
