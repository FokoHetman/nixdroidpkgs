{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  name = "termuxPatchHook";
  src = ./.;

  setupHooks = [./termux-patch-setup-hooks.sh];

  outputs = ["out"];
}
