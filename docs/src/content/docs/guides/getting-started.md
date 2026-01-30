---
title: Getting Started
description: Installing nvdots
---

The flake exports packages, overlays, a NixOS module and a Home Manager module so there are various ways you can use nvdots. Which way you choose to do things depends on your needs and all really.

Take a look at [the documentation or whatever for nixCats](https://nixcats.org/) so you can properly understand and customize nvdots to your liking since it makes use of nixCats. The templates are extremely helpful and will teach you a lot, you will need that information to effectively customize my configuration for yourself. In short, it's really just a sort of wrapper for Neovim so you can easily manage dependencies and plugins and all with Nix while configuring everything with Lua. It also provides some additional utilities and some other stuff that allows Nix and Neovim to work together better.

The example code and all that I have provided below are rather basic and doesn't go into much depth which is why I recommended reading the templates and all. I also recommend reading `lib.nix` to see what nvdots is doing e.g. what plugins it's installing, what packages it's exporting and how they're configured etc etc. The `flake.nix` is something you don't really have to mess with since it only exports stuff.

Note that I'm using the default builtin plugin manager provided by Neovim called `packadd` along with auto-commands for lazy-loading and all.

## Home-Manager Module
- First, add nvdots to your Nix flake.
```nix
nvdots = {
  url = "github:Voxi0/nvdots";

  # Use the nixpkgs you defined in your flake
  inputs.nixpkgs.follows = "nixpkgs";
};
```
- Then you can just import the Home Manager module and start using it
```nix
imports = [inputs.nvdots.homeModule];
nvdots = {
  enable = true;

  # This is the name of the stable package
  # Use `unstable` if you want the nightly release of Neovim
  packageNames = ["nvdots"];

  # Add extra plugins on top
  # Use `replace` instead of `merge` to overwrite my configuration
  categoryDefinitions.merge = {...}: {
	# External dependencies e.g. `ripgrep`
	lspsAndRuntimeDeps.general.deps = [pkgs.wakatime-cli];

	# Extra plugins
	optionalPlugins.general.misc = [pkgs.vimPlugins.vim-wakatime];

	# Extra Lua configuration
	optionalLuaAdditions.general = [''
	  -- This is the builtin plugin manager for Neovim
	  vim.cmd.packadd("vim-wakatime")

	  -- Refer to the list of LSPs supported by nvim-lspconfig to figure out you can enable here
	  vim.lsp.enable({ "lua_ls", "nil_ls", "clangd", "zls", "astro" })
	''];
  };
};
```
