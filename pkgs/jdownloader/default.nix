{ stdenv
, fetchFromGitHub
, jdk
, makeWrapper
, makeDesktopItem
, imagemagick
}:

stdenv.mkDerivation {
  pname = "jdownloader";
  version = "someversion";

  src = fetchFromGitHub {
    owner = "mkg20001";
    repo = "nix";
    rev = "082a695af25786d9be4a96aa10a0ba9a195040eb";
    sha256 = "0gg6sfx024sm4fivvqcdp03lz9xrv3nyp0yimyisfi36h1xm863h";
  };

  buildInputs = [
    jdk
  ];

  nativeBuildInputs = [
    makeWrapper
    imagemagick
  ];

  desktopItem = makeDesktopItem {
    name = "jdownloader";
    exec = "@out@/bin/jdownloader";
    icon = "jdownloader";
    desktopName = "JDownloader";
    categories = "Application;Network;";
  };

  java = jdk;

  prePatch = ''
    cd pkgs/jdownloader
  '';

  installPhase = ''
    mkdir $out/bin -p
    mv JDownloader.jar $out
    sed "s|@out@|$out|g" -i bin.sh
    sed "s|@out@|$out|g" -i bin.sh
    convert jd_logo_256_256.png -resize 128x128 128.png
    convert jd_logo_256_256.png -resize 64x64 64.png
    convert jd_logo_256_256.png -resize 48x48 48.png

    install -D $desktopItem/share/applications/jdownloader.desktop   $out/share/applications/jdownloader.desktop
    sed "s|@out@|$out|g" -i $out/share/applications/jdownloader.desktop
    install -D 48.png                                                $out/share/icons/hicolor/48x48/apps/jdownloader.png
    install -D 64.png                                                $out/share/icons/hicolor/64x64/apps/jdownloader.png
    install -D 128.png                                               $out/share/icons/hicolor/128x128/apps/jdownloader.png
    install -D jd_logo_256_256.png                                   $out/share/icons/hicolor/256x256/apps/jdownloader.png

    sed "s|@java@|$java/bin/java|g" -i bin.sh
    mv bin.sh $out/bin/jdownloader
  '';
}

