vim.api.nvim_set_hl(0, "TSDefinition", { ctermbg = 8 })
vim.api.nvim_set_hl(0, "TSDefinitionUsage", { ctermbg = 18 })

require'nvim-treesitter.configs'.setup{
	ensure_installed = {
		'bash',
		'c',
		'cpp',
		'css',
		'groovy',
		'html',
		'java',
		'javascript',
		'json',
		'kotlin',
		'latex',
		'lua',
		'python',
		'typescript',
		'vim',
		'vimdoc',
		'yaml',
	},

	highlight = {
		enable = true
	},

	indent = {
		enable = true
	},

	refactor = {
		highlight_definitions = {
			enable = true,
			clear_on_cursor_move = true,
		},
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			node_incremental = "v",
			node_decremental = "V",
		},
	},

	textobjects = {

		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["ab"] = "@block.outer",
				["ib"] = "@block.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["am"] = "@function.outer",
				["im"] = "@function.inner",
				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
			},
			selection_modes = {
				['@parameter.outer'] = 'v', -- charwise
				['@function.outer'] = 'V',  -- linewise
				['@class.outer'] = '<c-v>', -- blockwise
			},
			include_surrounding_whitespace = false,
		},

		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},

		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = { query = "@class.outer", desc = "Next class start" },
				["]o"] = "@loop.*",
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},

	},
}
