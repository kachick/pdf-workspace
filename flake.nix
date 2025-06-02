{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
    }:
    let
      inherit (nixpkgs) lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          imgs2pdf = pkgs.callPackage ./pkgs/imgs2pdf { };
        in
        {
          default = pkgs.mkShellNoCC {
            buildInputs =
              (with pkgs; [
                bashInteractive

                nixd
                nixfmt-rfc-style
                dprint
                typos
                go-task

                shellcheck
                shfmt

                coreutils
                tesseract
                imagemagick
                pngquant
                img2pdf
                ocrmypdf
                papers # successor of evince
                html2pdf # https://github.com/NixOS/nixpkgs/pull/398379
              ])
              ++ [
                imgs2pdf
              ];
          };
        }
      );
    };
}
