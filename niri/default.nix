{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "niri";
  version = "1.0.0";

  src = null; # Adjust if you have a source to fetch

  buildInputs = [ pkgs.someDependency ]; # Add dependencies
  installPhase = ''
    mkdir -p $out/bin
    echo "#!${pkgs.stdenv.shell}" > $out/bin/niri
    echo "echo Hello from niri!" >> $out/bin/niri
    chmod +x $out/bin/niri
  '';
}
