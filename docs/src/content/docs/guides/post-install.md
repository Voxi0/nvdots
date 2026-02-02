---
title: Post-Install
description: Recommended things to do after installing nvdots
sidebar:
    order: 2
---
There are some super duper important stuff that nvdots won't configure for you so you can set it up yourself instead. Don't worry, it's not that hard. I'll guide you through it.

And just a reminder, all external dependencies goes into the `extraPackages` section. This can be literally any package.

## Language servers (LSPs)
LSPs are required for error-checking, autocompletion. I'd say using an external formatter is better but some LSPs do include a formatter. , Nvdots uses `nvim-lspconfig` which basically configures a whole lot of language servers for you so you can simply just, enable them to get it working right away.

Just install some language servers and use `vim.lsp.enable`. Check [this site](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) to figure out what language servers are supported and how they're configured by default.

So, let's try this with `lua-ls`. Note that `nvim-lspconfig` configures it under `lua_ls` so you need to do `vim.lsp.enable("lua_ls")`. Also to enable multiple language servers, you'd do this, `vim.lsp.enable({"lua_ls", "<another language server>"})`

```nix
(inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap ({pkgs, ...}: {
	extraPackages = with pkgs; [
		# Lua language server
		lua-language-server
	];
	specs.general.config = ''
		-- Enable Lua language server
		vim.lsp.enable("lua_ls"})
	'';
}))
```

## Formatting
While a bunch of LSPs do include a formatter, I'd recommend using an external one instead. Nvdots uses [`conform.nvim`](https://github.com/stevearc/conform.nvim) so read through their README to configure it to your liking and set up formatters. This is the same as for LSPs really. Just install your formatters and then set them by configuring `conform.nvim`.
```
(inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap ({pkgs, ...}: {
	extraPackages = with pkgs; [
		# Lua formatters
		stylua
	];
	specs.general.config = ''
		-- Set up formatters for various filetypes
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
		})
	'';
}))
```

## Installing extra plugins
This is super straightforward. Just add the plugin you wanna install to the correct specs list. For now, nvdots has only one specs list called `general`. So just add your own plugins to it's data list. Below is an example of adding Wakatime which also has an external dependency - `wakatime-cli`.

```nix
(inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap ({pkgs, ...}: {
  extraPackages = with pkgs; [
	# For the Wakatime plugin
	wakatime-cli
  ];
  specs.general.data = [pkgs.vimPlugins.vim-wakatime];
```
