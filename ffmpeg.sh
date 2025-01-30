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

# ffmpeg
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/ffmpeg" ]; then
      git clone git://source.ffmpeg.org/ffmpeg
fi
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" \
      ./configure --extra-libs=-lpthread --prefix="/usr/local" \
      --extra-cflags="-I/usr/local/include -I/usr/local/cuda/include -I${WORK_DIR}/ffmpeg/compat" --extra-ldflags="-L/usr/local/lib -L/usr/local/cuda/lib64" \
      --pkg-config-flags="--static" --enable-gpl --enable-nonfree \
      --enable-libfdk-aac --enable-libmp3lame --enable-libopus \
      --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 \
      --enable-libvidstab --enable-libaom \
      --enable-cuda-nvcc --enable-libnpp \
      --disable-static --enable-shared

make -j $(nproc)
sudo make install
hash -r
