{ lib, pkgs, config, ... }: let
  username = "hannah";
in {
  imports = [
    ./home/quickshell
    ./home/niri/default.nix
  ];
  
  programs.bash = {
    enable = true;
    bashrcExtra = ''
    '';
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

  home = {
    packages = with pkgs; [
      vivaldi
      steam
      neovim
      bash
      git
      fastfetch
      discord
      discordo
      vscode
      grim
      swappy

      # quickshell deps
      quickshell
      qt6Packages.qt5compat
      libsForQt5.qt5.qtgraphicaleffects
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtstyleplugin-kvantum
      wallust
     
      # Niri
      xwayland-satellite
      wl-clipboard
      swaylock

      #uh
      networkmanagerapplet
    ];


    # This needs to actually be set to your username
    inherit username;
    homeDirectory = "/home/${username}";


    # You do not need to change this if you're reading this in the future.
    # Don't ever change this after the first build.  Don't ask questions.
    stateVersion = "25.11";
  };
}
