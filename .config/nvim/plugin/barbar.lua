vim.cmd[[highlight BufferCurrentSignRight ctermbg=white ctermfg=black]]
vim.cmd[[highlight BufferInactiveSignRight ctermbg=gray ctermfg=black]]
vim.cmd[[highlight BufferCurrentMod cterm=bold ctermbg=white ctermfg=blue]]
vim.cmd[[highlight BufferInactiveMod ctermbg=gray ctermfg=blue]]
vim.g.barbar_auto_setup = false
require('barbar').setup{
	animation = false,
	icons = {
		button = '',
		modified = {button = ''},
		pinned = {button = '+'},
		separator = {left = '', right = '▕'},
		gitsigns = {
			enabled = true,
			added = {enabled = true, icon = '+'},
			changed = {enabled = true, icon = '~'},
			deleted = {enabled = true, icon = '-'},
		},
		filetype = {
			enabled = false,
		},
		inactive = {separator = {left = '', right = '▕'}},
	},
	exclude_ft = {'qf', 'dapui_watches'},
}
