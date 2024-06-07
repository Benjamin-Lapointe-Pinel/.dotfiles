vim.api.nvim_create_user_command('Diagnostic',
	function(opts)
		if opts.args == 'error' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
		elseif opts.args == 'warning' then
			vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARNING })
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

function SetQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
	vim.cmd[[ :ToggleQuickfix ]]
end

function SetErrorsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end

function SetWarningsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARNING })
end

function SetInfosQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
end

function SetHintsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
	vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
end

function LspStatusError()
	local error_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.ERROR })
	if error_number > 0 then
		return '%1* E '..error_number..' %*'
	end
	return ''
end

function LspStatusWarning()
	local warning_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.WARNING })
	if warning_number > 0 then
		return '%8* W '..warning_number..' %*'
	end
	return ''
end

function LspStatusInfo()
	local info_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.INFO })
	if info_number > 0 then
		return '%4* I '..info_number..' %*'
	end
	return ''
end

function LspStatusHint()
	local hint_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.HINT })
	if hint_number > 0 then
		return '%6* H '..hint_number..' %*'
	end
	return ''
end

vim.opt.laststatus = 3
vim.opt.statusline = vim.opt.statusline:get():gsub('%%%{%%GetQuickfixNumber%(%)%%%}','%%@v:lua.SetQuickfixList@%%{%%GetQuickfixNumber()%%}%%T')
vim.opt.statusline:append('%@v:lua.SetWarningsQuickfixList@%{%v:lua.LspStatusWarning()%}%T')
vim.opt.statusline:append('%@v:lua.SetErrorsQuickfixList@%{%v:lua.LspStatusError()%}%T')
vim.opt.statusline:append('%@v:lua.SetInfosQuickfixList@%{%v:lua.LspStatusInfo()%}%T')
vim.opt.statusline:append('%@v:lua.SetHintsQuickfixList@%{%v:lua.LspStatusHint()%}%T')
