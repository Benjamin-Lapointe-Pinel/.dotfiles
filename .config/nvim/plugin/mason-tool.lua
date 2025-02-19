require('mason-tool-installer').setup {
	ensure_installed = {
		'debugpy',
		'htmlhint',
		'java-debug-adapter',
		'pylint',
		'texlab',
		'tree-sitter-cli',
		'yamllint',
		'yq',
	},
	run_on_start = true,
	auto_update = true,
}
