local fzf_lua = require("fzf-lua")

local send_to_qf_ll = {
	["ctrl-q"] = {
		prefix = "select-all+",
		fn = fzf_lua.actions.file_sel_to_qf,
	},
	["ctrl-l"] = {
		prefix = "select-all+",
		fn = fzf_lua.actions.file_sel_to_ll,
	}
}

fzf_lua.setup({
	winopts = {
		border = 'single',
		preview = {
			border = 'single',
			layout = 'vertical'
		},
	},
	lsp = {
		symbols = {
			symbol_style = 3
		}
	},
	diagnostics ={
		multiline = 1
	},
	grep = { actions = send_to_qf_ll },
	files = { actions = send_to_qf_ll },
})

vim.keymap.set('n', 'gl', fzf_lua.live_grep, { desc = 'live grep' })
vim.keymap.set('n', 'gf', fzf_lua.global, { desc = 'global find' })
vim.keymap.set('n', 'ge', fzf_lua.files, { desc = 'find file' })
vim.keymap.set('n', 'gb', fzf_lua.buffers, { desc = 'find buffer' })
vim.keymap.set('n', 'gj', fzf_lua.jumps, { desc = 'find jump' })
vim.keymap.set('n', 'gm', fzf_lua.marks, { desc = 'find mark' })
vim.keymap.set('n', 'gh', fzf_lua.helptags, { desc = 'find help tag' })
vim.keymap.set('n', 'z=', fzf_lua.spell_suggest, { desc = 'spell suggestions' })
vim.keymap.set('n', '<M-q>', fzf_lua.quickfix, { desc = 'find quick fix' })
vim.keymap.set('n', '<M-l>', fzf_lua.loclist, { desc = 'find location' })

-- lsp
require('fzf-lua').register_ui_select()
vim.keymap.set('n', 'gd', fzf_lua.lsp_declarations, { desc = 'find declaration' })
vim.keymap.set('n', 'grr', fzf_lua.lsp_references, { desc = 'find reference' })
vim.keymap.set('n', 'gri', fzf_lua.lsp_implementations, { desc = 'find implementation' })
vim.keymap.set('n', 'gO', fzf_lua.lsp_document_symbols, { desc = 'find in document symbols' })
