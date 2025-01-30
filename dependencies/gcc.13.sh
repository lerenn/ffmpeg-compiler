#!/usr/bin/env bash

# Set variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="${DIR}/build"

# Set
set -eux

# Check that the script is run as a normal user
if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# GCC 13
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/gcc-13.3.0" ]; then
      wget https://ftp.gwdg.de/pub/misc/gcc/releases/gcc-13.3.0/gcc-13.3.0.tar.xz
      tar xvf gcc-13.3.0.tar.xz
fi
cd gcc-13.3.0
mkdir -p build
cd build
../configure --enable-bootstrap \
      --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto \
      --prefix=/usr --program-suffix=-13.3 --mandir=/usr/share/man \
      --infodir=/usr/share/info --enable-shared --enable-threads=posix \
      --enable-checking=release --enable-multilib --with-system-zlib \
      --enable-__cxa_atexit --disable-libunwind-exceptions \
      --enable-gnu-unique-object --enable-linker-build-id \
      --with-gcc-major-version-only --enable-libstdcxx-backtrace \
      --with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu \
      --enable-plugin --enable-initfini-array --with-isl \
      --enable-offload-targets=nvptx-none --enable-offload-defaulted \
      --enable-gnu-indirect-function --enable-cet --with-tune=generic \
      --with-arch_32=i686 --build=x86_64-redhat-linux \
      --with-build-config=bootstrap-lto --enable-link-serialization=1 \
      --with-default-libstdcxx-abi=new --with-build-config=bootstrap-lto
make -j $(nproc)
sudo make install
exit
