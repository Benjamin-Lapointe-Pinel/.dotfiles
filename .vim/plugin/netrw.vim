let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_fastbrowse=2
let g:netrw_localcopydircmd='cp -r'
autocmd BufNewFile,BufRead * let b:NetrwHasOpen=0
function! ToggleNetrw()
	if b:NetrwHasOpen
		:Rexplore
	else
		:Explore
		let b:NetrwHasOpen=1
	endif
endfunction
nnoremap <silent> <C-e> :call ToggleNetrw()<CR>
autocmd FileType netrw nnoremap <buffer> <C-c> :Rexplore<CR>
autocmd FileType netrw nnoremap <buffer> <escape> :Rexplore<CR>
autocmd FileType netrw setlocal bufhidden=wipe
autocmd FileType netrw setlocal statusline=\ 
