{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    nodePackages.typescript-language-server
    nodePackages.vls
  ];
}
