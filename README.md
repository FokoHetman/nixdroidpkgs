# Nixdroidpkgs

Termux packages/patches ported to nix for use on [nix-on-droid](https://github.com/nix-community/nix-on-droid).

Currently only has termux-auth and OpenSSH.

## Why?

Most nixpkgs programs work perfectly fine on nix-on-droid. However, some come
with caveats: for example, `passwd` can't be used since we're not root, and in
turn, `sshd` won't work with password access. Termux packages have patches and
workarounds for such issues, and I'm porting them over (some of them) to
nix-on-droid.

## Usage

Example (incomplete) flake installing openssh with termux patches:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixdroidpkgs = {
      url = "github:horriblename/nixdroidpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {self, nixdroidpkgs, nix-on-droid, ...}: {
    nixOnDroidConfigurations.deviceName = nix-on-droid.lib.nixOnDroidConfiguration {
      modules = [
        {
          environment.packages = [
            nixdroidpkgs.packages.${pkgs.system}.termux-auth
            nixdroidpkgs.packages.${pkgs.system}.openssh
          ];
        }
      ];
    };
  };
}
```

*There is also an overlay if you prefer that*

> [!NOTE]
> 
> Termux-patched OpenSSH uses termux-auth for password authentication. Run the `passwd` command
> from termux-auth to set up a password.
