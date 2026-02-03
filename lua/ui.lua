--------------
-- Visuals ---
--------------
-- Theme
vim.cmd.packadd("catppuccin-nvim")
require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = false,
	color_overrides = {
		mocha = {
			base = "#000000",
			mantle = "#010101",
			crust = "#020202",
		},
	},
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
require("mini.animate").setup()

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
vim.api.nvim_create_autocmd("CursorMoved", {
	group = vim.api.nvim_create_augroup("AutoCenterEOF", { clear = true }),
	callback = function()
		local line_count = vim.api.nvim_buf_line_count(0)
		local current_line = vim.api.nvim_win_get_cursor(0)[1]
		local scrolloff = vim.opt.scrolloff:get()

		-- If we are within the 'scrolloff' range of the end of the file
		if line_count - current_line < scrolloff then
			vim.cmd("normal! zz")
		end
	end,
})

-- No text wrapping around the screen
vim.opt.wrap = false

-- Window borders
vim.opt.winborder = "rounded"
