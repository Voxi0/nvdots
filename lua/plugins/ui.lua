return {
	-- Theme
	{
		"catppuccin-nvim",
		lazy = false,
		priority = 1000,
		colorscheme = "catppuccin",
		after = function()
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
				custom_highlights = function(colors)
					return {
						WinSeparator = { fg = colors.flamingo },
					}
				end,
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	-- Icons
	{
		"mini.icons",
		after = function()
			local icons = require("mini.icons")
			icons.setup()
			icons.mock_nvim_web_devicons()
		end,
	},

	-- Statusline
	{
		"lualine.nvim",
		lazy = false,
		after = function()
			require("lualine").setup({
				options = {
					-- Have a single statusline at the bottom instead of one for every window
					-- Ensures that Lualine doesn't get replaced with the default statusline when a `mini.picker` window is open for example
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
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
		end,
	},

	-- Animations for common Neovim actions
	{
		"mini.animate",
		event = "DeferredUIEnter",
		after = function()
			-- Animations for common Neovim actions
			require("mini.animate").setup({
				cursor = { enable = false },
			})
		end,
	},

	-- Bufferline
	{
		"bufferline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{
				"<leader>bda",
				mode = "n",
				desc = "Close all buffers except the current one",
				"<cmd>BufferLineCloseOthers<cr>",
			},
		},
		after = function()
			require("bufferline").setup({
				options = {
					sort_by = "insert_after_current",
					separator_style = "slanted",
					diagnostics = "nvim_lsp",
					indicator = { style = "underline" },
					hover = {
						enabled = true,
						delay = 200,
						reveal = { "close" },
					},
				},
			})
		end,
	},
}
