-- Experimental Lua module loader using bytecode caching or whatever
vim.loader.enable()
o = vim.opt

--------------------
--- Code folding ---
--------------------
o.foldenable = true
o.foldcolumn = "1"
o.foldlevel = 99
o.foldlevelstart = 99

----------------
-- Searching ---
----------------
-- Case insensitive search unless search includes an uppercase character
o.ignorecase = true
o.smartcase = true

-- Highlight search results
o.hlsearch = true

-- Show matches as you type
o.incsearch = true

---------------------
--- File handling ---
---------------------
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true
o.undodir = vim.fn.expand("~/.vim/undodir")
o.autoread = true
o.autowrite = false

-------------------
--- Performance ---
-------------------
-- Faster completion
o.updatetime = 300

---------------------
--- Miscellaneous ---
---------------------
-- Enable mouse support
o.mouse = "a"

-- Use system clipboard
o.clipboard = "unnamedplus"

-- Spell checking
o.spell = true

-- We use Lualine instead so this is unnecessary
o.showmode = false

---------------------
--- Auto-commands ---
---------------------
----- Disable auto comments
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Wrap text in Markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})
