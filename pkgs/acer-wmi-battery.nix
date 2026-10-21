{ lib, stdenv, kernel, kernelModuleMakeFlags, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "acer-wmi-battery";
  version = "2026-01-25";

  src = fetchFromGitHub {
    owner = "frederik-h";
    repo = "acer-wmi-battery";
    rev = "9f90d75cc9237aeed7964622d10dbdf4d2c7b518";
    sha256 = "sha256-CyKRpE3cnhEIFHc4Hal2PQUW7cd5k8+55S4QdSqGvNI=";
  };

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildPhase = ''
    runHook preBuild
    make ${lib.escapeShellArgs kernelModuleMakeFlags} \
      -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M="$PWD" modules
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    make ${lib.escapeShellArgs kernelModuleMakeFlags} \
      -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M="$PWD" INSTALL_MOD_PATH="$out" INSTALL_MOD_DIR=extra modules_install
    runHook postInstall
  '';

  meta = with lib; {
    description = "Linux kernel driver for the Acer WMI battery health control interface";
    homepage = "https://github.com/frederik-h/acer-wmi-battery";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
