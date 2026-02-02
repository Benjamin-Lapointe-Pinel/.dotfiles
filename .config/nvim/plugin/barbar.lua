vim.cmd[[highlight TabLineFill cterm=NONE gui=NONE ctermbg=19]]
vim.cmd[[highlight BufferCurrent ctermbg=lightgray ctermfg=black]]
vim.cmd[[highlight link BufferCurrentSign BufferCurrent]]
vim.cmd[[highlight BufferInactive ctermbg=darkgray ctermfg=lightgray]]
vim.cmd[[highlight link BufferInactiveSign BufferInactive]]
vim.cmd[[highlight BufferCurrentMod ctermbg=lightgray ctermfg=cyan]]
vim.cmd[[highlight BufferInactiveMod ctermbg=darkgray ctermfg=cyan]]
vim.g.barbar_auto_setup = false
require('barbar').setup{
	animation = false,
	focus_on_close = 'previous',
	icons = {
		button = '',
		modified = {button = ''},
		pinned = {button = '+'},
		separator = {left = '', right = '▕'},
		gitsigns = {
			added = {enabled = false, icon = '+'},
			changed = {enabled = false, icon = '~'},
			deleted = {enabled = false, icon = '-'},
		},
		filetype = {
			enabled = false,
		},
		inactive = {separator = {left = '', right = '▕'}},
	},
	exclude_ft = {'qf', 'dapui_watches'},
}
