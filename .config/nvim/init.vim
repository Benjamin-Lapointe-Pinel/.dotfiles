set runtimepath^=$HOME/.vim runtimepath+=$HOME/.vim/after
let &packpath = &runtimepath
source $HOME/.vim/vimrc

call plug#begin()
Plug 'neovim/nvim-lspconfig'
call plug#end()
