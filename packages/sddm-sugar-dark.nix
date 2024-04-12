{ pkgs }: 

pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    hash = "sha256-KddZtCTionZntQPD8ttXhHFLZl8b1NsawG9qbjuI1fc=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    echo theme.conf < ${./..data/theme.conf}
  '';
}
