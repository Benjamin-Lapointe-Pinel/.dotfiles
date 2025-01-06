require("copilot").setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require("CopilotChat").setup({
	highlight_selection = false,
	insert_at_end = true,
	window = {
		layout = 'vertical',
	},
})

vim.keymap.set({'n', 'v'}, '<C-g>', function() require("CopilotChat").toggle() end)
