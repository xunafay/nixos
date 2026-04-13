{ config, lib, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  quickshellDir = "${homeDir}/home-os/users/hannah/quickshell/qml";
  quickshellTarget = "${homeDir}/.config/quickshell";
  faceIconSource = "${homeDir}/home-os/users/hannah/assets/profile.png";
  faceIconTarget = "${homeDir}/.face.icon";
in {
  home.packages = with pkgs; [
    quickshell
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    wallust
    bc
  ];

  home.activation.symlinkQuickshellAndFaceIcon = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "${quickshellDir}" "${quickshellTarget}"
    ln -sfn "${faceIconSource}" "${faceIconTarget}"
  '';
}
