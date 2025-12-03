{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    "${modulesPath}/virtualisation/virtualbox-image.nix"
    ./configuration.nix
  ];

  virtualbox.memorySize = 2048;
}
