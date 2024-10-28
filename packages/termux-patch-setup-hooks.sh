
TERMUX_APP_PACKAGE=${TERMUX_APP_PACKAGE:-com.termux.nix}
TERMUX_BASE_DIR="/data/data/${TERMUX_APP_PACKAGE}/files"
TERMUX_CACHE_DIR="/data/data/${TERMUX_APP_PACKAGE}/cache"
TERMUX_ANDROID_HOME="${TERMUX_BASE_DIR}/home"
TERMUX_PREFIX_CLASSICAL="${TERMUX_BASE_DIR}/usr"
TERMUX_PREFIX="${TERMUX_PREFIX_CLASSICAL}"

termux_step_patch_package() {
	shopt -s nullglob
	for patch in $termuxPatches; do
		echo "Applying patch: $(basename $patch)"
		test -f "$patch" && sed \
			-e "s%\@TERMUX_APP_PACKAGE\@%${TERMUX_APP_PACKAGE}%g" \
			-e "s%\@TERMUX_BASE_DIR\@%${TERMUX_BASE_DIR}%g" \
			-e "s%\@TERMUX_CACHE_DIR\@%${TERMUX_CACHE_DIR}%g" \
			-e "s%\@TERMUX_HOME\@%${TERMUX_ANDROID_HOME}%g" \
			-e "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" \
			-e "s%\@TERMUX_PREFIX_CLASSICAL\@%${TERMUX_PREFIX_CLASSICAL}%g" \
			"$patch" | patch --silent -p1
	done
	shopt -u nullglob
}

preConfigurePhases+=(termux_step_patch_package)

appendToVar CFLAGS -D__ANDROID__
appendToVar CFLAGS "-DTERMUX_APP_PACKAGE=\\\"${TERMUX_APP_PACKAGE}\\\""
appendToVar CFLAGS "-DTERMUX_BASE_DIR=\\\"${TERMUX_BASE_DIR}\\\""
appendToVar CFLAGS "-DTERMUX_CACHE_DIR=\\\"${TERMUX_CACHE_DIR}\\\""
appendToVar CFLAGS "-DTERMUX_HOME=\\\"${TERMUX_ANDROID_HOME}\\\""
appendToVar CFLAGS "-DTERMUX_PREFIX=\\\"${TERMUX_PREFIX}\\\""
appendToVar CFLAGS "-DTERMUX_PREFIX_CLASSICAL=\\\"${TERMUX_PREFIX_CLASSICAL}\\\""
