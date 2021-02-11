set nocompatible
set hidden
set encoding=UTF-8

set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set smarttab

set textwidth=120
set formatoptions-=tcro
filetype plugin indent on
syntax on
set t_Co=256

set number relativenumber
set showmatch
set showcmd

set wildmenu
set wildignorecase
set wildmode=full

set splitbelow
set splitright

set listchars=tab:\|\ ,trail:~,extends:>,precedes:<

map <C-h>     <C-w>h
map <C-j>     <C-w>j
map <C-k>     <C-w>k
map <C-l>     <C-w>
map <C-left>  <C-w><left>
map <C-down>  <C-w><down>
map <C-up>    <C-w><up>
map <C-right> <C-w><right>

nnoremap gb :ls<CR>:b
nnoremap <C-@> :set list! list?<CR>

autocmd BufNewFile,BufRead *.ino set filetype=arduino
autocmd BufNewFile,BufRead docker-compose.{yaml,yml} set filetype=docker-compose
autocmd BufNewFile,BufRead *.{yaml,yml} set filetype=yaml

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!clear; python %<CR>
autocmd FileType dockerfile nnoremap <buffer> <F5> :w<CR>:!clear; docker build -t build . && docker run --rm -it $(docker build -q .)<CR>
autocmd FileType docker-compose nnoremap <buffer> <F5> :w<CR>:!clear; docker-compose down; docker-compose up -d<CR>
autocmd FileType arduino nnoremap <buffer> <F5> :w<CR>:!clear; arduino -v --upload %<CR>

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

set rtp+=/usr/bin/fzf

" These lines must be at the very end of the vimrc file.
packloadall
silent! helptags ALL
