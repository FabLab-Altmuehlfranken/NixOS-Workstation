{ config, pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vistafonts
    corefonts
    dejavu_fonts
    hack-font
    google-fonts
    ubuntu_font_family
    open-fonts
  ];
}