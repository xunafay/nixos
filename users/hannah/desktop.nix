{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grim
    swappy
    swaylock
    wl-clipboard
    xwayland-satellite
  ];
}
