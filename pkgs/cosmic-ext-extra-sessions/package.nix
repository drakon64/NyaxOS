{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
  nix-update-script,

  systemd,
  bash,
  dbus,
  cosmic-session,
  miracle-wm,
  niri,

  enableMiracle ? true,
  enableNiri ? true,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "cosmic-ext-extra-sessions";
  version = "0-unstable-2025-04-02";

  src = fetchFromGitHub {
    owner = "Drakulix";
    repo = "cosmic-ext-extra-sessions";
    rev = "66e065728d81eab86171e542dad08fb628c88494";
    hash = "sha256-6JiWdBry63NrnmK3mt9gGSDAcyx/f6L5QsIgZSUakQI=";
  };

  installPhase = ''
    runHook preInstall
  ''
  + lib.optionalString enableMiracle ''
    install -Dm0644 $src/miracle/cosmic-ext-miracle.desktop $out/share/wayland-sessions/cosmic-ext-miracle.desktop
    install -Dm0755 $src/miracle/start-cosmic-ext-miracle $out/bin/start-cosmic-ext-miracle
  ''
  + lib.optionalString enableNiri ''
    install -Dm0644 $src/niri/cosmic-ext-niri.desktop $out/share/wayland-sessions/cosmic-ext-niri.desktop
    install -Dm0755 $src/niri/start-cosmic-ext-niri $out/bin/start-cosmic-ext-niri
  ''
  + ''
    runHook postInstall
  '';

  postInstall =
    lib.optionalString enableMiracle ''
      substituteInPlace $out/share/wayland-sessions/cosmic-ext-miracle.desktop \
      --replace-fail "/usr/bin/start-cosmic-ext-miracle" "$out/bin/start-cosmic-ext-miracle"

      substituteInPlace $out/bin/start-cosmic-ext-miracle \
      --replace-fail "systemctl" "${systemd}/bin/systemctl" \
      --replace-fail "exec bash" "exec ${lib.getExe bash}" \
      --replace-fail "/usr/bin/dbus-run-session" "${dbus}/bin/dbus-run-session" \
      --replace-fail "/usr/bin/cosmic-session miracle-wm" "${lib.getExe cosmic-session} ${lib.getExe miracle-wm}"
    ''
    + lib.optionalString enableNiri ''
      substituteInPlace $out/share/wayland-sessions/cosmic-ext-niri.desktop \
      --replace-fail "/usr/local/bin/start-cosmic-ext-niri" "$out/bin/start-cosmic-ext-niri"

      substituteInPlace $out/bin/start-cosmic-ext-niri \
      --replace-fail "systemctl" "${systemd}/bin/systemctl" \
      --replace-fail "exec bash" "exec ${lib.getExe bash}" \
      --replace-fail "/usr/bin/dbus-run-session" "${dbus}/bin/dbus-run-session" \
      --replace-fail "/usr/bin/cosmic-session niri" "${lib.getExe cosmic-session} ${lib.getExe niri}"
    '';

  passthru = {
    providedSessions = lib.optional enableMiracle "cosmic-ext-miracle" ++ lib.optional enableNiri "cosmic-ext-niri";

    updateScript = nix-update-script { extraArgs = [ "--version=branch" ]; };
  };

  meta = {
    mainProgram = "cosmic-ext-extra-sessions";
    description = "Inofficial session variants for cosmic-epoch";
    homepage = "https://github.com/Drakulix/cosmic-ext-extra-sessions";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ drakon64 ];
  };
})
