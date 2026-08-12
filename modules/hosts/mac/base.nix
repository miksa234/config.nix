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

      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ inputs.yazi.overlays.default ];

    };
}
