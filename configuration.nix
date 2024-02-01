# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, callPackage, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
      ./nvidia.nix
      ./video.nix
      ./dev
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Register AppImage as regular binary
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # Enable xdg-desktop-portal for wayland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-rime fcitx5-gtk libsForQt5.fcitx5-qt ];
  };

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    # keyMap = "dvorak";
    packages = with pkgs; [ terminus_font ];
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Hyprland system wide settings
  # programs.hyprland = {
  #   enable = true;
  #   enableNvidiaPatches = true;
  # };

  # KDEConnect
  programs.kdeconnect.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    wqy_microhei
    nerdfonts
    font-awesome
    symbola
  ];

  # Enable Flake for Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Protect nix-shell against garbage collection
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
    # Hyprland Cachix
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
  
  # Allow some packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import inputs.emacs-overlay)
    # (import (builtins.fetchTarball {
    #   url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    #   sha256 = "1khmafy3n03kw1rac5wgjvfrcappg44j8k7y3inf0z06d6b6mn6b";
    # }))
  ];

  # Enable PAM for swaylock
  security.pam.services.swaylock = {};
  
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #  Display Manager
  services.xserver.displayManager.sddm = {
    enable = true;
  };
  
  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable bluetooth support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Hybrid sleep behavior
  services.logind.lidSwitch = "hybrid-sleep";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yucklys = {
    isNormalUser = true;
    extraGroups = [ "wheel"
    		            "networkmanager"
		                "audio"
                    "video"
                    "input"
		              ]; # Enable ‘sudo’ for the user.
    
    # Use nushell as default shell for user
    shell = pkgs.nushell;
  };

  stylix = {
    image = ./nixos.png;
    polarity = "dark";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    coreutils
    cmake
    gnumake
    clang
    gcc
    libtool
    librime
    nushell
    cachix
    (pass-wayland.withExtensions (ext: with ext; [
      pass-import
      pass-update
    ]))
    pass-wayland
    libnotify
    wtype
    dtrx
    tealdeer # tldr client
    goldendict-ng # goldendict in 2023
    just # an universal makefile
    qmk
    wev # check key code
    brightnessctl
    gdb
    pandoc
    unzip
    appimage-run
    keyutils
  ];

  # Enable Emacs overlay
  services.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    install = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Dbus
  services.dbus.enable = true;

  # USB auto mount
  services.udisks2.enable = true;

  # OneDrive
  services.onedrive.enable = true;

  # Cachix store
  services.cachix-watch-store = {
    enable = true;
    cacheName = "yucklys"; # my Cachix public store name
    jobs = 8; # number of thread for pushing cache. Default 8.
    cachixTokenFile = ./.cachix_token; # token file
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

