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

# Change the version of GCC if incorrect
if [ "$(gcc -dumpversion)" != "13" ]; then
  if [ -f "/usr/bin/gcc-$(gcc -dumpversion)" ]; then
    mv /usr/bin/gcc /usr/bin/gcc-$(gcc -dumpversion)
  else 
    rm /usr/bin/gcc
  fi
  ln -s /usr/bin/gcc-13.2 /usr/bin/gcc
fi

# Add CUDA/NVCC to PATH
export CUDA_HOME=/usr/local/cuda
export PATH=${CUDA_HOME}/bin:${PATH}

# FFMPEG
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ ! -d "${WORK_DIR}/ffmpeg" ]; then
  git clone --recursive --depth 1 --branch n7.1 git://source.ffmpeg.org/ffmpeg
fi
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig" \
  ./configure \
  --extra-libs="-lpthread -lstdc++" --prefix="/usr/local" \
  --extra-cflags="-I/usr/local/include -I/usr/local/cuda/include" \
  --extra-ldflags="-L/usr/local/lib -L/usr/local/cuda/lib64" \
  --pkg-config-flags="--static" --enable-gpl --enable-nonfree \
  --enable-libfdk-aac --enable-libmp3lame --enable-libopus \
  --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265 \
  --enable-libvidstab --enable-libaom \
  --enable-cuda-nvcc --enable-libnpp \
  --disable-shared --enable-static

make -j $(nproc)
make install
hash -r

