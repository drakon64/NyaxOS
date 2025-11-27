{
  pkgs ? import (import ./lon.nix).nixpkgs { },
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    lon
    nixfmt-rfc-style
    nixos-generators
  ];

  passthru.ci = pkgs.mkShellNoCC {
    packages = [ pkgs.nixos-generators ];
  };
}
