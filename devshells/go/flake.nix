{
  description = "A basic flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: (
    flake-utils.lib.eachDefaultSystem
    (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = pkgs.buildGoModule {
        name = "app";
        version = "dev";

        CGO_ENABLED = 0;

        src = ./.;
      };

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          # Add dependencies here.
          go
        ];
      };
    })
  );
}
