{ config, pkgs, inputs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    rust-analyzer
    rust-bin.stable.latest.default
  ];
}
