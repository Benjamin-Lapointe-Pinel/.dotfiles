if executable('yq')
	let &l:formatprg='stdin="$(</dev/stdin)" && echo "$stdin" | yq "sort_keys(..)" 2>/dev/null || echo "$stdin"'
endif
