return {
	-- Shows available keymaps as you type
	{
		"which-key.nvim",
		after = function()
			require("which-key").setup({
				preset = "helix",
			})
		end,
	},

	-- File explorer and picker
	{
		"mini.files",
		keys = {
			{
				"<leader>e",
				mode = { "n" },
				desc = "Open file explorer",
				function()
					MiniFiles.open()
				end,
			},
		},
		after = function()
			require("mini.files").setup()
		end,
	},
	{
		"mini.pick",
		keys = {
			-- Find file
			{
				"<leader>ff",
				mode = { "n" },
				desc = "Open file picker",
				"<cmd>Pick files<cr>"
			},

			-- Find buffer
			{
				"<leader>fb",
				mode = { "n" },
				desc = "Open buffer picker",
				"<cmd>Pick buffers<cr>"
			}
		},
		after = function()
			require("mini.pick").setup({
				mappings = {
					move_down = "<C-j>",
					move_up = "<C-k>",
				},
			})
		end,
	},

	-- Code folding
	{
		"nvim-ufo",
		event = "InsertEnter",
		keys = {
			{
				"zR",
				mode = { "n" },
				desc = "Open all folds",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				mode = { "n" },
				desc = "Close all folds",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
		after = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end
			})
		end,
	},

	-- Add, delete, replace, find and highlight surrounding e.g. a pair of parenthesis, quotes, etc.
	{
		"mini.surround",
		event = "InsertEnter",
		after = function()
			require("mini.surround").setup()
		end,
	},

	-- Autopairing
	{
		"mini.pairs",
		event = "InsertEnter",
		after = function()
			require("mini.pairs").setup({
				modes = { insert = true, command = true, terminal = true },
				mappings = {
					['('] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
					[')'] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },

					['['] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
					[']'] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },

					['{'] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },
					['}'] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

					['<'] = { action = "open", pair = "<>", neigh_pattern = "[%a:]." },
					['>'] = { action = "close", pair = "<>", neigh_pattern = "[^\\]." },

					['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[^\\]", register = { cr = false } },
					["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
					['`'] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
				},
			})
		end,
	},
}
