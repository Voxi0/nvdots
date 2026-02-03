--------------
-- Visuals ---
--------------
-- Theme
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "catppuccin",
	callback = function()
		setHl = vim.api.nvim_set_hl
		setHl(0, "Normal", { bg = "#000000" })
		setHl(0, "NormalFloat", { bg = "#000000" })
		setHl(0, "FloatBorder", { fg = "#89b4fa" })
		setHl(0, "WinSeparator", { fg = "#89b4fa" })
	end,
})
vim.cmd.colorscheme("catppuccin")

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

-- Animations for common Neovim actions
vim.cmd.packadd("mini.animate")
require("mini.animate").setup({
	cursor = { enable = false },
})

-- Enable 24-bit colors
vim.opt.termguicolors = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show signcolumn so the text doesn't shift whenever you start/stop typing
vim.opt.signcolumn = "yes"

-- Keep 10 lines above/below the cursor and 8 columns left/right of the cursor
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 8

-- No text wrapping around the screen
vim.opt.wrap = false

-- Window borders
vim.opt.winborder = "rounded"
