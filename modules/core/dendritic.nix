{ inputs, ... }:
{
  options.dendritic = with inputs.nixpkgs.lib; {
    modules = {
      nixos = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = { };
        description = "Registry of reusable NixOS modules.";
      };

      darwin = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = { };
        description = "Registry of reusable nix-darwin modules.";
      };

      home = mkOption {
        type = types.lazyAttrsOf types.deferredModule;
        default = { };
        description = "Registry of reusable Home Manager modules.";
      };
    };

    data = mkOption {
      type = types.lazyAttrsOf types.raw;
      default = { };
      description = "Registry of shared non-module data.";
    };

    configurations = {
      nixos = mkOption {
        type = types.lazyAttrsOf (
          types.submodule {
            options = {
              module = mkOption {
                type = types.deferredModule;
                description = "NixOS module composition for this host.";
              };

              system = mkOption {
                type = types.str;
                description = "Target system for the generated NixOS configuration.";
              };
            };
          }
        );
        default = { };
        description = "NixOS host compositions.";
      };

      darwin = mkOption {
        type = types.lazyAttrsOf (
          types.submodule {
            options = {
              module = mkOption {
                type = types.deferredModule;
                description = "Darwin module composition for this host.";
              };

              system = mkOption {
                type = types.str;
                description = "Target system for the generated Darwin configuration.";
              };
            };
          }
        );
        default = { };
        description = "Darwin host compositions.";
      };

      home = mkOption {
        type = types.lazyAttrsOf (
          types.submodule {
            options = {
              module = mkOption {
                type = types.deferredModule;
                description = "Home Manager module composition for this profile.";
              };

              system = mkOption {
                type = types.str;
                description = "Target system for the generated Home Manager configuration.";
              };

            };
          }
        );
        default = { };
        description = "Home Manager profile compositions.";
      };
    };
  };
}
