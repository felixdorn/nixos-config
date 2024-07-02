{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      default = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./nixosConfigurations/laptop/configuration.nix
          inputs.sops-nix.nixosModules.sops
          inputs.home-manager.nixosModules.default
        ];
      };

      ax41 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixosConfigurations/ax41/configuration.nix
        ];
      };
    };

    templates = {
      php = {
        path = ./devshells/php;
        description = "PHP 8.3";
      };
    };
  };
}
