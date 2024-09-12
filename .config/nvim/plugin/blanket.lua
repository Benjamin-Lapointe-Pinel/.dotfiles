local blanket = require('blanket')
blanket.setup{
	report_path = vim.fn.getcwd().."/build/reports/jacoco/test/jacocoTestReport.xml",
	filetypes = "java",

	signs = {
		incomplete_branch = "█",
		uncovered = "█",
		covered = "█",
		sign_group = "Blanket",

		covered_color = "DiagnosticSignOk",
		incomplete_branch_color = "DiagnosticSignWarn",
		uncovered_color = "DiagnosticSignError",
	},
}

blanket.stop()
local test_coverage = false
local function toggle_test_coverage()
	if test_coverage then
		blanket.stop()
		test_coverage = false
	else
		blanket.start()
		test_coverage = true
	end
end

vim.api.nvim_create_user_command("JavaTestCoverageStart", blanket.start, {})
vim.api.nvim_create_user_command("JavaTestCoverageStop", blanket.stop, {})
vim.api.nvim_create_user_command("JavaTestCoverageToggle", toggle_test_coverage, {})
