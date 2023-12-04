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

          nix = {
            package = pkgs.nixFlakes;
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
            registry.nixpkgs.flake = nixpkgs;

            settings = {
              substituters = [
                "https://cache.nixos.org"
              ];

              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              ];
            };
          };

          imports = [
            ./configuration.nix
          ];
        })
      ];
    };
  };
}
