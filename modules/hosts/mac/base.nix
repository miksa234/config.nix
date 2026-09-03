{ inputs, ... }:
{
  dendritic.modules.darwin.mac =
    {
      ...
    }:
    {
      system.stateVersion = 5;

      environment.variables = {
        __ETC_ZSHRC_SOURCED = "1";
        __ETC_ZSHENV_SOURCED = "1";
      };

      programs = {
        zsh.enable = true;
        gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
        };
      };

      security.pam.services.sudo_local = {
        touchIdAuth = true;
        reattach = true;
      };

      power.sleep = {
        computer = 30;
        display = 10;
        harddisk = 10;
      };

      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.yazi.overlays.default ];

    };
}
