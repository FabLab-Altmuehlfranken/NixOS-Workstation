{
  environment.etc.fablab = {
    source = ./home;
  };
  environment.etc.visicut-settings = {
    source = builtins.fetchGit {
      url = "https://git.fablab-altmuehlfranken.de/fablab/visicut-settings.git";
      rev = "87dbb8fb03a3e0767811882d1f8401070947ffd5";
    };
  };
  system.activationScripts.script.text = ''
    if [[ $(who | grep fablab) > 0 ]]; then exit 0; fi

    cp -r /etc/fablab/ /home

    rm -rf /home/fablab/.visicut
    cp -r /etc/visicut-settings /home/fablab/.visicut

    if grep -q 3840x2160 /sys/class/drm/*/modes; then
        # 4K screen, set scaling to 150%
        echo -n '
        [KScreen]
        ScreenScaleFactors=VGA-1=1;DP-1=1.5;HDMI-1=1;DP-2=1;
        ' > /home/fablab/.config/kdeglobals
    fi

    chown -R fablab:users /home/fablab
    chmod -R u+w /home/fablab
  '';
}
