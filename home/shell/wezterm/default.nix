{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;

    extraConfig = builtins.readFile ./config.lua;
  };

  stylix.targets.wezterm.enable = false;
}
