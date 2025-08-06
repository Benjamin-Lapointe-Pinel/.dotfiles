vim.fn.sign_define('DapBreakpoint', { numhl='User1' })
vim.fn.sign_define('DapBreakpointCondition', { numhl='User3' })
vim.fn.sign_define('DapLogPoint', { numhl='User4' })
vim.fn.sign_define('DapBreakpointRejected')
vim.api.nvim_set_hl(0, "DapUIVariable", { ctermfg=4 })
vim.api.nvim_set_hl(0, "DapUIType", { link="Type" })

require("mason-nvim-dap").setup {
	ensure_installed = {
		'bash',
	},
	handlers = {},
	automatic_installation = true,
}

require('dap-python').setup('/usr/bin/python')

local dapui = require("dapui")
vim.fn.sign_define('DapStopped', {text='>'})
dapui.setup({
	icons = { collapsed = " ", expanded = " " },
	layouts = {
		{
			elements = {
				"console",
			},
			size = 0.25,
			position = "bottom",
		},
		{
			elements = {
				"watches",
				{ id = "scopes", size = 0.5 },
			},
			size = 64,
			position = "right",
		},
	},
	controls = {
		enabled = true,
		element = "repl",
		icons = {
			pause = "PAUSE",
			play = "PLAY",
			step_into = "STEP_INTO",
			step_over = "STEP_OVER",
			step_out = "STEP_OUT",
			step_back = "STEP_BACK",
			run_last = "RUN_LAST",
			terminate = "TERMINATE",
		},
	},
})

local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<F5>',  dap.continue, opts)
vim.keymap.set('n', '<F29>', dap.run_last, opts)
vim.keymap.set('n', '<F6>',  dap.step_over, opts)
vim.keymap.set('n', '<F7>',  dap.step_into, opts)
vim.keymap.set('n', '<F8>',  dap.step_out, opts)
vim.keymap.set('n', '<F9>',  dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<F10>', dapui.eval, opts)
vim.keymap.set('n', '<F30>', function() dap.list_breakpoints(); vim.cmd.copen() end, opts)
vim.keymap.set('n', '<F33>', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, opts)
vim.keymap.set('n', '<F12>', ':DapTerminate<CR><Cmd>lua require("dapui").close()<CR>', opts)

vim.cmd [[ command! DapListBreakpoints lua require'dap'.list_breakpoints(); vim.cmd('copen'); ]]
vim.cmd [[ command! DapClearBreakpoints lua require'dap'.clear_breakpoints() ]]
vim.cmd [[ command! DapRepl lua require'dap'.repl.toggle() ]]
vim.cmd [[ command! DapUiToggle lua require("dapui").toggle() ]]
vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
vim.cmd [[ command! -range=% Format lua vim.lsp.buf.format({range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

-- vscode javascript debug adapter

require("dap-vscode-js").setup({
  debugger_path = os.getenv('HOME') .. "/.config/nvim/dependencies/vscode-js-debug",
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

for _, language in ipairs({ "typescript", "javascript" }) do
	require("dap").configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require'dap.utils'.pick_process,
			cwd = "${workspaceFolder}",
		}
	}
end

-- require("dap").adapters["pwa-node"] = {
--   type = "server",
--   host = "localhost",
--   port = "${port}",
--   executable = {
--     command = "node",
--     args = {os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"},
--   }
-- }

-- require("dap").configurations.javascript = {
--   {
--     type = "pwa-node",
--     request = "launch",
--     name = "Launch file",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
-- 		outFiles = {
-- 			"${workspaceFolder}/**/*.(m|c|)js",
-- 			"!**/node_modules/**"
-- 		},
--   },
-- }

-- require("dap").configurations.typescript = {
--   {
--     type = "pwa-node",
--     request = "launch",
--     name = "Launch file",
--     program = "${file}",
--     cwd = "${workspaceFolder}",
-- 		outFiles = {
-- 			"${workspaceFolder}/**/*.(m|c|)js",
-- 			"!**/node_modules/**"
-- 		},
--   },
-- }
