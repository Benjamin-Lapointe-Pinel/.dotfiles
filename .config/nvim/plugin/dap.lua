require("mason-nvim-dap").setup{
	ensure_installed = {
		'javadbg',
		'python'
	},
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
