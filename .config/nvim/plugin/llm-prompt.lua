require("CopilotChat").setup()
require("codecompanion").setup({
	-- strategies = {
	-- 	chat = { adapter = 'gemini', },
	-- 	inline = { adapter = 'gemini', },
	-- 	cmd = { adapter = 'gemini', },
	-- },
	-- adapters = {
	--    acp = {
	--      gemini_cli = function()
	--        return require("codecompanion.adapters").extend("gemini_cli", {
	--          env = {
	--            api_key = "cmd:op read op://personal/Gemini/credential --no-newline",
	--          },
	--        })
	--      end,
	--    },
	--  },
})
