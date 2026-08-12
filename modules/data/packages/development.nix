{ ... }:
{
  dendritic.modules.home.packages-development = { pkgs, ... }: {
    home.packages = with pkgs; [
      gh
      zig
      tree-sitter
      python313Packages.tiktoken
      python313Packages.pylatexenc
      luajitPackages.jsregexp
      nil
      marksman
      nodejs
      pnpm
      cmake
      gnumake
      gcc
      luarocks
      javaPackages.compiler.openjdk17
      lua5_1
      go
      ruby
      php
      julia-bin
      python3
      python313Packages.pip
      rustup
      azure-cli
    ];
  };
}
