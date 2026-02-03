require("plugins.mini")
require("plugins.snacks")

-- Autopairing
vim.cmd.packadd("nvim-autopairs")
require("nvim-autopairs").setup {}

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
	end
})

-- Use Treesitter to auto-close and auto-rename HTML tag
require("nvim-ts-autotag").setup()
