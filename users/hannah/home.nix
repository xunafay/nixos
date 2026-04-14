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
    aliases = {
      graph = "log --graph --oneline --all";
      default-branch = "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'";
      merge-base-origin = "!f() { git merge-base \${1-HEAD} origin/$(git default-branch); };f ";
      push-stepped = builtins.readFile ./git/push-stepped.sh;
      stack = builtins.readFile ./git/stack.sh;
      push-stack = builtins.readFile ./git/push-stack.sh;
      push-stepped-stack = builtins.readFile ./git/push-stepped-stack.sh;
      red = "rebase --interactive --autosquash --update-refs";
    };
    settings = {
      init.defaultBranch = "main";
      push = {
        autosSetupRemote = true;
      };
      rerere = {
        enabled = true;
      };
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
