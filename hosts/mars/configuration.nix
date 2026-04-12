# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../system/greeter.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };
  xdg.portal.enable = true;
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "mars"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.firewall = {
    allowedTCPPorts = [ 57621 ]; # spotify device discovery
    allowedUDPPorts = [ 5353 ]; # chromecast
  };

  # Enable networking
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  # Fix network after suspend/resume
  systemd.services.restart-network-after-suspend = {
    description = "Restart NetworkManager after suspend";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart NetworkManager.service";
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_BE.UTF-8";
    LC_IDENTIFICATION = "nl_BE.UTF-8";
    LC_MEASUREMENT = "nl_BE.UTF-8";
    LC_MONETARY = "nl_BE.UTF-8";
    LC_NAME = "nl_BE.UTF-8";
    LC_NUMERIC = "nl_BE.UTF-8";
    LC_PAPER = "nl_BE.UTF-8";
    LC_TELEPHONE = "nl_BE.UTF-8";
    LC_TIME = "nl_BE.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.hannah = {
    isNormalUser = true;
    description = "Hannah Witvrouwen";
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    home-manager
    git
    gnumake
    brightnessctl
    nix-ld
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
     # Add any missing dynamic libraries for unpackaged programs
     # here, NOT in environment.systemPackages
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  fonts = {
    packages = with pkgs; [
      fira-code
      jetbrains-mono
      twitter-color-emoji
      material-symbols
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Roboto Nerd Font" ];
        serif = [ "Roboto Nerd Font" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
