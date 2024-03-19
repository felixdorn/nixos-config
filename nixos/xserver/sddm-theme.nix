{ pkgs }:

let
  src = "https://res.cloudinary.com/dy3jxhiba/image/upload/f_auto,q_auto/cc485vhndc7gbh7qrlor";

  image = pkgs.fetchurl {
    url = src;
    hash = "sha256-3/oIeynKjsXK1m/lWXCZivVEZq9p38QknvgkIO3+tBg=";
  };
in 
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-light";
    rev = "19bac00e7bd99e0388d289bdde41bf6644b88772";
    hash = "sha256-KddZtCTionZntQPD8ttXhHFLZl8b1NsawG9qbjuI1fc=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  '';
}
