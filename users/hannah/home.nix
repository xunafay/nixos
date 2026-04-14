{ inputs, pkgs, ... }: let
  username = "hannah";
in {
  imports = [
    ./quickshell
    ./niri/default.nix
    ./dev.nix
    ./desktop.nix
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
    '';
  };

  programs.niri = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hannah Witvrouwen";
        email = "hannah.witvrouwen@gmail.com";
      };
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
    };
  };

  programs = {
    discord.enable = true;
    vscode.enable = true;
    swappy.enable = true;
  };

  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home = {
    sessionPath = [
      "$HOME/.local/bin"
    ];

    packages = with pkgs; [
      vivaldi
      steam
      bash
      git
      fastfetch
      discord
      vscode
      obsidian
      spotify
      playerctl
      teams-for-linux
    ];

    inherit username;
    homeDirectory = "/home/${username}";

    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.11";
  };
}
