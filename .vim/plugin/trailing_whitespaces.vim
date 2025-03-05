" highlight trailing whitespaces
let ft_bt_ws_blacklist = ['nofile', 'terminal', 'lspinfo', 'help', 'qf', 'netrw']
autocmd BufWinEnter * let w = matchadd('Error', '\s\+\%#\@<!$', -1) | if index(ft_bt_ws_blacklist, &ft) >= 0 || index(ft_bt_ws_blacklist, &bt) >= 0 | call matchdelete(w) | unlet w | endif

" remove trailing whitespaces
command -range=% RemoveTrailingWhitespaces <line1>,<line2>s/\s\+$//
