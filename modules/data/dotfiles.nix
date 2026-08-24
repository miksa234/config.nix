{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "dc7b6147c5a348411de05de7958c6233e735df10";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "9e8b73daa6a7f49ce59d0356e77712fa10eec912";
    };
  };
}
