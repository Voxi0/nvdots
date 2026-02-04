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

	-- Autopairing
	{
		"nvim-autopairs",
		after = function()
			require("nvim-autopairs").setup()
		end,
	},

	-- Code folding
	{
		"nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{
				"zR",
				mode = "n",
				desc = "Open all folds",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				mode = "n",
				desc = "Close all folds",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
		before = function()
			o = vim.opt
			o.foldenable = true
			o.foldlevel = 99
			o.foldlevelstart = 99
			o.foldcolumn = "1"
		end,
		after = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	-- Formatter
	{
		"conform.nvim",
		keys = {
			{
				"<leader>mp",
				mode = "n",
				desc = "Format current buffer",
				function()
					require("conform").format({
						lsp_fallback = false,
						async = true,
						timeout_ms = 500,
					})
				end,
			},
		},
	},

	-- Auto-close and auto-rename HTML tags using Treesitter
	{
		"nvim-ts-autotag",
		on_plugin = "nvim-treesitter",
		after = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}
