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

# Check if libfdk_aac installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/fdk-aac" ]; then
  echo "libfdk_aac is already installed."
  exit
fi

# Download libfdk_aac
git clone --recursive --depth 1 git://git.code.sf.net/p/opencore-amr/fdk-aac

# Build libfdk_aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="/usr/local" --disable-shared
make -j $(nproc)

# Install libfdk_aac
make install