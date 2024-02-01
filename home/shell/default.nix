{ config, pkgs, inputs, ... }:

{
  imports = [
    ./nushell
    ./wezterm
  ];

  # TUI file explorer
  programs.yazi.enable = true;

    # Shell configuration
  programs.starship = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };

  # Zoxide auto jump
  programs.zoxide.enable = true;

  # Zellij terminal multiplier
  programs.zellij = {
    enable = true;

    settings = {
      coyp_command = "wl-copy";
      copy_on_select = true;

      ui.pane_frames.rounded_corners = true;
    };
  };

  programs.bat.enable = true;

  # nix-direnv with nushell support
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
