vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermbg=18, ctermfg=14 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermbg=18, ctermfg=12 })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermbg=18, ctermfg=10 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermbg=18, ctermfg=11 })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermbg=18, ctermfg=9 })

vim.diagnostic.config({ virtual_text = true })

vim.api.nvim_create_user_command('Diagnostic',
	function(opts)
		if opts.args == 'error' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
		elseif opts.args == 'warning' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARN })
		elseif opts.args == 'info' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
		elseif opts.args == 'hint' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
		else
			vim.diagnostic.setqflist()
		end
	end,
	{
		nargs = '?',
		complete = function(ArgLead, CmdLine, CursorPos)
			args = { 'all', 'error', 'warning', 'info', 'hint' }
			return vim.fn.filter(args, 'v:val =~ "^'..ArgLead..'"')
		end,
		desc = 'Set diagnostic errors to quickfix list'
	}
)

