{
  description = "my personal neovim configuration using nixCats";
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} (let
      inherit (inputs.nixCats) utils;
    in {
      imports = [./lib.nix];

      flake = {
        # These outputs will not be wrapped with `${system}`
        # This will make an overlay out of each of the `packageDefinitions` defined above and set the default overlay to the one named here
        overlays =
          utils.makeOverlays self.lib.luaPath {
            inherit nixpkgs;
            inherit (self.lib) dependencyOverlays extraPkgConfig;
          }
          self.lib.categoryDefinitions
          self.lib.packageDefinitions
          self.lib.defaultPkgName;

        # Export NixOS and Home Manager modules
        nixosModules.default = utils.mkNixosModules {
          moduleNamespace = [self.lib.defaultPkgName];
          inherit nixpkgs;
          inherit
            (self.lib)
            defaultPkgName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extraPkgConfig
            ;
        };
        homeModules.default = utils.mkHomeModules {
          moduleNamespace = [self.lib.defaultPkgName];
          inherit nixpkgs;
          inherit
            (self.lib)
            defaultPkgName
            dependencyOverlays
            luaPath
            categoryDefinitions
            packageDefinitions
            extraPkgConfig
            ;
        };
      };

      # Export packages and create a development environment for all platforms
      systems = import inputs.systems;
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        # Build default package
        defaultPackage = nixCatsBuilder self.lib.defaultPkgName;

        # Builder function
        nixCatsBuilder =
          utils.baseBuilder self.lib.luaPath {
            inherit nixpkgs system;
            inherit (self.lib) dependencyOverlays extraPkgConfig;
          }
          self.lib.categoryDefinitions
          self.lib.packageDefinitions;
      in {
        # These outputs will be wrapped with `${system}` by `utils.eachSystem`
        # This makes a package of each entry in `packageDefinitions` and sets the default package to the one passed in here
        packages = utils.mkAllWithDefault defaultPackage;

        # Development environment
        formatter = pkgs.stylua;
        devShells.default = pkgs.mkShellNoCC {
          name = self.lib.defaultPkgName;
          packages = [defaultPackage];
        };
      };
    });
}
