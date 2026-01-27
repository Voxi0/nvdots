<h1 align="center">nvdots</h1>

This is my personal [Neovim](https://neovim.io/) configuration.

## How it works

- [nixCats](https://nixcats.org/) - The package manager which focuses on
  allowing one to manage plugins and other dependencies for Neovim in Nix. This
  way, all dependencies are downloaded by Nix while Neovim is configured in Lua.
  Check the website to learn why it would be better compared to alternatives
  such as [NVF](https://github.com/notAShelf/nvf) and
  [Nixvim](https://github.com/nix-community/nixvim)

## How to add your own plugins

Depends on how you're using nvdots really. Forking or cloning this
repository is a dead-simple approach.

### If you're forking or cloning this repo or whatever

Also remember to commit your changes and all if you create a new file since
Nix ignores any files that haven't been committed yet.

- Modify `lib.nix` to mess with the plugins and packages and everything. You
can pretty much completely ignore `flake.nix`
- Create a new Lua file or use an existing file inside of `lua/plugins` to
load and configure your plugins. Take a look at how I'm adding and configuring
plugins to understand how you can do it. Reminder that it's only `optionalPlugins`
that you use `packadd` on.

## If you're using NixOS/Home-Manager module

- Add `nvdots` to flake inputs of course
```nix
nvdots = {
  url = "git+https://tangled.org/voxi0.tngl.sh/nvdots";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
- Import either NixOS or Home-Manager module. NixOS module is `inputs.nvdots.nixosModules.default`
and for Home-Manager `inputs.nvdots.homeModules.default`. Change `default` to something else to
use another package exported by the flake I guess.
- Configure nvdots however you want using the module. Here's an example where I add a simple
plugin on top of nvdots. You can also replace `merge` with `replace` if you want to completely
override stuff and do your own thing.
```nix
imports = [self.inputs.nvdots.homeModules.default];
<name of the neovim package you're installing> = {
  enable = true;
  categoryDefinitions.merge = {pkgs, ...} @ packageDef: {
	optionalPlugins = {
	  general.misc = [pkgs.vimPlugins.vim-wakatime];
	};
	optionalLuaAdditions = {
	  general = [
		"vim.cmd.packadd('vim-wakatime')"
	  ];
	};
  };
};
```
