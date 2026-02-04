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
		-- Ensures that Lualine doesn't get replaced with the default statusline when a `mini.picker` window is open for example
		globalstatus = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		refresh = {
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = { "diff", "lsp_status" },
		lualine_z = {
			{
				"datetime",
				style = "%I:%M %p",
			},
		},
	},
})

-- Animations for common Neovim actions
vim.cmd.packadd("mini.animate")
require("mini.animate").setup({
	cursor = { enable = false },
})

-- Bufferline
vim.cmd.packadd("bufferline.nvim")
require("bufferline").setup()

-- Enable 24-bit colors
vim.opt.termguicolors = true

-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep 10 lines above/below the cursor and 8 columns left/right of the cursor
vim.opt.scrolloff = 15
vim.opt.sidescrolloff = 8

-- No text wrapping around the screen
vim.opt.wrap = false

-- Hide the command line when not being used
vim.opt.cmdheight = 0
vim.opt.showcmd = false
vim.opt.showmode = false
vim.opt.ruler = false

-- Always show signcolumn so the text doesn't shift whenever you start/stop typing
vim.opt.signcolumn = "yes"

-- Window borders
vim.opt.winborder = "rounded"
