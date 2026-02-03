-- Experimental Lua module loader using bytecode caching or whatever
vim.loader.enable()

--------------------
--- Code folding ---
--------------------
vim.opt.foldenable = true
vim.opt.foldcolumn = "1"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

----------------
-- Searching ---
----------------
-- Case insensitive search unless search includes an uppercase character
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Show matches as you type
vim.opt.incsearch = true

---------------------
--- File handling ---
---------------------
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.autoread = true
vim.opt.autowrite = false

-------------------
--- Performance ---
-------------------
-- Faster completion
vim.opt.updatetime = 300

-- Don't redraw during macros
vim.opt.lazyredraw = true

---------------------
--- Miscellaneous ---
---------------------
-- Enable mouse support
vim.opt.mouse = "a"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Spell checking
vim.opt.spell = true

-- Faster scrolling
vim.opt.ttyfast = true

-- We use Lualine instead so this is unnecessary
vim.opt.showmode = false

-- File encoding
vim.opt.encoding = "UTF-8"

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
