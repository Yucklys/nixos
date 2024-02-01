{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    jdk17
    redis
    maven
  ];
}
