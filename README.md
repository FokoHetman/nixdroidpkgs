# Nixdroidpkgs

Termux packages/patches ported to nix for use on nix-on-droid.

## Why?

Most nixpkgs programs work perfectly fine on nix-on-droid. However, some come
with caveats: for example, `passwd` can't be used since we're not root, and in
turn, `sshd` won't work with password access. Termux packages have patches and
workarounds for such issues, and I'm porting them over (some of them) to
nix-on-droid.

