{ pkgs, ... }:
{
  systemd.services.autoupdater = {
    after = [ "network-online.target" ];
    description = "FabLab AutoUpdater";
    wantedBy = [ "multi-user.target" ];
    script = ''
      if [ -f /autoupdate-finished ]; then exit 0; fi
      rm -rf /etc/nixos
      git clone --depth=1 https://github.com/FabLab-Altmuehlfranken/NixOS-Workstation.git /etc/nixos
      nixos-rebuild boot --flake '/etc/nixos#fablab'
      touch /autoupdate-finished
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Environment = [
        "PATH=/run/current-system/sw/bin:$PATH"
        "NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels"
        "NIX_PROFILES=/run/current-system/sw /nix/var/nix/profiles/default"
      ];
    };
  };
}
