-----------------------
--- Generic keymaps ---
-----------------------
-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Formatting
vim.keymap.set("n", "<leader>mp", vim.lsp.buf.format, { desc = "Format current buffer" })

vim.lsp.config["lua_ls"] = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
}
vim.lsp.enable({ "lua_ls" })
