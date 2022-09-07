{
  description = "";

  inputs.enarx.url = github:enarx/enarx;
  inputs.flake-utils.url = github:numtide/flake-utils;
  inputs.nixpkgs.url = github:profianinc/nixpkgs;

  outputs = {
    self,
    enarx,
    flake-utils,
    nixpkgs,
  }:
    flake-utils.lib.eachSystem [
      aarch64-darwin
      aarch64-linux
      x86_64-darwin
      x86_64-linux
    ] (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];
      };

      buildEnarxPackage = {
        name,
        version,
        wasm,
        conf,
      }:
        pkgs.stdenv.mkDerivation {
          inherit version;

          pname = name;

          dontUnpack = true;
          installPhase = ''
            mkdir -p $out
            cp ${conf} $out/Enarx.toml
            cp ${wasm} $out/main.wasm
          '';
        };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          enarx.packages.${system}.enarx-static
        ];
      };

      formatter = pkgs.alejandra;
    });
}
