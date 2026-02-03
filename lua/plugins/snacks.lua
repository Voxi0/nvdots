vim.cmd.packadd("snacks.nvim")

require("snacks").setup({
	lazygit = {},
	indent = {},
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

-- LazyGit
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Open LazyGit" })

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
