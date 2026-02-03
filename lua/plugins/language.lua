-- Autocompletion
vim.cmd.packadd("blink.cmp")
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
