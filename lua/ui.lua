--------------
-- Visuals ---
--------------
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

-- Enable 24-bit colors
vim.o.termguicolors = true

-- Line numbering
vim.o.number = true
vim.o.relativenumber = true

-- Always show signcolumn so the text doesn't shift whenever you start/stop typing
vim.o.signcolumn = "yes"

-- Keep 10 lines above/below the cursor and 8 columns left/right of the cursor
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8

-- No text wrapping around the screen
vim.o.wrap = false

-- Window borders
vim.o.winborder = "rounded"
