{ pkgs ? (import <nixpkgs> {})
}:

pkgs.stdenv.mkDerivation rec {
  name = "math-kleen-org";
  buildInputs = with (import ./default.nix {});
    [ math-kleen-org-wrapper
    ];
  shellHook = ''
    export NIX_SHELL_ENV=${name}
  '';
}
