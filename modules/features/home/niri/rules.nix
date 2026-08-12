{ ... }:
{
  dendritic.data.niriRules = [
    {
      matches = [ { app-id = "spotify"; } ];
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
    {
      matches = [ { app-id = "dev.noctalia.Noctalia"; } ];
      open-floating = true;
      default-column-width = { fixed = 1080; };
      default-window-height = { fixed = 920; };
    }
  ];

  dendritic.data.niriLayerRules = [
    {
      matches = [ { namespace = "^noctalia-backdrop"; } ];
      place-within-backdrop = true;
    }
  ];
}
