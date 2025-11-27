{
  nixos ? import "${(import ./lon.nix).nixpkgs}/nixos" { },
}:
nixos.config.system.build.isoImage
