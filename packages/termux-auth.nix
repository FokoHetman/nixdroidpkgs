{
  src,
  cmake,
  openssl,
  stdenv,
}:
stdenv.mkDerivation {
  pname = "termux-auth";
  version = "git";
  inherit src;

  patches = [./termux-auth.patch];

  nativeBuildInputs = [cmake];
  buildInputs = [openssl];
}
