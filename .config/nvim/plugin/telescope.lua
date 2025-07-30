local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ge', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', 'gb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', 'gl', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', 'gs', function() builtin.lsp_document_symbols({symbol_width=0.5}) end, { desc = 'Telescope LSP document symbols' })

require('telescope').setup {
	defaults = {
		layout_strategy = 'vertical',
		-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
	extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  },
}

require("telescope").load_extension("ui-select")

-- HACK: https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2756267300
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopeFindPre",
  callback = function()
    vim.opt_local.winborder = "none"
    vim.api.nvim_create_autocmd("WinLeave", {
      once = true,
      callback = function()
        vim.opt_local.winborder = "single"
      end,
    })
  end,
})

-- HACK: https://github.com/nvim-telescope/telescope.nvim/issues/2766#issuecomment-1848930714
vim.api.nvim_create_autocmd("WinLeave", {
	callback = function()
		if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
		end
	end,
})
