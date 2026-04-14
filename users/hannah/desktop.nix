{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    slurp
    satty
    swaylock
    wl-clipboard
    xwayland-satellite
    dconf
    gsettings-desktop-schemas
  ];
}
