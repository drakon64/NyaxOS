{
  pkgs ? import (import ./lon.nix).nixpkgs { },
  nixos ? import "${(import ./lon.nix).nixpkgs}/nixos" { },
}:
{
  iso = nixos.config.system.build.isoImage;
  vm = nixos.vm;

  cosmic-ext-alternative-startup =
    pkgs.callPackage ./pkgs/cosmic-ext-alternative-startup/package.nix
      { };

  cosmic-ext-extra-sessions = pkgs.callPackage ./pkgs/cosmic-ext-extra-sessions/package.nix { };
}
