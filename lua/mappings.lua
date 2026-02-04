-- Shows available keymaps as you type
vim.cmd.packadd("which-key.nvim")
require("which-key").setup({
	preset = "helix",
})

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---------------
--- Keymaps ---
---------------
map = vim.keymap.set

-- Toggle line numbers
map("n", "<leader>n", "<cmd>set number!<cr>", { desc = "Toggle line numbers" })
map("n", "<leader>rn", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative line numbers" })

-- Delete without yanking/copying
map({ "n", "v" }, "d", '"_d', { desc = "Delete" })

-- Better indenting in visual mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Clear search highlights
map("n", "<escape>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights" })

-- Buffers

-- Formatting
map("n", "<leader>mp", function()
	require("conform").format({
		lsp_fallback = false,
		async = true,
		timeout_ms = 500,
	})
end, { desc = "Format current buffer" })

-- Treesitter textobjects
vim.cmd.packadd("nvim-treesitter-textobjects")

-- Selecting
map({ "x", "o" }, "af", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, { desc = "Select function outer" })
map({ "x", "o" }, "if", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, { desc = "Select function inner" })

-- Moving
map({ "n", "x", "o" }, "]m", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, { desc = "Goto next function start" })
map({ "n", "x", "o" }, "]M", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
end, { desc = "Goto next function end" })
map({ "n", "x", "o" }, "[m", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, { desc = "Goto previous function start" })
map({ "n", "x", "o" }, "[M", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
end, { desc = "Goto previous function end" })

-- Classes textobjects
-- Selecting
map({ "x", "o" }, "ac", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, { desc = "Select class outer" })
map({ "x", "o" }, "ic", function()
	require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, { desc = "Select class inner" })

-- Moving
map({ "n", "x", "o" }, "]]", function()
	require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, { desc = "Goto next class start" })
map({ "n", "x", "o" }, "][", function()
	require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
end, { desc = "Goto next class end" })
map({ "n", "x", "o" }, "[[", function()
	require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, { desc = "Goto previous class start" })
map({ "n", "x", "o" }, "[]", function()
	require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
end, { desc = "Goto previous class end" })
