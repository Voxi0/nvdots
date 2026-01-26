-- Theme
vim.cmd.packadd("nightfox.nvim")
vim.cmd("colorscheme carbonfox")

-- Icons
vim.cmd.packadd("mini.icons")
require("mini.icons").setup()

-- Statusline
vim.cmd.packadd("lualine.nvim")
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
