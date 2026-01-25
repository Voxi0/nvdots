{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    nixCats,
    ...
  } @ inputs: let
    inherit (nixCats) utils;
    forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;

    # Where your Lua files are for Neovim
    luaPath = ./.;

    # Extra configuration for nixpkgs
    # Won't apply to module imports as that holds your system values
    extra_pkg_config.allowUnfree = true;

    dependencyOverlays = [
      # Grab all flake inputs named in the format -> `plugins-<plugin name>`
      # This overlay is added to nixpkgs so we can use the custom plugins from `pkgs.neovimPlugins`
      (utils.standardPluginOverlay inputs)

      # Run this function on an overlay if it's wrapped with system
      # This checks if the system in the set is available and returns the desired overlay if so
      # (utils.fixSystemizedOverlay inputs.codeium.overlays
      #   (system: inputs.codeium.overlays.${system}.default)
      # )
    ];

    categoryDefinitions = {
      pkgs,
      settings,
      categories,
      extra,
      name,
      mkPlugin,
      ...
    } @ packageDef: {
      # Dependencies that should be available at runtime for plugins
      # Will be available to PATH within the Neovim terminal including LSPs
      lspsAndRuntimeDeps = {
        general = with pkgs;
          [
            # Language servers
            lua-language-server

            # Extra dependencies
            ripgrep
          ]
          ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
            # Treesitter grammars for syntax highlighting
            c
            nix
            lua
          ]);
      };

      # Plugins that are loaded at startup without using packadd
      startupPlugins = {
        general = with pkgs.vimPlugins; [
          # Quality of life
          snacks-nvim

          # Miscellaneous
          cord-nvim
        ];
      };

      # Plugins that aren't loaded automatically at startup
      # Use with packadd and an autocommand in config to achieve lazy loading
      optionalPlugins = {
        general = with pkgs.vimPlugins; [
          # Theme, icons and statusline
          nightfox-nvim
          mini-icons
          lualine-nvim

          # Syntax highlighting and autocompletion
          nvim-treesitter
          blink-cmp

          # Shows available keymaps as you type
          which-key-nvim

          # File explorer and picker
          mini-files
          mini-pick

          # Quality of life
          nvim-ufo
          mini-pairs
          mini-surround
        ];
      };

      # Shared libraries to be added to LD_LIBRARY_PATH variable available to Neovim runtime
      sharedLibraries = {
        general = with pkgs; [];
      };

      # Environment variables that should be available at runtime for plugins
      # Will be available to path within the Neovim terminal
      environmentVariables = {};

      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
      extraWrapperArgs = {};

      # List of functions you would have passed to `python.withPackages` or `lua.withPackages`
      # Don't forget to set `hosts.python3.enable` in package settings
      # Get the path to this Python environment in your Lua config via `vim.g.python3_host_prog`
      # Or run the following command in the Neovim terminal `:!<packagename>-python3`
      python3.libraries = {};

      # Populates $LUA_PATH and $LUA_CPATH
      extraLuaPackages = {};
    };

    # Default package entry to use from `packageDefinitions`
    defaultPackageName = "unstable";

    # Build packages with specific categories from above here
    # This entire set is also passed to nixCats for querying within Lua
    packageDefinitions = let
      mkNvimPackage = neovimPkg: {
        settings = {
          neovim-unwrapped = neovimPkg;
          suffix-path = true;
          suffix-LD = true;
          wrapRc = true;

          # Ensure your alias doesn't conflict with your other packages.
          aliases = ["vi" "vim"];
        };

        # Set of categories that you want and other information to pass to Lua
        categories = {
          general = true;
        };
      };
    in {
      stable = {
        pkgs,
        name,
        ...
      }:
        mkNvimPackage pkgs.neovim-unwrapped;
      unstable = {
        pkgs,
        name,
        ...
      }:
        mkNvimPackage inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
    };
  in
    forEachSystem (system: let
      nixCatsBuilder =
        utils.baseBuilder luaPath {
          inherit nixpkgs system dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions;
      defaultPackage = nixCatsBuilder defaultPackageName;
      # This is for using utils such as `pkgs.mkShell`
      # The one used to build Neovim is resolved inside the builder and is passed to our `categoryDefinitions` and `packageDefinitions`
      pkgs = import nixpkgs {inherit system;};
    in {
      # These outputs will be wrapped with `${system}` by `utils.eachSystem`
      # This will make a package out of each of the `packageDefinitions` defined above  and set the default package to the one passed in here
      packages = utils.mkAllWithDefault defaultPackage;

      # Choose your package for the devShell and add whatever else you want in it
      devShells = {
        default = pkgs.mkShell {
          name = defaultPackageName;
          packages = [defaultPackage];
          inputsFrom = [];
          shellHook = ''
          '';
        };
      };
    })
    // (let
      # Export a NixOS and Home Manager module
      nixosModule = utils.mkNixosModules {
        moduleNamespace = [defaultPackageName];
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
      homeModule = utils.mkHomeModules {
        moduleNamespace = [defaultPackageName];
        inherit
          defaultPackageName
          dependencyOverlays
          luaPath
          categoryDefinitions
          packageDefinitions
          extra_pkg_config
          nixpkgs
          ;
      };
    in {
      # These outputs will not be wrapped with `${system}`
      # This will make an overlay out of each of the `packageDefinitions` defined above and set the default overlay to the one named here
      overlays =
        utils.makeOverlays luaPath {
          inherit nixpkgs dependencyOverlays extra_pkg_config;
        }
        categoryDefinitions
        packageDefinitions
        defaultPackageName;

      nixosModules.default = nixosModule;
      homeModules.default = homeModule;

      inherit utils nixosModule homeModule;
      inherit (utils) templates;
    });
}
