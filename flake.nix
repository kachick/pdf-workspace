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
          localPkgs = lib.packagesFromDirectoryRecursive {
            inherit (pkgs) callPackage;
            directory = ./pkgs;
          };
          inherit (localPkgs) imgs2pdf ipamjfont;
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

            # https://discourse.nixos.org/t/ensure-fonts-in-development-environment/20649/4
            FONTCONFIG_FILE = pkgs.makeFontsConf {
              fontDirectories =
                with pkgs;
                [
                  ibm-plex
                  biz-ud-gothic # https://github.com/NixOS/nixpkgs/pull/411145
                  mplus-outline-fonts.githubRelease
                  noto-fonts-color-emoji
                ]
                ++ [
                  ipamjfont # https://github.com/NixOS/nixpkgs/pull/437989
                ];
            };
          };
        }
      );
    };
}
