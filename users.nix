{ pkgs, ... }:

{
  users.mutableUsers = false;
  users.users.root.initialHashedPassword = "$6$3FPNmJMfGTkLszoy$b0bmUC3QvcLdbngU1cGNzmEnn/IdEISyZtg8S2feiZg6xZ5Dlgx4Mr5EH2u9IGwgzxhCUfaY6AayanTkQ2WHH/";
  users.users.fablab = {
    initialHashedPassword = "$6$3FPNmJMfGTkLszoy$b0bmUC3QvcLdbngU1cGNzmEnn/IdEISyZtg8S2feiZg6xZ5Dlgx4Mr5EH2u9IGwgzxhCUfaY6AayanTkQ2WHH/";
    isNormalUser = true;
    createHome = true;
    description = "FabLab";
    extraGroups = [ "dialout" "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      kdePackages.kate
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "fablab";
}
