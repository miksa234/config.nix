{ ... }:
{
  dendritic.data.dotfiles = {
    configDots = builtins.fetchGit {
      url = "https://github.com/miksa234/config.git";
      ref = "main";
      rev = "23ae292558fbecd6a069cf70f4af0b9a46101c09";
    };

    configNvim = builtins.fetchGit {
      url = "https://github.com/miksa234/config.nvim.git";
      ref = "main";
      rev = "69e2f90a16189641af8a27d46cedc8fed531a8d3";
    };
  };
}
