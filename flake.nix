{
  description = "Yucklys NixOS with Flakes";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    
    stylix.url = "github:danth/stylix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland-contrib = {
      url = "github:hyprwm/contrib?rev=bef073cff65917ba2d888aa4dc39bd9868e2b0a4";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {nixpkgs, stylix, home-manager, hyprland, ...} @ inputs: {
    nixosConfigurations = {
      "nixos" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          
          stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yucklys = import ./home;
            home-manager.extraSpecialArgs = { inherit inputs; };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };

    homeConfigurations."yucklys@nixos" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        hyprland.homeManagerModules.default
        {wayland.windowManager.hyprland.enable = true;}
        # ...
      ];
    };
  };
}
