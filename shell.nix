{
  pkgs ? import (import ./lon.nix).nixpkgs { },
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    lon
    nixfmt-rfc-style
  ];

  passthru.lon = pkgs.mkShellNoCC {
    packages = [ pkgs.lon ];
  };
}
