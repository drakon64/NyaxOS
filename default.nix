{
  pkgs ? import (import ./lon.nix).nixpkgs { },
  nixos ? "${(import ./lon.nix).nixpkgs}/nixos",
}:
{
  image = (import nixos { }).config.system.build.image;
  iso = (import nixos { }).config.system.build.isoImage;

  cosmic-ext-alternative-startup =
    pkgs.callPackage ./pkgs/cosmic-ext-alternative-startup/package.nix
      { };

  cosmic-ext-extra-sessions = pkgs.callPackage ./pkgs/cosmic-ext-extra-sessions/package.nix { };
}
