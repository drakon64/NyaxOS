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

  users.users.nixos.initialPassword = "nixos";

  services.displayManager.autoLogin.enable = false;

  system.activationScripts.installerDesktop =
    let
      # Comes from documentation.nix when xserver and nixos.enable are true.
      manualDesktopFile = "/run/current-system/sw/share/applications/nixos-manual.desktop";

      homeDir = "/home/nixos/";
      desktopDir = homeDir + "Desktop/";
    in
    ''
      mkdir -p ${desktopDir}
      chown nixos ${homeDir} ${desktopDir}

      ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
      ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
      ln -sfT ${pkgs.calamares-nixos}/share/applications/calamares.desktop ${
        desktopDir + "calamares.desktop"
      }
    '';
}
