{ config, pkgs, inputs, ... } :

{ imports = [
    ./config.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.try_swap_workspace
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    hyprpicker
    swaylock-effects
  ];

  stylix.targets.hyprland.enable = true;
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = false;
  };

  services.swayidle = {
    enable = true;

    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
      { timeout = 600; command = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off"; resumeCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"; }
    ];

    events = [
      { event = "before-sleep"; command = "${pkgs.swaylock-effects}/bin/swaylock -f"; }
    ];

    systemdTarget = "hyprland-session.target";
  };
}
