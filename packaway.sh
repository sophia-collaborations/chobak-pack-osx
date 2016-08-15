
cd "$(dirname "${0}")" || exit
rm -rf build
mkdir build
vrsnid="$(perl info/vrsn.pl)"
destino="chobak-pack-osx-${vrsnid}"
destina="build/${destino}"

mkdir -p "${destina}"
cp -r initial-install.command "${destina}/."
cp -r update-software.command "${destina}/."
cp -r shl "${destina}/."
cp -r pl "${destina}/."
cp -r README.md "${destina}/."

( cd build && (
  tar cvf "${destino}.tar" "${destino}"
  rm -rf "${destino}"
  gzip "${destino}.tar"
) )

open build



