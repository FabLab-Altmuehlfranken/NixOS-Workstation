{ pkgs, inkstitch, ... }:
{
  environment.systemPackages = with pkgs; [
    arduino
    freecad
    gimp
    inkcut
    inkstitch.hydraJobs.inkscape-inkstitch.x86_64-linux
    libreoffice
    openscad
    prusa-slicer
    adwaita-icon-theme
    (callPackage applications/visicut.nix { })
    yakuake
  ];

  virtualisation.docker.enable = true;
}
