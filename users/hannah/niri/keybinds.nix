{ lib, config, pkgs, ... }:

let
  apps = import ./applications.nix { inherit pkgs; };

in {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    pactl = "${pkgs.pulseaudio}/bin/pactl";
    grim = "${pkgs.grim}/bin/grim";
    satty = "${pkgs.satty}/bin/satty";
    slurp = "${pkgs.slurp}/bin/slurp";

    volume-up = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "+5%" ];
    volume-down = spawn pactl [ "set-sink-volume" "@DEFAULT_SINK@" "-5%" ];
    brightness-up = spawn "sh" [ "brightness" "up" ];
    brightness-down = spawn "sh" [ "brightness" "down" ];
    screenshot = spawn "sh" [ "-c" "${grim} -g \"$(${slurp})\" - | ${satty} -f -" ];
  in {
    "super+Return".action = spawn ["qs" "ipc" "call" "globalIPC" "toggleLauncher"];
    "super+Space".action = spawn ["qs" "ipc" "call" "globalIPC" "toggleStatusMenu"];
    "super+l".action = spawn ["qs" "ipc" "call" "globalIPC" "toggleLock"];

    "xf86audioraisevolume".action = volume-up;
    "xf86audiolowervolume".action = volume-down;
    "xf86monbrightnessup".action = brightness-up;
    "xf86monbrightnessdown".action = brightness-down;
    "control+super+xf86audioraisevolume".action = spawn "brightness" "up";
    "control+super+xf86audiolowervolume".action = spawn "brightness" "down";

    "super+q".action = close-window;
    "super+b".action = spawn apps.browser;
    #"super+Return".action = spawn apps.terminal;
    #"super+Control+Return".action = spawn apps.appLauncher;
    "super+E".action = spawn apps.fileManager;

    "super+f".action = fullscreen-window;
    "super+t".action = toggle-window-floating;

    "super+shift+s".action = screenshot;
    #"control+shift+2".action = screenshot-window { write-to-disk = true; };


    "super+Left".action = focus-column-left;
    "super+Right".action = focus-column-right;
    "super+Down".action = focus-workspace-down;
    "super+Up".action = focus-workspace-up;

    "super+Shift+Left".action = move-column-left;
    "super+Shift+Right".action = move-column-right;
    "super+Shift+Down".action = move-column-to-workspace-down;
    "super+Shift+Up".action = move-column-to-workspace-up;

    # Window resizing
    "super+Control+Left".action = set-column-width "-10%";
    "super+Control+Right".action = set-column-width "+10%";
    "super+Control+Down".action = set-window-height "-10%";
    "super+Control+Up".action = set-window-height "+10%";

    # Reset window size
    "super+Control+r".action = set-column-width "50%";

    "super+1".action = focus-workspace "browser";
    "super+2".action = focus-workspace "vesktop";
  };
}
