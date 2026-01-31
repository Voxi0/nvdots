inputs: {
  lib,
  config,
  wlib,
  pkgs,
  ...
}: {
  imports = [wlib.wrapperModules.neovim];

  # Module options
  options = {
    nvim-lib = {
      neovimPlugins = lib.mkOption {
        readOnly = true;
        type = lib.types.attrsOf wlib.types.stringable;

        # Build all plugins in `inputs`
        # They can be accessed later via `config.nvim-lib.neovimPlugins.<name_without_prefix>`
        default = config.nvim-lib.pluginsFromPrefix "plugins-" inputs;
      };

      # Build a plugin from it's prefix
      pluginsFromPrefix = lib.mkOption {
        type = lib.types.raw;
        readOnly = true;
        default = prefix: inputs:
          lib.pipe inputs [
            builtins.attrNames
            (builtins.filter (s: lib.hasPrefix prefix s))
            (map (
              input: let
                name = lib.removePrefix prefix input;
              in {
                inherit name;
                value = config.nvim-lib.mkPlugin name inputs.${input};
              }
            ))
            builtins.listToAttrs
          ];
      };
    };

    settings = {
      # Tell Lua which top-level specs are enabled
      cats = lib.mkOption {
        readOnly = true;
        type = lib.types.attrsOf lib.types.bool;
        default = builtins.mapAttrs (_: v: v.enable) config.specs;
      };
    };
  };

  # Configuration
  config = {
    # Lua config directory
    # Can be an impure path so it won't be managed by Nix allowing normal reload for quick edits
    settings.config_directory = ./.;
    # settings.config_directory = lib.generators.mkLuaInline "vim.fn.stdpath('config')";
    # settings.config_directory = "/home/<USER>/.config/nvim";

    # Uncomment this to allow installing multiple Neovim derivations without path collisions
    # settings.dont_link = true;

    # Also ensure these don't share values
    # binName = "nvim";
    # settings.aliases = [ ];

    # Plugins
    specs.general = {
      extraPackages = with pkgs; [ripgrep];
      data = with pkgs.vimPlugins; [
        # Theme, icons and statusline
        nightfox-nvim
        mini-icons
        lualine-nvim

        # Syntax highlighting, LSP and autocompletion
        nvim-treesitter
        nvim-lspconfig
        blink-cmp

        # Shows available keymaps as you type
        which-key-nvim

        # File explorer and picker
        mini-files
        mini-pick

        # Quality of life
        nvim-ufo
        snacks-nvim
        mini-pairs
        mini-surround
        mini-sessions

        # Render markdown
        render-markdown-nvim

        # Discord rich presence
        cord-nvim
      ];
    };

    # This submodule modifies both levels of your specs
    extraPackages = config.specCollect (acc: v: acc ++ (v.extraPackages or [])) [];
    specMods = {
      # When this module is ran in an inner list,
      # this will contain `config` of the parent spec
      parentSpec ? null,
      # And this will contain `options`, otherwise `null`
      parentOpts ? null,
      parentName ? null,
      # And then config from this one, as normal
      config,
      ...
    }: {
      # This can be used to change defaults for the specs
      options.extraPackages = lib.mkOption {
        type = lib.types.listOf wlib.types.stringable;
        default = [];
        description = "a extraPackages spec field to put packages to suffix to the PATH";
      };
    };
  };
}
