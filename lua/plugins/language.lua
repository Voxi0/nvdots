return {
	-- Autocompletion
	{
		"blink.cmp",
		event = "InsertEnter",
		after = function()
			require("blink-cmp").setup({})
		end,
	},
}
