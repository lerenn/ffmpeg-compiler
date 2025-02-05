#!/usr/bin/env bash

# Set variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
WORK_DIR="${DIR}/../build"

# Set
set -eux

# Check that the script is run as a normal user
if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# Check if libaom-av1 installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/av1" ]; then
  echo "libaom-av1 is already installed."
  exit
fi

# Download libaom-av1
git clone --branch master --recursive --depth 1 https://aomedia.googlesource.com/aom av1

# Build libaom-av1
mkdir -p ${WORK_DIR}/av1/build && cd ${WORK_DIR}/av1/build
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local" -DENABLE_SHARED=off -DENABLE_NASM=on ..
make -j $(nproc)

# Install libaom-av1
make install