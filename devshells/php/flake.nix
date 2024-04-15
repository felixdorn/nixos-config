{
  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.default = pkgs.mkShell {
	nativeBuildInputs = with pkgs; [
	  (php83.buildEnv {
	   extraConfig = ''
	    memory_limit = 1G
	    xdebug.mode=coverage
	   '';

	   extensions = ({ enabled, all }: enabled ++ (with all; [
		 xdebug
	   ]));
	  })
	  
	  php83Packages.composer
	  nodejs
	];
      };
    };
}

