---
title: Getting Started
description: How to install and customize nvdots
sidebar:
    order: 1
---
nvdots makes use of [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules/) to wrap Neovim with all my plugins and configuration so I recommend taking a look at [it's docs by clicking on this link](https://birdeehub.github.io/nix-wrapper-modules/). This will show you all sorts of ways to basically just, mess with the nvdots package to do your own thing and of course, understand how I'm creating it.

The flake exports just one package that you can wrap with your own configuration and plugins and all.

The flake has nothing worth looking at since it only handles exporting a package and all. The interesting part is `nvim.nix` which is the actual package. Here you can see all the plugins and external dependencies e.g. `ripgrep` that is installed with nvdots by default along other additional settings.

Plugins are loaded using the builtin plugin manager provided by Neovim called `packadd` and combined with auto-commands for lazy-loading on events.

## How to use nvdots
- Add `nvdots` to flake inputs of course
```nix
nvdots = {
  url = "github:Voxi0/nvdots";

  # Use your flake's nixpkgs
  inputs.nixpkgs.follows = "nixpkgs";
};
```
- Add the package to `home.packages` or `environment.systemPackages` or whatever.
```
inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim
```
- Configure nvdots however you want by wrapping the package with your own stuff. Here's an example where I add some plugins and extra packages e.g. language servers on top of nvdots.
```nix
home.packages = [
	(inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim.wrap ({pkgs, ...}: {
		extraPackages = with pkgs; [
			# Language servers
			clang-tools # C/C++
			nil # Nix
			lua-language-server # Lua
			astro-language-server # AstroJS - Webdev framework

			# For the Wakatime plugin
			wakatime-cli
		];
		specs.general = {
			data = [pkgs.vimPlugins.vim-wakatime];
			config = ''
				-- Load Wakatime plugin
				vim.cmd.packadd("vim-wakatime")

				-- Enable LSP configurations for whatever languages I want
				vim.lsp.enable({ "lua_ls", "nil_ls", "clangd", "zls", "astro" })
			'';
		};
	}))
];
```
