{ config, pkgs, ... }:

let
  brightnessScript = pkgs.writeShellScriptBin "brightness" ''
    STEP=5
    OSD_FILE="/tmp/brightness_osd_level"

    if [[ "$1" == "up" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl set "+''${STEP}%"
    elif [[ "$1" == "down" ]]; then
      ${pkgs.brightnessctl}/bin/brightnessctl set "''${STEP}%-"
    else
      exit 1
    fi

    current=$(${pkgs.brightnessctl}/bin/brightnessctl get)
    max=$(${pkgs.brightnessctl}/bin/brightnessctl max)
    percentage=$(( current * 100 / max ))
    echo "$percentage" > "$OSD_FILE"
  '';
in
{
  home.packages = [
    brightnessScript
  ];
}
