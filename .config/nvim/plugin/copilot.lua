require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("CopilotChat").setup({
	highlight_selection = false,
	insert_at_end = true,
	window = {
		layout = 'float',
		width = 0.75,
		height = 0.75,
	},
})

vim.keymap.set({'n', 'v'}, '<C-g>', function() require("CopilotChat").toggle() end)
