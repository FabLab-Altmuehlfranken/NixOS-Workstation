{
  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    inkstitch = { url = "github:FabLab-Altmuehlfranken/nix-inkstitch/master"; };
  };

  outputs = { self, nixpkgs, inkstitch }: {
    nixosConfigurations.fablab = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          _module.args = { inherit inkstitch; };

          systemd.tmpfiles.rules = [
            "L+ /nix/nixPath - - - - ${pkgs.path}"
          ];

          nix = {
            package = pkgs.nixVersions.stable;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
            registry.nixpkgs.flake = nixpkgs;
            nixPath = [ "nixpkgs=/nix/nixPath" ];

            settings = {
              substituters = [
                "https://cache.nixos.org"
                # Prioritize local attic cache when building system locally
                "https://attic.fablab-altmuehlfranken.de/fablab?priority=10"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "fablab:Tb/JDq91JCPGrMeK2FAzY3F6/ot3n5abG+14f521jr4="
              ];
            };
          };

          imports = [
            ./configuration.nix
          ];
        })
      ];
    };
    nixosConfigurations.fablab-nvidia = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;
          _module.args = { inherit inkstitch; };

          systemd.tmpfiles.rules = [
            "L+ /nix/nixPath - - - - ${pkgs.path}"
          ];

          nix = {
            package = pkgs.nixVersions.stable;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
            registry.nixpkgs.flake = nixpkgs;
            nixPath = [ "nixpkgs=/nix/nixPath" ];

            settings = {
              substituters = [
                "https://cache.nixos.org"
                # Prioritize local attic cache when building system locally
                "https://attic.fablab-altmuehlfranken.de/fablab?priority=10"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "fablab:Tb/JDq91JCPGrMeK2FAzY3F6/ot3n5abG+14f521jr4="
              ];
            };
          };

          imports = [
            ./configuration.nix
            ./nvidia.nix
          ];
        })
      ];
    };
  };
}
