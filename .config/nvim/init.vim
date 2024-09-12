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
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'pmizio/typescript-tools.nvim'
	Plug 'mfussenegger/nvim-lint'
	Plug 'mfussenegger/nvim-dap'
	Plug 'mfussenegger/nvim-dap-python'
	Plug 'mxsdev/nvim-dap-vscode-js'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-treesitter/nvim-treesitter-textobjects'
	Plug 'lewis6991/gitsigns.nvim'
	Plug 'romgrk/barbar.nvim'
	Plug 'lukas-reineke/indent-blankline.nvim'
	Plug 'theHamsta/nvim-dap-virtual-text'
	Plug 'nvim-neotest/nvim-nio'
	Plug 'rcarriga/nvim-dap-ui'
	Plug 'williamboman/mason.nvim'
	Plug 'jay-babu/mason-nvim-dap.nvim'
	Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
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
	Plug 'JavaHello/spring-boot.nvim'
	Plug 'MunifTanjim/nui.nvim'
	Plug 'nvimtools/none-ls.nvim'
	Plug 'antoinemadec/FixCursorHold.nvim'
	Plug 'nvim-neotest/neotest'
	Plug 'rcasia/neotest-java'
	Plug 'dsych/blanket.nvim'
call plug#end()

highlight ColorColumn cterm=NONE

let g:barbar_auto_setup = v:false

command! -range Range lua print(<line1>,<line2>)
