require("mason").setup{ ui = { border = 'single' } }

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
	automatic_enable = {
		exclude = {
			"jdtls",
		},
	},
}

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local opts = { noremap = true }
		vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, opts)
		vim.keymap.set('i', '<c-space>', vim.lsp.completion.get, opts)
	end,
})
