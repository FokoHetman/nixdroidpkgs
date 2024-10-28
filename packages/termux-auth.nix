{
  src,
  cmake,
  openssl,
  stdenv,
  termuxPackageHook,
}:
stdenv.mkDerivation {
  pname = "termux-auth";
  version = "git";
  inherit src;

  env.CFLAGS = "-DPATH_MAX=256";

  nativeBuildInputs = [cmake termuxPackageHook];
  buildInputs = [openssl];
}
