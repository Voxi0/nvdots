return {
	-- Theme
	{
		"nightfox.nvim",
		priority = 1000,
		after = function()
			-- Set theme
			vim.cmd("colorscheme carbonfox")
		end,
	},

	-- Icons
	{
		"mini.icons",
		after = function()
			require("mini.icons").setup()
		end,
	},

	-- Statusline
	{
		"lualine.nvim",
		after = function()
			-- Set up Lualine
			require("lualine").setup({
				options = {
					-- Have a single statusline at the bottom instead of one for every window
					-- Ensures that Lualine doesn't get replaced with the default statusline when a `mini.picker` window is open
					globalstatus = true,
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "fileformat", "filetype" },
					lualine_y = { "progress" },
					lualine_z = {},
				},
			})
		end,
	},
}
