{ config, pkgs, ... } :

{
  # Nushell for alternative user shell
  programs.nushell = {
    enable = true;

    # load configurations locate in ./nushell/
    configFile = { text = (builtins.readFile ./config.nu); };
    envFile = { text = (builtins.readFile ./env.nu); };

    shellAliases = {
      vim = "nvim";
      ec = "emacsclient";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -al";
      devenv-init = "nix flake init --template github:cachix/devenv";
    };
  };

  # Enable program integrations
  programs.zoxide.enableNushellIntegration = true;
  programs.starship.enableNushellIntegration = true;
  programs.yazi.enableNushellIntegration = true;
}
