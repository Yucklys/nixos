{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ghc
    haskell-language-server
  ];
}
