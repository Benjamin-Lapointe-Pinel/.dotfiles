vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermbg=18, ctermfg=14 })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermbg=18, ctermfg=12 })
vim.api.nvim_set_hl(0, "DiagnosticSignOk", { ctermbg=18, ctermfg=10 })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermbg=18, ctermfg=11 })
vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermbg=18, ctermfg=9 })

require('lspconfig.ui.windows').default_options.border = 'single'
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
vim.diagnostic.config { float = { border = "single" } }

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

	vim.keymap.set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	vim.keymap.set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	vim.keymap.set('n', '<leader>e ', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
	vim.keymap.set('n', '<leader>q ', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

require("mason").setup{
	ui = {
		border = 'single'
	},
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
		["jdtls"] = function () -- will be redefined in ftplugin/java
			-- FIXME
			-- org.eclipse.jdt.core.compil.codegen.methodParameters=generate
			-- this settings needs to be in .settings/org.eclipse.jdt.core.prefs of some buggy spring projects past 6.1
			-- see https://github.com/spring-projects/spring-framework/wiki/Upgrading-to-Spring-Framework-6.x#parameter-name-retention
		end,
	}
}

-- better typescript lsp
require("typescript-tools").setup {
	on_attach = on_attach,
	capabilities = capabilities,
}
