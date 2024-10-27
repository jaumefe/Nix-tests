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
    packages.default = pkgs.stdenv.mkDerivation {
      name = "hello";
      src = "./.";

      buildInputs = [ python ];

      installPhase = ''
        mkdir -p $out/bin
        cp ${./main.py} $out/bin/main.py      
      '';

      shellHook = ''
        chmod +x $out/bin/main.py
      '';

    };

    apps.default = {
      type = "app";
      program = "${pkgs.python311}/bin/python ${./main.py}";
    };

  };
}
