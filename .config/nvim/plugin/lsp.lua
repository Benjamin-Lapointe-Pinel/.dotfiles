vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermbg=18, ctermfg=14 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermbg=18, ctermfg=12 })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermbg=18, ctermfg=10 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermbg=18, ctermfg=11 })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermbg=18, ctermfg=9 })

require('lspconfig.ui.windows').default_options.border = 'single'
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
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
	vim.keymap.set('n', '<F12>', ':DapTerminate<CR><Cmd>lua require("dapui").close()<CR>', opts)

	vim.keymap.set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.keymap.set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.keymap.set('n', '<leader>e ', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.keymap.set('n', '<leader>q ', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)

	vim.cmd [[ command! DapListBreakpoints lua require'dap'.list_breakpoints(); vim.cmd('copen'); ]]
	vim.cmd [[ command! DapClearBreakpoints lua require'dap'.clear_breakpoints() ]]
	vim.cmd [[ command! DapRepl lua require'dap'.repl.toggle() ]]
	vim.cmd [[ command! DapUiToggle lua require("dapui").toggle() ]]
	vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
	vim.cmd [[ command! -range=% Format lua vim.lsp.buf.format({range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]
end

require("mason").setup{
	ui = {
		border = 'single'
	},
	registries = {
		'github:nvim-java/mason-registry',
		'github:mason-org/mason-registry',
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
require("mason-lspconfig").setup {
	ensure_installed = {
		'angularls',
		'bashls',
		'clangd',
		'cssls',
		'gradle_ls',
		'html',
		'jdtls',
		'jsonls',
		'terraformls',
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
				capabilities = capabilities,
				on_attach = on_attach,
			}
		end,
		["yamlls"] = function ()
			require("lspconfig")["yamlls"].setup {
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					vim.bo[bufnr].formatexpr = '' -- using formatprg instead (see yaml ftplugin file)
				end,
			}
		end,
		["jdtls"] = function ()
			require('java').setup()
			-- FIXME
			-- org.eclipse.jdt.core.compil.codegen.methodParameters=generate
			-- this settings needs to be in .settings/org.eclipse.jdt.core.prefs of some buggy spring projects past 6.1
			-- see https://github.com/spring-projects/spring-framework/wiki/Upgrading-to-Spring-Framework-6.x#parameter-name-retention
			require("lspconfig")["jdtls"].setup {
				capabilities = capabilities,
				on_attach = on_attach,
			}
			-- HACK
			-- I use nvim-jdtls at the same time as nvim-java, even though I shouldn't.
			-- nvim-jdtls handling of test is just so much better
			vim.cmd [[ command! -buffer JavaTestClass lua require('jdtls').test_class() ]]
			vim.cmd [[ command! -buffer JavaTestNearestMethod lua require('jdtls').test_nearest_method() ]]
		end,
	}
}

-- better typescript lsp
require("typescript-tools").setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
