set runtimepath^=$HOME/.vim
set runtimepath+=$HOME/.vim/after
set runtimepath+=$HOME/.vim/spell
let &packpath = &runtimepath
source $HOME/.vim/vimrc

" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC | quit
\| endif

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'neovim/nvim-lspconfig'
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rcarriga/nvim-dap-ui'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jayp0521/mason-nvim-dap.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'f3fora/cmp-spell'
Plug 'mfussenegger/nvim-jdtls'
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}
call plug#end()

command! -range Range lua print(<line1>,<line2>)

lua << EOF

require("toggleterm").setup{
	open_mapping = [[<c-\>]],
	direction = 'vertical',
	size = 120
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
function lazygit_toggle()
	lazygit:toggle()
end
vim.cmd[[ command! LazyGit execute 'lua lazygit_toggle()' ]]

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	vim.keymap.set('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	vim.keymap.set('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	vim.keymap.set('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	vim.keymap.set('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	vim.keymap.set('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	vim.keymap.set('n', '<A-enter>', '<cmd>lua vim.lsp.buf.code_action({apply=true})<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.keymap.set({'n', 'v'}, '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)

	vim.keymap.set('n', '<F5>', "<Cmd>lua require'dap'.continue()<CR>", opts)
	vim.keymap.set('n', '<F6>', "<Cmd>lua require'dap'.step_over()<CR>", opts)
	vim.keymap.set('n', '<F7>', "<Cmd>lua require'dap'.step_into()<CR>", opts)
	vim.keymap.set('n', '<F8>', "<Cmd>lua require'dap'.step_out()<CR>", opts)
	vim.keymap.set('n', '<F9>', "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
	vim.keymap.set('n', '<F10>', "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
	vim.keymap.set('n', '<F11>', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)

	vim.cmd [[ command! DapClearBreakpoints lua require'dap'.clear_breakpoints() ]]
	vim.cmd [[ command! DapRepl lua require'dap'.repl.toggle() ]]
	vim.cmd [[ command! -range=% Format lua vim.lsp.buf.format({range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

	vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
	'bashls',
	'pylsp',
	'texlab',
	'clangd',
	'rust_analyzer',
	'tsserver',
}

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		'jdtls',
		unpack(servers)
	}
})
require("mason-nvim-dap").setup({
	ensure_installed = {
		'javadbg',
	},
	automatic_installation = true,
	automatic_setup = true,
})
require('mason-nvim-dap').setup_handlers()

local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- nvim-cmp setup
local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
				else
					cmp.confirm()
				end
			else
				fallback()
			end
		end, {"i","s"}),
		['<Down>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		['<Up>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	},
	sources = cmp.config.sources(
	{
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
		{ name = 'spell' },
	},
	{
		{ name = 'buffer' },
	})
}
EOF
