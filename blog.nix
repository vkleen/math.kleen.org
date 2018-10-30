{ mkDerivation, base, blaze-html, bytestring, containers
, cryptohash, data-default, deepseq, directory, filepath, hakyll
, hex, mtl, pandoc, pandoc-types, process, process-extras
, regex-tdfa, stdenv, temporary
}:
mkDerivation {
  pname = "math-kleen-org";
  version = "0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    base blaze-html bytestring containers cryptohash data-default
    deepseq directory filepath hakyll hex mtl pandoc pandoc-types
    process process-extras regex-tdfa temporary
  ];
  homepage = "http://math.kleen.org";
  license = stdenv.lib.licenses.bsd3;
}
