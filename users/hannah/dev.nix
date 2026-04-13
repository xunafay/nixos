{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )
    cargo
    rustc
    nodejs_24
    gcc
    tree-sitter
    ripgrep
    unzip
    fd
    gh
  ];
}
