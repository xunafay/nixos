{ inputs, pkgs, ... }:
{
  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ./bashrc.sh;
  };

  programs = {
    vscode.enable = true;
  };
  
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
 
  programs.git = {
    enable = true;
    lfs.enable = true;
    aliases = {
      graph = "log --graph --oneline --all";
      prune-untracked = "git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d";
      default-branch = "!git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'";
      merge-base-origin = "!f() { git merge-base \${1-HEAD} origin/$(git default-branch); };f ";
      push-stepped = builtins.readFile ./git/push-stepped.sh;
      stack = builtins.readFile ./git/stack.sh;
      push-stack = builtins.readFile ./git/push-stack.sh;
      push-stepped-stack = builtins.readFile ./git/push-stepped-stack.sh;
      red = "rebase --interactive --autosquash --update-refs";
      ca = "commit --amend";
      cc = "commit";
    };
    settings = {
      init.defaultBranch = "main";
      push = {
        autosSetupRemote = true;
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autoStash = true;
      };
      merge = {
        conflictStyle = "zdiff3";
        autoStash = true;
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

  programs.gh = {
    extensions = with pkgs; [
      gh-webhook
    ];
  };

  home.packages = with pkgs; [
    bash
    git
    gh
    vscode
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
        sdk_10_0
      ]
    )
    cargo
    rustc
    nodejs_24
    gcc
    tree-sitter
    ripgrep
    unzip
    fd
    gh
  ];
}
