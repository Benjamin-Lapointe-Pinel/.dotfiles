on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.keymap.set('n', '<A-enter>', '<cmd>lua vim.lsp.buf.code_action({apply=true})<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

	vim.keymap.set('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
	vim.keymap.set('n', '<F29>', "<Cmd>lua require'dap'.run_last()<CR>", opts)
	vim.keymap.set('n', '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
	vim.keymap.set('n', '<F7>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
	vim.keymap.set('n', '<F8>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
	vim.keymap.set('n', '<F9>', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
	vim.keymap.set('n', '<F33>', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
	vim.keymap.set('n', '<F10>', '<Cmd>lua require("dapui").eval()<CR>', opts)
	--vim.keymap.set('n', '<F10>', "<Cmd>lua require('dap.ui.widgets').hover()<CR>", opts)
	vim.keymap.set('n', '<F12>', ':DapTerminate<CR><Cmd>lua require("dapui").close()<CR>', opts)

	vim.cmd [[ command! DapClearBreakpoints lua require'dap'.clear_breakpoints() ]]
	vim.cmd [[ command! DapRepl lua require'dap'.repl.toggle() ]]
	vim.cmd [[ command! DapUiToggle lua require("dapui").toggle() ]]
	vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
	vim.cmd [[ command! -range=% Format lua vim.lsp.buf.format({range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

	vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr()'
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
require("mason").setup()
require("mason-lspconfig").setup {
	ensure_installed = {
		'angularls',
		'bashls',
		'clangd',
		'cssls',
		'gradle_ls',
		'html',
		'jdtls',
		'lua_ls',
		'pylsp',
		'rust_analyzer',
		'vimls',
		'yamlls',
	},
	automatic_installation = true,
	handlers = {
		function (server_name)
			require("lspconfig")[server_name].setup {
				on_attach = on_attach,
				capabilities = capabilities,
			}
		end,
		["jdtls"] = function ()
			-- will be redefined in ftplugin/java
		end,
	}
}

require('mason-tool-installer').setup {
	ensure_installed = {
		'htmlhint',
		'pylint',
		'texlab',
	},
	run_on_start = true,
	auto_update = true,
}

-- better typescript lsp
require("typescript-tools").setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
