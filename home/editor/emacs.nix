{ config, pkgs, inputs, ... }:

let
  emacs-pgtk-noxim = pkgs.emacs-pgtk.overrideAttrs (old : {
        configureFlags = old.configureFlags ++ ["--without-xim"];
      });
in
{
  nixpkgs.overlays = [ (import inputs.emacs-overlay) ];
  
  programs.emacs = {
    enable = true;
    package = emacs-pgtk-noxim;
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  services.emacs = {
    enable = true;
    package = emacs-pgtk-noxim;

    defaultEditor = true;
    startWithUserSession = true;
    # socketActivation.enable = true;

    client.enable = true;
  };

  # using emacs theme
  # stylix.targets.emacs.enable = false;
}
