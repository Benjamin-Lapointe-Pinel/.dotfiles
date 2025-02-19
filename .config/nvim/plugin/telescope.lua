--vim.cmd[[hi! link NormalFloat Normal]] -- https://vi.stackexchange.com/a/39079
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ge', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', 'gb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', 'gl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, { desc = 'Telescope LSP document symbols' })

require('telescope').setup {
	defaults = {
		layout_strategy = 'vertical',
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
}
