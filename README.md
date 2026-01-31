<h1 align="center">nvdots</h1>

This is my personal [Neovim](https://neovim.io/) configuration.

## How it works
I'm making use of [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) which basically lets you take a package and wrap it with extra configuration and packages and all while using the Nix module system along with some pre-built wrapper modules to make your life easier.

I'm using this to create a Neovim package with all my configurations and such applied to it. Since it's just a package, it can be easily installed on anything with Nix and also extended further.

## How to add your own configuration/plugins or anything else
- Add `nvdots` to flake inputs of course
```nix
nvdots = {
  url = "github:Voxi0/nvdots";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
- Add the package to `home.packages` or `environment.systemPackages` or whatever.
```
inputs.nvdots.packages.${pkgs.stdenv.hostPlatform.system}.neovim
```
- Configure nvdots however you want by wrapping the package with your own stuff. Here's an example where I add a simple plugin on top of nvdots.
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
