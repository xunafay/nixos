{ config, lib, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  quickshellDir = "${homeDir}/home-os/home/quickshell/qml";
  quickshellTarget = "${homeDir}/.config/quickshell";
  faceIconSource = "${homeDir}/home-os/assets/profile.png";
  faceIconTarget = "${homeDir}/.face.icon";
in {
  home.activation.symlinkQuickshellAndFaceIcon = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "${quickshellDir}" "${quickshellTarget}"
    ln -sfn "${faceIconSource}" "${faceIconTarget}"
  '';
}
