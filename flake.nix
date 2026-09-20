{
  description = "base nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # we use disko to format out drives. Lets fetch it and have it track our nixpkgs branch
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager ofc
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs"; # this line is optional, prevents downloading two versions of nixpkgs but disables cache
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      home-manager,
      ...
    }@inputs:
    let
      # One machine = one directory in hosts/ + one entry in this list. The name is also the
      # networking.hostName, so `nixos-rebuild switch --flake .` picks the right config by itself.
      hosts = [
        "calebdtn"
        "calebraptort16"
      ];

      mkHost =
        hostname:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs hostname; };

          modules = [
            ./modules/base.nix
            ./hosts/${hostname}
            { networking.hostName = hostname; }

            disko.nixosModules.disko

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs hostname; };
              home-manager.users.caleb = ./home/caleb.nix;
            }
          ];
        };
    in
    {
      nixosConfigurations = nixpkgs.lib.genAttrs hosts mkHost;
    };

}
