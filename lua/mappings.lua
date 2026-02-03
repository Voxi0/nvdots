-- Shows available keymaps as you type
vim.cmd.packadd("which-key.nvim")
require("which-key").setup({
	preset = "helix",
})

-----------------------
--- Generic keymaps ---
-----------------------
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Toggle line numbers
vim.keymap.set("n", "<leader>n", "<cmd>set number!<cr>", { desc = "Toggle line numbers" })
vim.keymap.set("n", "<leader>rn", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line numbers" })

-- Delete without yanking/copying
vim.keymap.set({ "n", "v" }, "d", '"_d', { desc = "Delete" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlights
vim.keymap.set("n", "<escape>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Formatting
vim.keymap.set("n", "<leader>mp", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 500,
	})
end, { desc = "Format current buffer" })

-- Better textobjects using Treesitter
-- Functions
vim.keymap.set({ "x", "o" }, "of", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Select function outer" })
vim.keymap.set({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Select function inner" })

-- Classes
vim.keymap.set({ "x", "o" }, "oc", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Select class outer" })
vim.keymap.set({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Select class inner" })
