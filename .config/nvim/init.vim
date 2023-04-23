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
Plug 'mfussenegger/nvim-dap-python'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/barbar.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
Plug 'williamboman/mason.nvim'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
Plug 'jayp0521/mason-nvim-dap.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'f3fora/cmp-spell'
Plug 'rcarriga/cmp-dap'
Plug 'mfussenegger/nvim-jdtls'
Plug 'akinsho/toggleterm.nvim'
call plug#end()

command! -range Range lua print(<line1>,<line2>)

lua << EOF

vim.api.nvim_create_user_command(
  'Diagnostic',
  function(opts)
    if opts.args == 'all' then
      vim.diagnostic.setqflist()
    elseif opts.args == 'error' then
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    elseif opts.args == 'warning' then
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARNING })
    elseif opts.args == 'info' then
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
    elseif opts.args == 'hint' then
      vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
    else
      vim.diagnostic.setqflist()
    end
  end,
  {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        return { 'all', 'error', 'warning', 'info', 'hint' }
    end,
    desc = 'Set diagnostic errors to quickfix list'
  }
)

function SetErrorsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end

function SetWarningsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.WARNING })
end

function SetInfosQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.INFO })
end

function SetHintsQuickfixList(minwid, number_of_clicks, mouse_button, modifier)
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.HINT })
end

function LspStatusError()
  local error_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.ERROR })
  if error_number > 0 then
    return '%1* E '..error_number..' %*'
  end
  return ''
end

function LspStatusWarning()
  local warning_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.WARNING })
  if warning_number > 0 then
    return '%8* W '..warning_number..' %*'
  end
  return ''
end

function LspStatusInfo()
  local info_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.INFO })
  if info_number > 0 then
    return '%4* I '..info_number..' %*'
  end
  return ''
end

function LspStatusHint()
  local hint_number = #vim.diagnostic.get(nill, { severity = vim.diagnostic.severity.HINT })
  if hint_number > 0 then
    return '%6* H '..hint_number..' %*'
  end
  return ''
end

vim.opt.laststatus = 3
vim.opt.statusline:append('%@v:lua.SetWarningsQuickfixList@%{%v:lua.LspStatusWarning()%}%T')
vim.opt.statusline:append('%@v:lua.SetErrorsQuickfixList@%{%v:lua.LspStatusError()%}%T')
vim.opt.statusline:append('%@v:lua.SetInfosQuickfixList@%{%v:lua.LspStatusInfo()%}%T')
vim.opt.statusline:append('%@v:lua.SetHintssQuickfixList@%{%v:lua.LspStatusHint()%}%T')

vim.cmd[[highlight BufferCurrent ctermbg=white ctermfg=black]]
vim.cmd[[highlight BufferCurrentSign ctermbg=white ctermfg=gray]]
vim.cmd[[highlight BufferCurrentMod cterm=bold ctermbg=white ctermfg=blue]]
vim.cmd[[highlight BufferInactiveMod cterm=bold ctermfg=blue]]
vim.cmd[[highlight BufferInactiveSign ctermfg=gray]]
vim.g.barbar_auto_setup = false
require('barbar').setup{
  animation = false,
  icons = {
    button = '',
    modified = {button = ''},
    pinned = {button = '+'},
    filetype = {
      enabled = false,
    },
  },
  exclude_ft = {'qf'},
}

vim.cmd[[hi! link NormalFloat Normal]] -- https://vi.stackexchange.com/a/39079
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ge', builtin.find_files, {})
vim.keymap.set('n', 'gb', builtin.buffers, {})

require("toggleterm").setup {
	open_mapping = [[<c-\>]],
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
function lazygit_toggle()
	lazygit:toggle()
end
vim.cmd[[ command! LazyGit execute 'lua lazygit_toggle()' ]]

vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local opts = { noremap=true, silent=true }
	vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
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
	vim.keymap.set('n', '<F10>', "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
	vim.keymap.set({'n', 'v'}, '<F11>', '<Cmd>lua require("dapui").eval()<CR>', opts)
	vim.keymap.set('n', '<F12>', ":DapTerminate<CR>", opts)

	vim.cmd [[ command! DapClearBreakpoints lua require'dap'.clear_breakpoints() ]]
	vim.cmd [[ command! DapRepl lua require'dap'.repl.toggle() ]]
	vim.cmd [[ command! DapUiToggle lua require("dapui").toggle() ]]

	vim.cmd [[ command! -range=% Format lua vim.lsp.buf.format({range={['start']={<line1>,0},['end']={<line2>,0}}}) ]]

	vim.cmd [[ au FileType dap-repl lua require('dap.ext.autocompl').attach() ]]
end

require'nvim-treesitter.configs'.setup({
	ensure_installed = {
		'bash',
		'python',
		'latex',
		'c',
		'cpp',
		'java',
		'javascript',
		'typescript',
		'yaml',
	}
})

vim.cmd [[highlight IndentBlanklineChar ctermfg=19]]
require("indent_blankline").setup {
  use_treesitter = true,
  max_indent_increase = 1,
}

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
	},
  run_on_start = true,
  auto_update = true,
}

local servers = {
	'angularls',
	'bashls',
	'clangd',
	'gradle_ls',
	'pylsp',
	'texlab',
	'rust_analyzer',
	'tsserver',
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local nvim_lsp = require('lspconfig')
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup {
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

require("mason-nvim-dap").setup{
  ensure_installed = {
    'javadbg',
    'python'
  },
  automatic_installation = true,
}
require('dap-python').setup('/usr/bin/python')
require("nvim-dap-virtual-text").setup()
local dap, dapui = require("dap"), require("dapui")
vim.fn.sign_define('DapStopped', {text='>'})
dapui.setup({
	 icons = { collapsed = ">", expanded = "|" },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.5 },
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"console",
			},
			size = 0.25,
			position = "bottom",
		}
	},
	controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "PAUSE",
      play = "PLAY",
      step_into = "STEP_INTO",
      step_over = "STEP_OVER",
      step_out = "STEP_OUT",
      step_back = "STEP_BACK",
      run_last = "RUN_LAST",
      terminate = "TERMINATE",
    },
  },
})
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local cmp = require('cmp')
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
  window = {
    documentation = {
      winhighlight = "Normal:Pmenu,FloatBorder:PmenuSbar,CursorLine:PmenuSel,Search:None",
    }
  },
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-Up>'] = cmp.mapping.scroll_docs(-4),
		['<C-Down>'] = cmp.mapping.scroll_docs(4),
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
	}),
	enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end
}

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
  sources = {
    { name = "dap" },
  },
})

EOF
