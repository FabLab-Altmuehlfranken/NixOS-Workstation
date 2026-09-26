{
  environment.etc.fablab = {
    source = ./home;
  };
  environment.etc.visicut-settings = {
    source = builtins.fetchGit {
      url = "https://git.fablab-altmuehlfranken.de/fablab/visicut-settings.git";
      rev = "74d381e7a1d1ab94478662d4cf754166fbb418ad";
    };
  };
  system.activationScripts.script.text = ''
    if [[ $(who | grep fablab) > 0 ]]; then exit 0; fi
    cp -r /etc/fablab/ /home
    rm -rf /home/fablab/.visicut
    cp -Lr /etc/visicut-settings /home/fablab/.visicut
    chown -R fablab:users /home/fablab
    chmod -R u+w /home/fablab
  '';
}
