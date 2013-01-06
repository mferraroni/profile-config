set term=ansi
set laststatus=2

call pathogen#infect()
call pathogen#helptags()

let g:Powerline_symbols = 'compatible'
let mapleader = ","

"let g:user_zen_leader_key = '<C-y>'

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


autocmd! BufWinLeave ?* mkview
autocmd! BufWinEnter ?* silent loadview
noremap <C-B> :!php -l %<CR>

"Windows maps
  map <leader>. 10<c-w><
  map <leader>/ 10<c-w>>
  map <leader>= <c-w>=
  map <leader>- <c-w>\|
  map <leader>, <c-w><c-w>
  map <leader>v <c-w><c-v>
  map <leader>o :only<CR>
  map <leader>h <c-w>s

"Pageup and pagedown
  map <leader><Down> <C-d>
  map <leader><Up> <C-u>

function! ViewHtmlText(url)
   if !empty(a:url)
        vnew
         setlocal buftype=nofile bufhidden=hide noswapfile
        execute 'r !elinks ' . a:url . ' -dump -dump-width ' . winwidth(0)
        1d
  endif
endfunction  

nnoremap <Leader>H :call ViewHtmlText('')
nnoremap <Leader>p byw:call ViewHtmlText('http://jp2.php.net/' . @@)<CR>

"Zen coding shortcuts
imap <Leader><Tab> <C-y>,
map <Leader><Tab> <C-y>,

imap <Tab> <c-r>=TriggerSnippet()<cr> 
