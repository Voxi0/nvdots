return {
	-- Syntax highlighting
	{
		"nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		after = function()
			-- Syntax highlighting
			vim.api.nvim_create_autocmd("FileType", {
				-- pattern = { "c", "nix", "lua" },
				callback = function(args)
					-- Skip non-file buffers e.g. terminals and popups
					if vim.bo[args.buf].buftype ~= "" then return end
					if not vim.bo[args.buf].modifiable then return end
					if not vim.bo[args.buf].buflisted then return end

					-- Start up a treesitter parser only if it's available for the detected language
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if vim.treesitter.language.require_language(lang, nil, true) then
						vim.treesitter.start(args.buf)
					end
				end,
			})
		end,
	},

	-- Autocompletion
	{
		"blink.cmp",
		event = "InsertEnter",
		after = function()
			require("blink-cmp").setup({})
		end,
	},
}
