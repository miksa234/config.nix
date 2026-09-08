{
  config,
  inputs,
  lib,
  ...
}:
let
  configurations = config.dendritic.configurations;
in
{
  config.flake = {
    nixosConfigurations = lib.mapAttrs (_: target:
      inputs.nixpkgs.lib.nixosSystem {
        system = target.system;
        specialArgs = { inherit inputs; };
        modules = [ target.module ];
      }
    ) configurations.nixos;

    darwinConfigurations = lib.mapAttrs (_: target:
      inputs.nix-darwin.lib.darwinSystem {
        system = target.system;
        specialArgs = { inherit inputs; };
        modules = [ target.module ];
      }
    ) configurations.darwin;

    homeConfigurations = lib.mapAttrs (_: target:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = import inputs.nixpkgs {
          system = target.system;
          config.allowUnfree = true;
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [ target.module ];
      }
    ) configurations.home;
  };

  config.perSystem = { system, ... }: {
    checks =
      (lib.mapAttrs' (name: _:
        lib.nameValuePair "nixos-${name}" config.flake.nixosConfigurations.${name}.config.system.build.toplevel
      ) (lib.filterAttrs (_: target: target.system == system)
        configurations.nixos))
      // (lib.mapAttrs' (name: _:
        lib.nameValuePair "home-${name}" config.flake.homeConfigurations.${name}.activationPackage
      ) (lib.filterAttrs (_: target: target.system == system)
        configurations.home))
      // (lib.mapAttrs' (name: _:
        lib.nameValuePair "darwin-${name}" config.flake.darwinConfigurations.${name}.system
      ) (lib.filterAttrs (_: target: target.system == system)
        configurations.darwin));
  };
}
