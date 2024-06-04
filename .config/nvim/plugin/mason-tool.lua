require('mason-tool-installer').setup {
	ensure_installed = {
		'htmlhint',
		'pylint',
		'texlab',
		'tree-sitter-cli',
		'yamllint',
		'yq',
	},
	run_on_start = true,
	auto_update = true,
}
