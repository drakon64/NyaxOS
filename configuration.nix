{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
#  environment.systemPackages = [
#    (pkgs.callPackage ./pkgs/cosmic-ext-alternative-startup/package.nix { })
#  ];

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
      cosmic-greeter.enable = true;
#      sessionPackages = [ (pkgs.callPackage ./pkgs/cosmic-ext-extra-sessions/package.nix { }) ];
    };
  };
}
