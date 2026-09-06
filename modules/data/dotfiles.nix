{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "94ddce846c7f07fae282d5daee043018543271f6";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "9e8b73daa6a7f49ce59d0356e77712fa10eec912";
    };
  };
}
