function! GetQuickfixNumber()
	let quickfix_number = len(getqflist())
	if quickfix_number > 0
		return '%3* Q ' . quickfix_number . ' %*'
	endif
	return ''
endfunction

function! GetFileName()
	let filename = expand("%:~:.")
	if len(filename) == 0
		return ''
	endif
	let filename = filename.'▕'
	if getbufinfo(bufnr('%'))[0].changed
		return '%6* '.filename.'%*'
	else
		return '%1  '.filename.'%*'
	endif
endfunction

function! StatuslineGitBranch()
	if &modifiable
		try
			let l:dir=expand('%:p:h')
			let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
			if !v:shell_error
				return "%2* ".substitute(l:gitrevparse, '\n', '', 'g')." %*"
			endif
		catch
		endtry
	endif
	return " "
endfunction

augroup GetGitBranch
	autocmd!
	autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

set laststatus=2
set statusline=
set statusline+=%{%StatuslineGitBranch()%}
set statusline+=%<%{%GetFileName()%}
set statusline+=%{&readonly?'\ ':''}%{strlen(&ft)?join(['\ \ ',toupper(&ft)],''):''}\ [%{&ff}][%{strlen(&fenc)?&fenc:'none'}][%{&spelllang}]▕
set statusline+=\ %=\ ▕\ %{wordcount().words}\ words\ %5(%l%):%-3(%v%)\ %3(%p%)%%\ 
set statusline+=%{%GetQuickfixNumber()%}
