local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = os.getenv('HOME') .. '/.cache/jdtls/workspace/' .. project_name
local config_dir = os.getenv('HOME') .. '/.cache/jdtls/config'
local lombok_jar = os.getenv('HOME') .. '/.gradle/caches/modules-2/files-2.1/org.projectlombok/lombok/1.18.24/13a394eed5c4f9efb2a6d956e2086f1d81e857d9/lombok-1.18.24.jar'

local config = {
	cmd = {
		'jdtls',
		'-configuration', config_dir,
		'-data', workspace_dir,
		'--jvm-arg=-javaagent:' .. lombok_jar,
	},
	on_attach = on_attach,
}
require('jdtls').start_or_attach(config)

vim.cmd [[ command! -buffer OrganizeImports lua require'jdtls'.organize_imports() ]]
vim.cmd [[ command! -buffer -range ExtractVariable lua require('jdtls').extract_variable(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]
vim.cmd [[ command! -buffer -range ExtractConstant lua require('jdtls').extract_constant(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]
vim.cmd [[ command! -buffer -range ExtractMethod lua require('jdtls').extract_method(true,{range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>) ]]
vim.cmd [[ command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>) ]]
vim.cmd [[ command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config() ]]
vim.cmd [[ command! -buffer JdtJol lua require('jdtls').jol() ]]
vim.cmd [[ command! -buffer JdtBytecode lua require('jdtls').javap() ]]
vim.cmd [[ command! -buffer JdtJshell lua require('jdtls').jshell() ]]
