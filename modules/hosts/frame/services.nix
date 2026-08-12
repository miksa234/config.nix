{ ... }:
{
  dendritic.modules.nixos.frame =
    { ... }:
    {
      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          publish = {
            enable = false;
            userServices = true;
          };
        };
        openssh = {
          enable = false;
          ports = [ 22 ];
          settings = {
            PasswordAuthentication = false;
            KbdInteractiveAuthentication = false;
            PermitRootLogin = "no";
            AllowUsers = [ "mika" ];
          };
        };
        logind.settings.Login = {
          SleepOperation = "suspend-then-hibernate";
          HandlePowerKey = "suspend-then-hibernate";
          HandleLidSwitch = "suspend-then-hibernate";
          HandlePowerKeyLongPress = "poweroff";
        };
        automatic-timezoned.enable = false;
        gvfs.enable = true;
        udisks2.enable = true;
        upower.enable = true;
        fwupd.enable = true;
        tlp.enable = false;
        power-profiles-daemon.enable = true;
      };
    };
}
