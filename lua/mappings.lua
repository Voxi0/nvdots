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
vim.keymap.set("n", "<leader>mp", vim.lsp.buf.format, { desc = "Format current buffer" })

vim.lsp.enable({ "lua_ls" })
vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
	settings = {
		Lua = {
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
}
