-- Syntax highlighting
vim.api.nvim_create_autocmd("BufEnter", {
	once = true,
	callback = function()
		-- Syntax highlighting
		local function treesitterTryAttach(buffer, language)
			-- Load parser for current language if it exists
			if not vim.treesitter.language.add(language) then
				return false
			end

			-- Enable syntax highlighting and other Treesitter features
			vim.treesitter.start(buf, language)
		end

		-- Run Treesitter on current file
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local buffer, filetype = args.buf, args.match

				local language = vim.treesitter.language.get_lang(filetype)
				if not language then
					return
				end

				-- Try attaching Treesitter to current buffer
				treesitterTryAttach(buffer, language)

				-- if not treesitterTryAttach(buffer,language) then
				--	-- Try installing parser via `nvim-treesitter` if not available
				--	if vim.tbl_contains(require("nvim-treesitter").get_available(), language) then
				--		require("nvim-treesitter").install(language):await(function()
				--		treesitterTryAttach(buf, language)
				--	end
				-- end
			end,
		})
	end,
})

-- Autocompletion
vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("blink.cmp")
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
				["<CR>"] = { "accept", "fallback" },
			},
		})
	end,
})
