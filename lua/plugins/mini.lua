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

		["<"] = { action = "open", pair = "<>" },
		[">"] = { action = "close", pair = "<>" },

		['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
		["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
		["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
	},
})

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
