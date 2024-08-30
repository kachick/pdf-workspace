{ pkgs, ... }:
pkgs.writeShellApplication rec {
  name = "imgs2pdf";
  text = builtins.readFile ./${name}.bash;
  runtimeInputs = with pkgs; [
    coreutils # mktemp
    img2pdf
    ocrmypdf
  ];
}
