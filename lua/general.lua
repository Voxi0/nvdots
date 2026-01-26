--------------------
--- Code folding ---
--------------------
vim.o.foldenable = true
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99

----------------
-- Searching ---
----------------
-- Case insensitive search unless search includes an uppercase character
vim.o.ignorecase = true
vim.o.smartcase = true

-- Highlight search results
vim.o.hlsearch = true

-- Show matches as you type
vim.o.incsearch = true

---------------------
--- File handling ---
---------------------
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.autoread = true
vim.o.autowrite = false

-------------------
--- Performance ---
-------------------
-- Faster completion
vim.o.updatetime = 300

-- Don't redraw during macros
vim.o.lazyredraw = true

---------------------
--- Miscellaneous ---
---------------------
-- Enable mouse support
vim.o.mouse = "a"

-- Use system clipboard
vim.o.clipboard = "unnamedplus"

-- Spell checking
vim.o.spell = true

-- File encoding
vim.o.encoding = "UTF-8"

-- nixCats specific stuff
vim.g.startuptime_exe_path = nixCats.packageBinPath

---------------------
--- Auto-commands ---
---------------------
----- Disable auto comments
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})
