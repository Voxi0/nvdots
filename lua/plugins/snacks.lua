return {
	"snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		-- Picker
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
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sw",
			desc = "Visual selection or word",
			mode = { "n", "x" },
			function()
				Snacks.picker.grep_word()
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
			picker = {
				-- Disable previewer
				layout = { preset = "vscode", preview = false },
			},
			indent = {},
			lazygit = {},
			notifier = {},
			statuscolumn = {},
			image = {},
			dashboard = {
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
				},
			},
		})

		-- Show LSP loading progress
		vim.api.nvim_create_autocmd("LspProgress", {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				vim.notify(vim.lsp.status(), "info", {
					id = "lsp_progress",
					title = client.name,
					opts = function(notif)
						notif.icon = ev.data.params.value.kind == "end" and " "
							or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
					end,
				})
			end,
		})
	end,
}
