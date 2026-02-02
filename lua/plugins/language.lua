-- Syntax highlighting
-- Attach Treesitter to every buffer
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local language = vim.treesitter.language.get_lang(args.match)
		if not language then
			return
		end

		-- Try attaching Treesitter to current buffer
		if not vim.treesitter.language.add(language) then
			return false
		else
			vim.treesitter.start(buffer, language)
		end

		-- if not treesitterTryAttach(buffer,language) then
		--	-- Try installing parser via `nvim-treesitter` if not available
		--	if vim.tbl_contains(require("nvim-treesitter").get_available(), language) then
		--		require("nvim-treesitter").install(language):await(function()
		--		treesitterTryAttach(buf, language)
		--	end
		-- end
	end,
})

-- Autocompletion
require("blink-cmp").setup({
	keymap = {
		-- Get rid of all preset key-mappings
		preset = "none",

		-- Go up and down
		["<C-j>"] = { "select_next" },
		["<C-k>"] = { "select_prev" },
		["<Down>"] = { "scroll_documentation_down", "fallback" },
		["<Up>"] = { "scroll_documentation_up", "fallback" },

		-- Documentation
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

		-- Accept or cancel suggestion
		["<Tab>"] = { "accept", "fallback" },
	},
})
