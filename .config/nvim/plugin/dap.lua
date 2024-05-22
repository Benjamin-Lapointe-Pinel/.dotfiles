require("mason-nvim-dap").setup {
	ensure_installed = {
		'bash',
	},
	handlers = {},
	automatic_installation = true,
}

require('dap-python').setup('/usr/bin/python')

require("nvim-dap-virtual-text").setup()

local dap, dapui = require("dap"), require("dapui")
vim.fn.sign_define('DapStopped', {text='>'})
dapui.setup({
	icons = { collapsed = ">", expanded = "-" },
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
			size = 40,
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

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

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
