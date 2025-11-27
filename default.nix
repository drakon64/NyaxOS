{
  pkgs ? import "${(import ./lon.nix).nixpkgs}/nixos" { },
}:
pkgs.config.system.build.isoImage
