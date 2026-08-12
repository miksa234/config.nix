{ ... }:
{
  dendritic.modules.nixos.frame =
    { ... }:
    {
      services = {
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          wireplumber.enable = true;
        };
        getty.autologinUser = "mika";
        logind.settings.Login = {
          SleepOperation = "suspend-then-hibernate";
          HandlePowerKey = "suspend-then-hibernate";
          HandleLidSwitch = "suspend-then-hibernate";
          HandlePowerKeyLongPress = "poweroff";
          IdleAction = "suspend-then-hibernate";
          IdleActionSec = "10m";
        };
      };

      services.libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = false;
          tapping = true;
          clickMethod = "clickfinger";
        };
      };
    };
}
