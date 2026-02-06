---
title: Getting Started
description: How nvdots works under the hood
sidebar:
    order: 1
---
## How it works
nvdots uses [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules/) to wrap Neovim with plugins and configuration and [lze](https://github.com/BirdeeHub/lze) for loading and configuring plugins. This way, Nix is only used for downloading Neovim and anything it needs e.g. plugins while the entire configuration can remain in Lua.

The flake exports an overlay that replaces `pkgs.neovim` with nvdots and one package that you can directly install from the flake (see installation). It's nothing worth looking at since it only handles making nvdots usable. But do take a look at `nvim.nix` as it defines the nvdots package itself.

:::note
It's best you read through the docs for [nix-wrapper-modules](https://birdeehub.github.io/nix-wrapper-modules/) and [lze](https://github.com/BirdeeHub/lze) since you can't really customize nvdots without knowing atleast the basics.

Afterwards, read through [`nvim.nix`](https://github.com/Voxi0/nvdots/blob/main/nvim.nix) to understand how it works, what it has and all so you can figure out stuff like which specs to configure to get what you want.
:::

## Project structure
### Base
- `flake.nix` - Exports the overlay and packages
- `nvim.nix` - The package itself
- `init.lua` - Imports all Lua files and calls `lze` to load all plugins

### Lua
All Lua modules are inside `lua/` obviously.

#### General
- `ui.lua` - Adjusts visual settings e.g. line numbers, scrolloff, text wrapping etc.
- `general.lua` - Defines a bunch of useful autocommands and adjusts code-folding, searching, file handling and other miscellaneous things e.g. mouse support.
- `mappings.lua` - Sets a bunch of useful keybinds e.g. binds to goto next/previous buffer and delete current buffer.

#### Plugins
Inside of the `lua/plugins/` directory duh.
- `core.lua` - Configures super important plugins e.g. Treesitter for syntax-highlighting, `nvim-lspconfig` for LSP and `blink.cmp` for autocompletion.
- `ui.lua` - Configures UI focused plugins e.g. the colorscheme, icon pack, Lualine and Noice.
- `useful.lua` - Just a bunch of useful plugins e.g. Fyler for managing files, autopairing with nvim-autopairs, code folding with nvim-ufo etc.
- `snacks.lua` - Configures snacks.nvim to provide a dashboard, indent guides, picker for files and grep, LazyGit integration and more.
- `mini.lua` - Configures a bunch of handy quality-of-life plugins from [mini.nvim](https://nvim-mini.org/mini.nvim/) to enhance your editing experience.
