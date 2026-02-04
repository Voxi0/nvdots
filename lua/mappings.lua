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
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Goto next buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Goto previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete current buffer" })
