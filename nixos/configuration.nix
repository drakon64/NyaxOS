{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  environment = {
    etc."niri/config.kdl".source = lib.mkDefault ./niri/config.kdl;

    systemPackages = [
      (pkgs.callPackage ../pkgs/cosmic-ext-alternative-startup/package.nix { })
    ];
  };

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
    desktopManager.cosmic.enable = true;

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

      sessionPackages = [ (pkgs.callPackage ../pkgs/cosmic-ext-extra-sessions/package.nix { }) ];
    };
  };
}
