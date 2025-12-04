{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  environment.etc."niri/config.kdl".source = lib.mkDefault ./niri/config.kdl;

  nixpkgs.overlays = [
    (final: prev: {
      inherit (prev.lixPackageSets.stable)
        nixpkgs-review
        nix-eval-jobs
        nix-fast-build
        colmena
        ;
    })
  ];

  nix.package = pkgs.lixPackageSets.stable.lix;

  services = {
    desktopManager.cosmic = {
      enable = true;
      extraSessions.niri.enable = true;
    };

    displayManager = {
      autoLogin = {
        enable = true;
        user = "nixos";
      };

      defaultSession = "cosmic-ext-niri";

      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
