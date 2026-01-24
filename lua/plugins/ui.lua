return {
	-- Theme
	{
		"vague.nvim",
		priority = 1000,
		after = function()
			-- Set theme
			vim.cmd("colorscheme vague")
		end,
	},

	-- Icons
	{
		"mini.icons",
		after = function()
			require("mini.icons").setup()
		end,
	},
}
