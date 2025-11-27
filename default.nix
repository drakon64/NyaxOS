{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-calamares.nix"
    ./configuration.nix
  ];

  services.displayManager.autoLogin = {
    enable = true;
    user = "nixos";
  };
}
