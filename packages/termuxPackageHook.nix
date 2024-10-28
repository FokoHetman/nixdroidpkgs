{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  name = "termuxPackageHook";
  src = ./.;

  setupHooks = [./termux-package-setup-hooks.sh];

  outputs = ["out"];
}
