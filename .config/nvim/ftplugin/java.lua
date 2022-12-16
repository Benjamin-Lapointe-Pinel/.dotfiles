local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = os.getenv('HOME') .. '/.cache/jdtls/workspace/' .. project_name
local config_dir = os.getenv('HOME') .. '/.cache/jdtls/config'
local lombok_jar = vim.fn.glob(os.getenv('HOME') .. '/.gradle/caches/**/lombok-[0-9]*.*[0-9]*.*[0-9].jar')

local on_attach = function(client, bufnr)
	require('jdtls').setup_dap({ hotcodereplace = 'auto' })
	require('jdtls.dap').setup_dap_main_class_configs()
	on_attach(client, bufnr)
end

local config = {
	cmd = {
		'jdtls',
		'-configuration', config_dir,
		'-data', workspace_dir,
		'--jvm-arg=-javaagent:' .. lombok_jar,
	},
	init_options = {
		bundles = {
			vim.fn.glob(os.getenv('HOME') .. "/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
			vim.fn.glob(os.getenv('HOME') .. "/.config/nvim/dependencies/vscode-java-test/server/*.jar", 1),
		}
	},
	settings = {
		java = {
			format = {
          settings = {
						url = os.getenv('HOME') .. '/.config/nvim/ftplugin/eclipse-java-style.xml',
						profile = 'ProjectCodeStyle',
					}
      }
		}
	},
	on_attach = on_attach,
}
require('jdtls').start_or_attach(config)

vim.cmd [[ command! -buffer JtdOrganizeImports lua require'jdtls'.organize_imports() ]]
vim.cmd [[ command! -buffer -range JdtExtractVariable lua require('jdtls').extract_variable(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]
vim.cmd [[ command! -buffer -range JdtExtractConstant lua require('jdtls').extract_constant(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]
vim.cmd [[ command! -buffer -range JdtExtractMethod lua require('jdtls').extract_method(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>) ]]
vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>) ]]
vim.cmd [[ command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config() ]]
vim.cmd [[ command! -buffer JdtJol lua require('jdtls').jol() ]]
vim.cmd [[ command! -buffer JdtBytecode lua require('jdtls').javap() ]]
vim.cmd [[ command! -buffer JdtJshell lua require('jdtls').jshell() ]]

vim.cmd [[ command! -buffer JdtTestClass lua require('jdtls').test_class() ]]
vim.cmd [[ command! -buffer JdtTestNearestMethod lua require('jdtls').test_nearest_method() ]]
