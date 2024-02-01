{ config, pkgs, inputs, lib, ... }:

let
  user = "yucklys";
in
{
  imports = [
    # inputs.hyprland.homeManagerModules.default
    ./editor
    ./waybar
    ./hyprland
    ./shell
    ./wlogout.nix
    ./mpd.nix
    ./email.nix
  ];

  # User packages
  home.packages = with pkgs; [
    alacritty
    fd
    htop
    helix
    git
    ripgrep
    hyprpaper
    lxgw-wenkai
    pavucontrol
    you-get
    ffmpeg
    wl-clipboard
    cliphist
    rustdesk
    via
    firefox
    qutebrowser
    nyxt
    mpv
    discord
    zoom-us
    openssl
    anki
    zathura
    zip
    bitwarden
    bitwarden-menu
    rofi-rbw-wayland
    xfce.thunar
    texlive.combined.scheme-full
  ];
  
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = "23.05";

  home.pointerCursor = lib.mkForce {
    name = "Bibata-Modern-Classic";
    size = 32;
    package = pkgs.bibata-cursors;
    x11 = {
      enable = true;
      defaultCursor = "Bibata-Modern-Classic";
    };
  };

  home.sessionVariables = {
    BW_SESSION = "QY9C5sSoBC6FNsFU6DKtf5WQ/5fTuA4vwXZM1nQCDcd/4N3QrVmUb1GYwUru9m3sS5S+P766Lhsi8IaVnHsh4w==";
  };

  programs.home-manager.enable = true;

  programs.wofi = {
    enable = true;
    style = builtins.readFile ./wofi/style.css;
  };

  # programs.qutebrowser = {
  #   enable = true;
  # };

  gtk.iconTheme = {
    name = "Nordzy-dark";
    package = pkgs.nordzy-icon-theme;
  };

  services.mako = {
    enable = true;
    anchor = "top-right";
    # backgroundColor = "#2E3440";
    margin = "20,20";
    defaultTimeout = 5000;
  };

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  xfconf.enable = false;

  programs.rbw = {
    enable = true;
    settings.email = "yucklys687@outlook.com";
  };
}
