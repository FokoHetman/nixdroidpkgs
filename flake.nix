{
  description = "ndroidpkgs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    termux-auth.url = "github:termux/termux-auth";
    termux-auth.flake = false;
    termux-packages.url = "github:termux/termux-packages";
    termux-packages.flake = false;
  };
  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (nixpkgs) lib;
    # TODO: use nix-systems
    eachSystem = lib.genAttrs ["x86_64-linux" "aarch64-linux"];
    pkgsFor = eachSystem (
      system:
        import nixpkgs {
          localSystem = system;
          overlays = [self.overlays.default];
        }
    );
  in {
    inherit inputs;
    overlays = {
      default = final: prev: {
        termux-auth = final.callPackage ./packages/termux-auth.nix {src = inputs.termux-auth;};
        openssh = final.callPackage ./packages/openssh.nix {
          termuxPkg = "${inputs.termux-packages}/packages/openssh";
        };
      };
    };

    packages = eachSystem (system: {
      inherit (pkgsFor.${system}) termux-auth openssh;
    });
  };
}
