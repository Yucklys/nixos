{ config, pkgs, ... }:

{
  imports = [
    ./emacs.nix
    ./vscode.nix
  ];

  home.sessionVariables = {
    VISUAL = "emacsclient";
  };
}
