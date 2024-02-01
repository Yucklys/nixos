{ config, pkgs, ... }:

let
  my-lua-with-packages = ps: with ps; [
    
  ];
in
{
  environment.systemPackages = with pkgs; [
    lua-language-server
    (lua.withPackages my-lua-with-packages)
  ];
}
