{ ... }:
{
  dendritic.modules.home.launchd-services =
    { config, ... }:
    {
      launchd.agents.dmenu-mac-clipboard = {
        enable = true;
        config = {
          Label = "com.mika.dmenu-mac-clipboard";
          ProgramArguments = [
            "${config.home.path}/bin/dmenu-mac-clipboard-watch"
          ];
          RunAtLoad = true;
          KeepAlive = true;
          ProcessType = "Background";
        };
      };
    };
}
