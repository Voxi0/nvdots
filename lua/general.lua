local options = {
	--------------------
	--- Code folding ---
	--------------------
	foldenable = true,
	foldcolumn = "1",
	foldlevel = 99,
	foldlevelstart = 99,

	----------------
	-- Searching ---
	----------------
	-- Case insensitive search unless search includes an uppercase character
	ignorecase = true,
	smartcase = true,

	-- Highlight search results
	hlsearch = true,

	-- Show matches as you type
	incsearch = true,

	---------------------
	--- File handling ---
	---------------------
	backup = false,
	writebackup = false,
	swapfile = false,
	undofile = true,
	undodir = vim.fn.expand("~/.vim/undodir"),
	autoread = true,
	autowrite = false,

	-------------------
	--- Performance ---
	-------------------
	-- Faster completion
	updatetime = 300,

	-- Don't redraw during macros
	lazyredraw = true,

	---------------------
	--- Miscellaneous ---
	---------------------
	-- Enable mouse support
	mouse = "a",

	-- Use system clipboard
	clipboard = "unnamedplus",

	-- Spell checking
	spell = true,

	-- Faster scrolling
	ttyfast = true,

	-- We use Lualine instead so this is unnecessary
	showmode = false,

	-- File encoding
	encoding = "UTF-8",
}

-- Set options
for key, value in pairs(options) do
	vim.o[key] = value
end

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

-- Wrap text in Markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal wrap",
})
