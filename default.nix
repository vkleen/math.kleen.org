{ pkgs ? (import <nixpkgs> {})
}:

with pkgs.lib;

let
  sourceFilter = path: type: (hasPrefix (toString ./src ) path || (baseNameOf path == "blog.cabal"));
in rec {
  haskellPackages = pkgs.haskell.packages.ghc843;
  math-kleen-org = pkgs.stdenv.lib.overrideDerivation (haskellPackages.callPackage ./blog.nix {})
    (attrs :
      { src = builtins.filterSource sourceFilter ./.;
        shellHook = ''
          export NIX_SHELL_ENV=${attrs.name}
        '';
      }
    );
  texEnv = with pkgs; texlive.combine {
    inherit (texlive) scheme-full;
  };
  math-kleen-org-wrapper = pkgs.stdenv.mkDerivation rec {
    name = "math-kleen-org-wrapper";
    buildInputs = [ pkgs.makeWrapper ];
    buildCommand = ''
      mkdir -p $out/bin
      makeWrapper ${math-kleen-org}/bin/site $out/bin/math-kleen-org \
        --prefix PATH : ${texEnv}/bin
    '';
  };
}
