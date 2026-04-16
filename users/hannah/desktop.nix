{ pkgs, ... }:
{
  programs = {
    niri.enable = true;
    discord.enable = true;
  };
 
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  home.packages = with pkgs; [
    grim
    slurp
    satty
    swaylock
    wl-clipboard
    xwayland-satellite
    dconf
    gsettings-desktop-schemas
    wl-mirror
  ];
}
