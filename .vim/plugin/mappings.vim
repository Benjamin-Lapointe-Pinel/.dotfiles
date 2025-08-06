" window navigation
tnoremap <M-h> <C-\><C-N><C-w>h
tnoremap <M-j> <C-\><C-N><C-w>j
tnoremap <M-k> <C-\><C-N><C-w>k
tnoremap <M-l> <C-\><C-N><C-w>l
inoremap <M-h> <C-\><C-N><C-w>h
inoremap <M-j> <C-\><C-N><C-w>j
inoremap <M-k> <C-\><C-N><C-w>k
inoremap <M-l> <C-\><C-N><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
tnoremap <M-left>  <C-\><C-N><C-w>h
tnoremap <M-down>  <C-\><C-N><C-w>j
tnoremap <M-up>    <C-\><C-N><C-w>k
tnoremap <M-right> <C-\><C-N><C-w>l
inoremap <M-left>  <C-\><C-N><C-w>h
inoremap <M-down>  <C-\><C-N><C-w>j
inoremap <M-up>    <C-\><C-N><C-w>k
inoremap <M-right> <C-\><C-N><C-w>l
nnoremap <M-left>  <C-w>h
nnoremap <M-down>  <C-w>j
nnoremap <M-up>    <C-w>k
nnoremap <M-right> <C-w>l
nnoremap <C-w><S-left>  <C-w>H
nnoremap <C-w><S-down>  <C-w>J
nnoremap <C-w><S-up>    <C-w>K
nnoremap <C-w><S-right> <C-w>L
nnoremap <C-w>_ <Cmd>split<CR>
nnoremap <C-w>\| <Cmd>vsplit<CR>
nnoremap <C-w><C-[> <Cmd>vert winc ]<CR>

" wildmenu uses up and down arrows instead (https://vi.stackexchange.com/a/22628)
set wildcharm=<C-Z>
cnoremap <expr> <up> wildmenumode() ? "\<left>" : "\<up>"
cnoremap <expr> <down> wildmenumode() ? "\<right>" : "\<down>"
cnoremap <expr> <left> wildmenumode() ? "\<C-Y>\<left>" : "\<left>"
cnoremap <expr> <right> wildmenumode() ? "\<bs>\<C-Z>" : "\<right>"

" omnicomplete
inoremap <C-space> <c-x><c-o>
inoremap <expr> <tab> pumvisible() ? "\<C-y>" : "\<tab>"

" if your '{' or '}' are not in the first column, and you would like to use [[ and ]] anyway, try these mappings:
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

" terminal
tnoremap <Esc> <C-\><C-n>
nnoremap <C-\> <Cmd>vertical terminal<CR>
tnoremap <C-\> exit<CR>

" jump navigation
command ToggleQuickfix if empty(filter(getwininfo(), 'v:val.quickfix')) | copen | else | cclose | endif
command ToggleLocation if empty(filter(getwininfo(), 'v:val.loclist')) | lopen | else | lclose | endif
nnoremap <C-q> <Cmd>ToggleQuickfix<CR>
nnoremap <C-l> <Cmd>ToggleLocation<CR>
nnoremap ]q <Cmd>cnext<CR>
nnoremap [q <Cmd>cprev<CR>
nnoremap ]Q <Cmd>clast<CR>
nnoremap [Q <Cmd>cfirst<CR>
nnoremap ]l <Cmd>lnext<CR>
nnoremap [l <Cmd>lprev<CR>
nnoremap ]L <Cmd>llast<CR>
nnoremap [L <Cmd>lfirst<CR>
nnoremap <C-[> <C-O>
nnoremap gm <Cmd>marks<CR>:normal! `

" miscellaneous
command BufOnly silent! execute "%bd|e#|bd#"
nnoremap Q gq
nnoremap gb <Cmd>ls<CR>:b 
nnoremap <C-space> <Cmd>set list! list?<CR>
nnoremap <F5> <Cmd>w<CR>:!%:p<CR>
" https://stackoverflow.com/a/1037182
nnoremap <silent> <esc> :noh<return><esc>
" BUG maybe not good idea to remove this
" nnoremap <esc>^[ <esc>^[
