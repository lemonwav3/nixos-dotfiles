{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, alsa-lib
, libxxf86vm
, libxtst
, libxrender
, libxrandr
, libxi
, libxft
, libxext
, libxcursor
, libx11
, libxcomposite
, libxdamage
, libxkbcommon
, libdrm
, mesa
, glib
, nss
, nspr
, dbus
, atk
, at-spi2-atk
, at-spi2-core
, cups
, pango
, cairo
, systemd
}:

let
  version = "2026.1.0";
in

stdenv.mkDerivation {
  pname = "scilab";
  inherit version;

  src = fetchurl {
    url = "https://www.scilab.org/download/${version}/scilab-${version}.bin.x86_64-linux-gnu.tar.xz";
    sha256 = "sha256-lncn1r5QfxO1Kss2jj/UAfCr7MKfLJIAlMs6maBAvck=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsa-lib
    stdenv.cc.cc
    libx11
    libxcursor
    libxext
    libxft
    libxi
    libxrandr
    libxrender
    libxtst
    libxxf86vm
    libxcomposite
    libxdamage
    libxkbcommon
    libdrm
    mesa
    glib
    nss
    nspr
    dbus
    atk
    at-spi2-atk
    at-spi2-core
    cups
    pango
    cairo
    systemd
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    mv -t $out bin include lib share thirdparty
    sed -i \
      -e 's|\$(/bin/|$(|g' \
      -e 's|/usr/bin/||g' \
      $out/bin/{scilab,xcos}
    sed -i \
      -e "s|Exec=|Exec=$out/bin/|g" \
      -e "s|Terminal=.*$|Terminal=true|g" \
      $out/share/applications/*.desktop

    runHook postInstall
  '';

  dontCheckForBrokenSymlinks = true;

  meta = {
    homepage = "https://www.scilab.org/";
    description = "Scientific software package for numerical computations (Matlab lookalike)";
    platforms = lib.platforms.linux;
    license = lib.licenses.gpl2Only;
    mainProgram = "scilab";
  };
}