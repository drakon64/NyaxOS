{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "cosmic-ext-alternative-startup";
  version = "";

  src = fetchFromGitHub {
    owner = "Drakulix";
    repo = finalAttrs.pname;
    rev = "d6884f0d4dd20fcae73e662c13e000bb90bb45f3";
    hash = "sha256-Y8xWJ8VtShczKZ1YexwYrRIJaEACzOZ0DgcFQ8lzj+8=";
  };

  cargoHash = "sha256-DeMkAG2iINGden0Up013M9mWDN4QHrF+FXoNqpGB+mg=";

  meta = {
    description = "Alternative entry point for cosmic-sessions compositor IPC interface";
    homepage = "https://github.com/Drakulix/cosmic-ext-alternative-startup";
    license = lib.licenses.gpl3;
    maintainers = with lib.maintainers; [ drakon64 ];
  };
})
