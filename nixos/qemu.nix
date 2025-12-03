{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/disk-image.nix"
    ./configuration.nix
  ];
}
