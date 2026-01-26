-- Shows available keymaps as you type
vim.cmd.packadd("which-key.nvim")
require("which-key").setup({
	preset = "helix",
})

-- File explorer
vim.cmd.packadd("mini.files")
require("mini.files").setup()
vim.keymap.set("n", "<leader>e", function()
	MiniFiles.open()
end, { desc = "Open file explorer" })

-- File picker
vim.cmd.packadd("mini.pick")
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Open file picker" })
vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Open buffer picker" })
require("mini.pick").setup({
	mappings = {
		move_down = "<C-j>",
		move_up = "<C-k>",
	},
})

-- Code folding
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("nvim-ufo")
		vim.keymap.set("n", "zR", function()
			require("ufo").openAllFolds()
		end, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", function()
			require("ufo").closeAllFolds()
		end, { desc = "Close all folds" })
		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
})

-- Add, delete, replace, find and highlight surrounding e.g. a pair of parenthesis, quotes, etc.
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("mini.surround")
		require("mini.surround").setup()
	end,
})

-- Autopairing
vim.cmd.packadd("mini.pairs")
require("mini.pairs").setup({
	modes = { insert = true, command = true, terminal = true },
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
		[")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },

		["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
		["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },

		["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },
		["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

		["<"] = { action = "open", pair = "<>", neigh_pattern = "[%a:]." },
		[">"] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
	},
})

-- Snacks.nvim
vim.keymap.set("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Open LazyGit" })
require("snacks").setup({
	lazygit = { enabled = true },
	indent = { enabled = true },
	notifier = { enabled = true },
	statuscolumn = { enabled = true },
	dashboard = {
		enabled = true,
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
