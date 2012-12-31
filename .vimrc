set term=ansi
set laststatus=2

call pathogen#infect()
call pathogen#helptags()

let g:Powerline_symbols = 'compatible'
let mapleader = ","

filetype on
filetype plugin on
filetype indent on
syntax on

set nocompatible
set ruler
set smartcase
set ignorecase
set autoindent
set expandtab
set smarttab
set showmatch
set hidden
set shiftwidth=3
set softtabstop=3
set hlsearch
set incsearch
set noerrorbells

set encoding=utf-8
set t_Co=256

colorscheme slate

set history=1000
set wildmenu
set wildmode=list:longest


autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e
autocmd! BufWinLeave ?* mkview
autocmd! BufWinEnter ?* silent loadview
noremap <C-B> :!php -l %<CR>

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
inoremap <leader>, <C-x><C-o>
augroup GoAwayPreviewWindow
   autocmd! InsertLeave * wincmd z
augroup end
