{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  inputs.sops-nix = {
      url = "github:Mic92/sops-nix";        
      inputs.nixpkgs.follows = "nixpkgs";
    };

  inputs.nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  outputs = {nixpkgs, ...} @ inputs:
  {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
         inputs.sops-nix.nixosModules.sops
	 inputs.home-manager.nixosModules.default
      ];
    };
  };
}
