set nocompatible
set hidden
set encoding=UTF-8

set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set smarttab

set textwidth=120
set formatoptions-=tc
filetype plugin indent on
syntax on
set t_Co=256

set number relativenumber
set showmatch
set showcmd

set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-m> :NERDTreeFind<CR>
nnoremap <C-@> :set list! list?<CR>

autocmd BufNewFile,BufRead *.ino set filetype=arduino

autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!clear;python %<CR>
autocmd FileType dockerfile nnoremap <F5> :w<CR>:!clear;docker build -t build .;docker run --rm -it $(docker build -q .)<CR>
autocmd FileType arduino nnoremap <buffer> <F5> :w<CR>:!clear;arduino -v --upload %<CR>

set conceallevel=3

let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set rtp+=/usr/bin/fzf
