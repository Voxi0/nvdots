{
  description = "nvim is cool";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, ...} @ inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [inputs.wrappers.flakeModules.wrappers];

      flake = let
        module = inputs.nixpkgs.lib.modules.importApply ./nvim.nix inputs;
        wrapper = inputs.wrappers.lib.evalModule module;
      in {
        # Overlay with our Neovim package
        overlays.default = final: prev: {
          neovim = wrapper.config.wrap {pkgs = final;};
        };

        # Set wrapper modules - Also exports a package under the same name
        wrappers = {
          default = module;
          neovim = module;
        };
      };

      # Dev stuff
      systems = import inputs.systems;
      perSystem = {
        system,
        pkgs,
        ...
      }: {
        # Configure pkgs instance
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        # Set pkgs instance for all Nix wrapper modules or whatever
        wrappers.pkgs = pkgs;

        # Dev stuff for working on nvdots
        formatter = pkgs.alejandra;
      };
    };
}
