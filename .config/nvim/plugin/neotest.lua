local neotest = require("neotest")
neotest.setup({

	adapters = {
		require("neotest-java")({
			incremental_build = false
		}),
	},

	floating = {
		border = "single"
	},

	summary = {
		open = "botright vsplit | vertical resize 64"
	},

	icons = {
		child_indent = "│",
		child_prefix = "├",
		collapsed = "─",
		expanded = "┬",
		failed = "F",
		final_child_indent = " ",
		final_child_prefix = "└",
		non_collapsible = "─",
		notify = "N",
		passed = "P",
		running = "R",
		running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
		skipped = "S",
		unknown = "U",
		watching = "W"
	},

})

vim.api.nvim_create_user_command(
	"NeotestRunAll",
	function ()
		neotest.summary.open()
		neotest.run.run(vim.fn.getcwd())
	end, {})
