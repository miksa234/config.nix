{ ... }:
{
  dendritic.modules.home.packages-system = { pkgs, ... }: {
    home.packages = with pkgs; [
      home-manager
      nix
      just
      htop
      sops
      direnv
    ];
  };

  dendritic.modules.home.packages-shell = { pkgs, ... }: {
    home.packages = with pkgs; [
      gnupg
      zsh
      zsh-fast-syntax-highlighting
      zsh-system-clipboard
      tmux
      neovim
    ];
  };

  dendritic.modules.home.packages-cli = { pkgs, ... }: {
    home.packages = with pkgs; [
      (pass.withExtensions (exts: [ exts.pass-otp ]))
      ripgrep
      git
      fzf
      wget
      curl
      tree
      fd
      zip
      unzip
      bzip2
      killall
      zbar
      pstree
      bat
      gptfdisk
      qrencode
      jq
      lazygit
    ];
  };
}
