require('mason-tool-installer').setup {
	ensure_installed = {
		'debugpy',
		'eslint',
		'htmlhint',
		'java-debug-adapter',
		'java-test',
		'js-debug-adapter',
		'pylint',
		'texlab',
		'tree-sitter-cli',
		'yamllint',
		'yq',
	},
	run_on_start = true,
	auto_update = true,
}
