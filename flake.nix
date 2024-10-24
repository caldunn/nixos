{
  description = "base nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # we use disko to format out drives. Lets fetch it and have it track our nixpkgs branch
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager ofc
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = {self, nixpkgs, disko, home-manager, ...}@inputs: 
  let 
      system = "x86_64-linux";
  in {

    nixosConfigurations.calebdtn = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [ 
        ./configuration.nix 

        disko.nixosModules.disko
        ./disko-config.nix
      ];
    };

    homeConfigurations.caleb = home-manager.lib.homeManagerConfiguration {
      inherit system;
      pkgs = nixpkgs.legacyPackages.${system};
      modules = [ ./home.nix ];
    };

  };

}
