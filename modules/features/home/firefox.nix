{ inputs, ... }:
{
  dendritic.modules.home.firefox =
    { lib, pkgs, ... }:
    let
      homeDir = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/mika" else "/home/mika";
    in
    {
      programs.firefox = {
        enable = true;
        package = pkgs.firefox-bin;
        profiles = {
          frame = {
            id = 0;
            name = "frame";
            isDefault = true;
            settings = {
              "browser.toolbars.bookmarks.visibility" = "always";
              "browser.download.start_downloads_in_tmp_dir" = false;
              "browser.download.lastDir" = homeDir;
            };
          };
        };
      };
    };
}
