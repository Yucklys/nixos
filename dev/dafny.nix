{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dafny
    dotnet-sdk
    dotnet-runtime
    icu
  ];

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    ICU_ROOT = "${pkgs.icu}";
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT = "1";
  };
}
