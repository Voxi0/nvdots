return {
	-- Treesitter textobjects for more codeaware Neovim motions
	-- Extends `mini.ai` to give it more textobjects to work with
	{
		"nvim-treesitter-textobjects",
		dep_of = "mini.ai",
	},

	-- Pre-written configurations for many LSPs that can be used out of the box
	{
		"nvim-lspconfig",
		event = "BufReadPost",
	},

	-- Autocompletion
	{
		"blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		after = function()
			require("blink-cmp").setup({
				keymap = {
					-- Get rid of all preset key-mappings
					preset = "none",

					-- Go up and down
					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
					["<Down>"] = { "scroll_documentation_down", "fallback" },
					["<Up>"] = { "scroll_documentation_up", "fallback" },

					-- Documentation
					["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

					-- Accept or cancel suggestion
					["<Tab>"] = { "accept", "fallback" },
				},
			})
		end,
	},
}
