return {
	"snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		--------------
		--- Picker ---
		--------------
		-- Files
		{
			"<leader>ff",
			mode = "n",
			desc = "Open file picker",
			function()
				Snacks.picker.files({ hidden = true })
			end,
		},

		-- Buffers
		{
			"<leader>fb",
			mode = "n",
			desc = "Buffers",
			function()
				Snacks.picker.buffers()
			end,
		},

		-- Grep
		{
			"<leader>sg",
			desc = "Grep",
			function()
				Snacks.picker.grep()
			end,
		},
		{
			"<leader>sb",
			desc = "Buffer Lines",
			function()
				Snacks.picker.lines({
					layout = { preset = "vscode" },
				})
			end,
		},
		{
			"<leader>sB",
			desc = "Grep Open Buffers",
			function()
				Snacks.picker.grep_buffers()
			end,
		},
		{
			"<leader>sw",
			mode = { "n", "x" },
			desc = "Visual selection or word",
			function()
				Snacks.picker.grep_word()
			end,
		},

		-- Help
		{
			"<leader>sh",
			mode = "n",
			desc = "Open help page",
			function()
				Snacks.picker.help()
			end,
		},

		---------------
		--- LazyGit ---
		---------------
		{
			"<leader>gg",
			mode = "n",
			desc = "Open LazyGit",
			function()
				Snacks.lazygit()
			end,
		},
	},
	after = function()
		require("snacks").setup({
			-- Indentation guides
			indent = {},

			-- TUI for Git
			lazygit = {},

			-- Better statuscolumn
			statuscolumn = {},

			-- Smooth scrolling
			scroll = {},

			-- Renders images
			image = {},

			-- Dashboard
			dashboard = {
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
				},
			},

			-- Picker
			picker = {
				-- Disable previewer
				layout = { preset = "vscode", preview = false },
			},
		})
	end,
}
