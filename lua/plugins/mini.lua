-- File explorer
vim.cmd.packadd("mini.files")
require("mini.files").setup()
vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open()
end, { desc = "Open file explorer" })

-- File picker
vim.cmd.packadd("mini.pick")
require("mini.pick").setup({
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
	},
})
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Open file picker" })
vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Open buffer picker" })

-- Session management
vim.cmd.packadd("mini.sessions")
require("mini.sessions").setup({
	autoread = false,
	autowrite = true,

	-- File for local session
	file = "Session.vim",

	-- Whether to print session path after action
	verbose = { read = false, write = true, delete = true },
})
vim.keymap.set("n", "<leader>ls", function()
	MiniSessions.read()
end, { desc = "Read session" })

-- Add, delete, replace, find and highlight surrounding e.g. a pair of parenthesis, quotes, etc.
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("mini.surround")
		require("mini.surround").setup()
	end,
})
