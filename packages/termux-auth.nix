{
  src,
  cmake,
  stdenv,
}:
stdenv.mkDerivation {
  inherit src;

  nativeBuildInputs = [cmake];
}
