require("mason").setup{ ui = { border = 'single' } }
-- require('lspconfig.ui.windows').default_options.border = 'single'
vim.o.winborder = 'single'

on_attach = function()
	local opts = { noremap=true }
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('i', '<c-space>', vim.lsp.completion.get, opts)
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
