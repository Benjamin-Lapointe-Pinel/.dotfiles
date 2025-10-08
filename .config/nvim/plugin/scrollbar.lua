require('satellite').setup({
	current_only = true,
	handlers = {
		cursor = {
			symbols = { '▔', '━' ,'▁' }
		},
		search = {
			symbols = { '─', '╌', '┄', '┈' }
		},
		marks = {
			show_builtins = true
		}
	}
})
