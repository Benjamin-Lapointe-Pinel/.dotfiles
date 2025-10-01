require('satellite').setup({
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
