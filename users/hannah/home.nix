{ pkgs, ... }: let
  username = "hannah";
in {
  imports = [
    ./quickshell
    ./niri/default.nix
    ./dev.nix
    ./desktop.nix
  ];

  home = {
    sessionPath = [
      "$HOME/.local/bin"
    ];

    packages = with pkgs; [
      vivaldi
      steam
      fastfetch
      discord
      obsidian
      spotify
      playerctl
      teams-for-linux
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "25.11"; # Don't ever change this after the first build.  Don't ask questions.
  };
}
