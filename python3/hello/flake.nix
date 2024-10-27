{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
  let
    pkgs = import nixpkgs {system = "x86_64-linux";};
    python = pkgs.python311;
  
  in {
    packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "hello";
      src = ./.;

      buildInputs = [ python ];

      installPhase = ''
        mkdir -p $out/bin
        install -m 755 ${./main.py} $out/bin/main.py      
      '';

    };

    apps.x86_64-linux.default = {
      type = "app";
      program = "$out/bin/main.py";
    };
  };
}
