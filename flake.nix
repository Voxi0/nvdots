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

      # Export NixOS and Home Manager modules along with overlays
      flake = let
        # we also export a nixos module to allow reconfiguration from configuration.nix
        nixosModule = utils.mkNixosModules {
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
        # and the same for home manager
        homeModule = utils.mkHomeModules {
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
      in {
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
        nixosModules.default = nixosModule;
        homeModules.default = homeModule;

        inherit nixosModule homeModule;
        inherit (inputs.nixCats) utils;
      };

      # Export packages and create a development environment for all supported platforms
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
        # These outputs are wrapped with `${system}` by `utils.eachSystem`
        # This makes a package for each entry in `packageDefinitions` and sets the default package
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
