require("mason").setup()
require('mason-tool-installer').setup {
	ensure_installed = {
		'angular-language-server',
		'bash-language-server',
		'clangd',
		'gradle-language-server',
		'jdtls',
		--'js-debug-adapter',
		'node-debug2-adapter',
		'python-lsp-server',
		'rust-analyzer',
		'texlab',
		'typescript-language-server',
		'yaml-language-server',
	},
	run_on_start = true,
	auto_update = true,
}
