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
    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;
    settings = {
      # Lua config directory
      # Can be an impure path so it won't be managed by Nix allowing normal reload for quick edits
      config_directory = ./.;

      # Uncomment this to allow installing multiple Neovim derivations without path collisions
      # dont_link = true;

      # Also ensure these don't share values
      # binName = "nvim";
      # settings.aliases = [ ];
    };

    # Plugins
    specs.general = {
      lazy = true;
      extraPackages = with pkgs; [
        # For finding files - Modern replacement for `find`
        fd

        # For finding files containing specific text
        ripgrep

        # For `snacks.images`
        ghostscript # To render PDF files
        tectonic # To render LaTeX math expressions
        mermaid-cli # To render Mermaid diagrams
      ];
      data = with pkgs.vimPlugins; [
        # UI
        catppuccin-nvim
        mini-icons
        lualine-nvim
        mini-animate
        bufferline-nvim

        # Syntax highlighting + code structure, LSP, autocompletion and formatter
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-lspconfig
        blink-cmp
        conform-nvim

        # Shows available keymaps as you type
        which-key-nvim

        # File explorer and picker
        mini-files
        mini-pick

        # Quality of life
        nvim-ufo
        snacks-nvim
        nvim-autopairs
        mini-surround
        mini-sessions
        live-preview-nvim
        nvim-ts-autotag

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
