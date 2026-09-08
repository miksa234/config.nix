{
  description = "NixOS and nix-darwin config using dendritic pattern";
  nixConfig = {
    extra-substituters = [
      "https://yazi.cachix.org"
      "https://niri.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.11";
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    sops-nix.url = "github:Mic92/sops-nix";
    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    yazi.url = "github:sxyazi/yazi";
    dmenu-mac.url = "github:miksa234/dmenu-mac";
    dmenu-wl.url = "github:miksa234/dmenu-wl";
    rift.url = "github:miksa234/rift-flake";
    private-config.url = "git+ssh://git@github.com/miksa234/private-config.nix.git";
    dotfiles = {
      url = "github:miksa234/config";
      flake = false;
    };
    neovim-config = {
      url = "github:miksa234/config.nvim";
      flake = false;
    };
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        (inputs.import-tree ./modules)
        inputs.private-config.flakeModules.default
      ];
    };
}
