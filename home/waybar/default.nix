{config, pkgs, lib, ... }:

{ programs.waybar = {
    enable = true;

    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });

    style = lib.mkForce ./style.css;

    settings = [
      {
        layer = "top";
        position = "top";
        height = 48;
        output = [
          "eDP-1"
          "DP-7"
        ];
        include = ["/etc/nixos/home/waybar/default-modules.json"];
        modules-left = [ "clock"
                         "hyprland/language"
                         # "hyprland/window" # Has bug in waybar v0.9.19
                         "hyprland/submap"
                         "idle_inhibitor"
                       ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "cpu"
                          "temperature"
                          "pulseaudio"
                          "bluetooth"
                          "network"
                          "tray"
                        ];
      }
      {
        layer = "top";
        position = "top";
        height = 48;
        output = [
          "DP-4"
        ];
        include = ["/etc/nixos/home/waybar/default-modules.json"];
        modules-left = [ "user"
                         "hyprland/submap"
                         "mpd"
                       ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "pulseaudio"
                          "bluetooth"
                          "network"
                          "tray"
                        ];
      }
    ];
  };
}
