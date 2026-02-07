<h1 align="center">nvdots</h1>

neovim distro for nix users using [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules). read the [docs](https://nvdots.pages.dev/) to learn more. please note that the docs are still a WIP and i'm yet to document all the plugins/specs, keybindings, autocommands and such.

## try it
first install Nix and then run the following command to temporarily try out nvdots. it looks complex because the two lines after `nix run` is making sure that cachix is being used or else you'd have to compile neovim and it's plugins and all from source which would take a while. binary caches are far more faster and convenient.
```bash
nix run github:Voxi0/nvdots \
    --extra-trusted-public-keys nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs \
    --extra-substituters https://nix-community.cachix.org
```

i will soon find a way to allow non-nix users to use nvdots even though nvdots is primarily meant for nix users :)

# acknowledgements
- [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules) - For making it nice and easy to wrap Neovim with plugins and Lua configuration duh. this way I can keep nix and neovim stuff separate so I have the ability to make my configuration cross-platform even WITHOUT nix sooner or later in the future. but i mean right now, all of this is still cross-platform as long as you have nix installed of course.
- [nvim-lite](https://github.com/radleylewis/nvim-lite) - For showing how to do a whole lot of things natively without any plugins. I discovered a bunch of useful options and handy autocommands thanks to this.
