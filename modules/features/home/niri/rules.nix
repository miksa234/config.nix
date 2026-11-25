{ ... }:
{
  dendritic.modules.home.niri = {
    programs.niri.settings = {
      window-rules = [
        {
          matches = [ { app-id = "Spotify"; } ];
          open-on-workspace = "r5";
          open-maximized = true;
        }
        {
          matches = [ { app-id = "ghostty"; } ];
          opacity = 0.96;
        }
        {
          matches = [ { app-id = "firefox"; } ];
          open-maximized = true;
        }
        {
          matches = [ { app-id = "telegram"; } ];
          open-maximized = true;
        }
      ];

      layer-rules = [
        {
          matches = [ { namespace = "^noctalia-backdrop"; } ];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
