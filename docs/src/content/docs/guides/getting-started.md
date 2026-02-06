---
title: Getting Started
description: What nvdots is and how it works
sidebar:
    order: 1
---
## How it works
nvdots uses [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules/) to wrap Neovim with plugins and configuration so I recommend taking a look at [it's docs](https://birdeehub.github.io/nix-wrapper-modules/). This will teach you how nvdots works under the hood which will give you the power to configure it to your liking.

The flake exports an overlay that replaces `pkgs.neovim` with nvdots and one package that you can directly install from the flake (see installation). It's nothing worth looking at since it only handles making nvdots usable. But do take a look at `nvim.nix` as it defines the nvdots package itself. Here you can see all the specs with their plugins, external dependencies e.g. `ripgrep` and whatnot along other additional settings. You WILL need to know what specs are available so you can effectively configure nvdots to your liking.

Nix is in charge of downloading plugins and everything else while [lze](https://github.com/BirdeeHub/lze) handles lazy-loading and configuring plugins. Please read the README of lze as it's required so you can actually load+configure your own plugins. You can use `vim.cmd.packadd()` instead but that's not recommended really, to each their own though I won't judge.

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
Inside of the `plugins/` directory duh.
- `core.lua` - Configures super important plugins e.g. Treesitter for syntax-highlighting, `nvim-lspconfig` for LSP and `blink.cmp` for autocompletion.
- `ui.lua` - Configures UI focused plugins e.g. the colorscheme, icon pack, Lualine and Noice.
- `useful.lua` - Just a bunch of useful plugins e.g. Fyler for managing files, autopairing with nvim-autopairs, code folding with nvim-ufo etc.
- `snacks.lua` - Configures snacks.nvim to provide a dashboard, indent guides, picker for files and grep, LazyGit integration and more.
- `mini.lua` - Configures a bunch of handy quality-of-life plugins from [mini.nvim](https://nvim-mini.org/mini.nvim/) to enhance your editing experience.
