{inputs, ...}: {
  flake.lib = let
    inherit (inputs.nixCats) utils;
  in {
    # Path to `init.lua`
    luaPath = ./.;

    # Extra configuration for nixpkgs
    # Won't apply to module imports as that holds your system values
    extraPkgConfig.allowUnfree = true;

    # Overlays added to nixpkgs
    dependencyOverlays = [
      # Grabs all flake inputs named in the format -> `plugins-<plugin name>`
      # This allows us to use our custom plugins through `pkgs.neovimPlugins`
      (utils.standardPluginOverlay inputs)

      # Run this function on an overlay if it's wrapped with system
      # This checks if the system in the set is available and returns the desired overlay if so
      # (utils.fixSystemizedOverlay inputs.codeium.overlays
      #   (system: inputs.codeium.overlays.${system}.default)
      # )
    ];

    # Categories that can be enabled/disabled
    categoryDefinitions = {pkgs, ...} @ packageDef: {
      # Dependencies that should be available at runtime for plugins
      # Will be available to PATH within the Neovim terminal including LSPs
      lspsAndRuntimeDeps = {
        general = {
          # Dependencies
          deps = with pkgs; [
            ripgrep
          ];

          # Language servers
          lsp = with pkgs; [
            lua-language-server
          ];

          # Treesitter grammars for syntax highlighting
          treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
            c
            nix
            lua
          ];
        };
      };

      # Plugins that are loaded at startup without using packadd
      startupPlugins = {
        general = {
          qualityOfLife = with pkgs.vimPlugins; [snacks-nvim];
          misc = with pkgs.vimPlugins; [cord-nvim];
        };
      };

      # Plugins that aren't loaded automatically at startup
      # Use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = {
          ui = with pkgs.vimPlugins; [
            # Theme, icons and statusline
            nightfox-nvim
            mini-icons
            lualine-nvim
          ];
          core = with pkgs.vimPlugins; [
            # Syntax highlighting and autocompletion
            nvim-treesitter
            blink-cmp
          ];
          qualityOfLife = with pkgs.vimPlugins; [
            # Shows available keymaps as you type
            which-key-nvim

            # File explorer and picker
            mini-files
            mini-pick

            # Quality of life
            nvim-ufo
            mini-pairs
            mini-surround
            mini-sessions
          ];
        };
      };
    };

    # Define packages with specific categories of plugins enabled
    # Basically variants of your configuration I guess
    defaultPkgName = "nvdots";
    packageDefinitions = let
      settings = {
        suffix-path = true;
        suffix-LD = true;
        wrapRc = true;

        # Ensure your alias doesn't conflict with your other packages.
        aliases = ["nvim"];
      };

      # Set of categories that you want and other information to pass to Lua
      categories = {
        general = true;
      };
    in {
      # Stable
      nvdots = {pkgs, ...}: {inherit categories settings;};

      # Nightly release (Unstable)
      unstable = {pkgs, ...}: {
        inherit categories;
        settings =
          settings
          // {
            neovim-unwrapped = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
          };
      };
    };
  };
}
