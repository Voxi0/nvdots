---
title: Post-Install
description: Things to do after installation
sidebar:
    order: 3
---
There are some important things that nvdots won't configure for you so you can set it up yourself the way you desire instead. Don't worry, it's not that hard promise.

:::note
All external dependencies goes into `extraPackages` field of a spec. This can hold any package that you want only Neovim to be able to find e.g. ripgrep.
:::

## Language servers (LSPs)
LSPs are required for error-checking, autocompletion and a bunch more stuff. Some LSPs even have a built-in formatter that can be used with `vim.lsp.buf_format` though I'd say using an external formatter is better.

Nvdots uses `nvim-lspconfig` which sets up many language servers for you so you can easily start using them out of the box.

Just install some language servers and use `vim.lsp.enable` e.g. `vim.lsp.enable("clangd")`. Check [this site](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) to figure out what language servers are supported and how they're configured by default. You can easily configure any language server to your liking as well, check the docs provided by `nvim-lspconfig` to figure out stuff.

So, let's try setting up Lua language server (LuaLS). Note that `nvim-lspconfig` configures it under `lua_ls` so you need to do `vim.lsp.enable("lua_ls")`. Also to enable multiple language servers, you'd do this, `vim.lsp.enable({"lua_ls", "<another language server>"})`.

```nix
extraPackages = with pkgs; [
    # Lua language server
    lua-language-server
];
specs.general.config = ''
    -- Enable Lua language server
    vim.lsp.enable("lua_ls"})
'';
```

## Formatting
An external formatter may be better than the one included with a LSP in my opinion. [`conform.nvim`](https://github.com/stevearc/conform.nvim) is a popular choice and is very nice and easy to set up. Just install your formatters and then set which formatter should be used for each filetype by configuring `conform.nvim`.

```nix
extraPackages = with pkgs; [
    # Lua formatter
    stylua
];
specs.general = {
    data = with pkgs.vimPlugins; [
        conform-nvim
    ];
    config = ''
        -- lze is used to manage plugins in nvdots but you can use `vim.cmd.packadd` too if you want although it isn't recommended
        require("lze").load({
            {
                "conform.nvim",

                -- conform.nvim will be loaded when you use any of these keybinds
                keys = {
                    -- Format current buffer
                    {
                        "<leader>mp",
                        mode = "n",
                        desc = "Format current buffer",
                        function()
                            require("conform").format()
                        end,
                    }
                },

                -- Set up and configure conform.nvim
                after = function()
                    require("conform").setup({
                        formatters_by_ft = {
                            lua = { "stylua" },
                        },
                    })
                end,
            },
        })
    '';
};
```

## Installing extra plugins
Just add the plugin you wanna install to the data list of the correct specs list and then load+configure it using [lze](https://github.com/BirdeeHub/lze) in the `config` section. Below is an example of adding Wakatime which also has an external dependency - `wakatime-cli` and requires no extra setup or configuration.

```nix
extraPackages = with pkgs; [
    # Required for the Wakatime plugin
    wakatime-cli
];
specs.general = {
    data = with pkgs.vimPlugins; [
        vim-wakatime
    ];
    config = ''
        -- lze is used to manage plugins in nvdots but you can use `vim.cmd.packadd` too if you want although it isn't recommended
        require("lze").load({
        })
    '';
};
```
