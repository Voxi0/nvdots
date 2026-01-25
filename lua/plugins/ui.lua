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

	-- Indentation guides
	{
		"mini.indentscope",
		event = "InsertEnter",
		keys = {
			{
				"<leader>ib",
				mode = { "n" },
				desc = "Toggle indentation guides",
				function()
					vim.g.miniindentscope_disable = not vim.g.miniindentscope_disable
				end,
			}
		},
		after = function()
			require("mini.indentscope").setup({
				draw = {
					animation = require("mini.indentscope").gen_animation.none(),
				},
			})
		end,
	},
}
