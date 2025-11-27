{
  description = "Leet Speak in Typst";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };

        leetify = pkgs.buildTypstPackage {
          pname = "leetify";
          version = "0.1.0";
          src = ./.;
        };
      in
      {
        packages.default = leetify;

        devShells.default = pkgs.mkShellNoCC {
          shellHook = ''
            tmpdir=$(mktemp -d)
            mkdir -p $tmpdir/preview
            cp -r ${leetify}/lib/typst-packages/* $tmpdir/preview/

            export TYPST_PACKAGE_CACHE_PATH=$tmpdir
          '';
          buildInputs = [
            pkgs.typst
            leetify
          ];
        };

        checks.default =
          pkgs.runCommand "check-leetify"
            {
              buildInputs = [
                leetify
                pkgs.typst
              ];
              src = ./.;
            }
            ''
              mkdir -p $out/packages/preview
              cp -r ${leetify}/lib/typst-packages/* $out/packages/preview/
              cp -r ${pkgs.typstPackages.cmarker}/lib/typst-packages/* $out/packages/preview/

              cd $src
              typst compile ./tests/main.typ --root . \
                --package-cache-path $out/packages $out/main.pdf
            '';
      }
    );
}
