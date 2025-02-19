require("mason").setup{ ui = { border = 'single' } }
require('lspconfig.ui.windows').default_options.border = 'single'
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
vim.diagnostic.config { float = { border = "single" } }

on_attach = function()
	local opts = { noremap=true }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
end

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
				on_attach = function(bufnr)
					on_attach()
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
