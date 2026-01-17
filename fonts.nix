{ config, pkgs, ...}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    vista-fonts
    corefonts
    dejavu_fonts
    hack-font
    google-fonts
    ubuntu-classic
    open-fonts
  ];
}
