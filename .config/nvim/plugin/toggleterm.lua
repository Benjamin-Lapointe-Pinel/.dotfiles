require("toggleterm").setup {
	open_mapping = [[<c-\>]],
}

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = 'float' })
function lazygit_toggle()
	lazygit:toggle()
end
vim.cmd[[ command! LazyGit execute 'lua lazygit_toggle()' ]]
