--vim.cmd[[hi! link NormalFloat Normal]] -- https://vi.stackexchange.com/a/39079
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ge', builtin.find_files, {})
vim.keymap.set('n', 'gb', builtin.buffers, {})


require('telescope').setup {
	defaults = {
		layout_strategy = 'vertical',
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
}
