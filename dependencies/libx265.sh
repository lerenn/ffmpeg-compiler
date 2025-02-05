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

# Check if libx265 installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/x265" ]; then
  echo "libx265 is already installed."
  exit
fi

# Download libx265
git clone --recursive --depth 1 --branch 4.1 https://bitbucket.org/multicoreware/x265_git x265

# Build libx265
mkdir -p ${WORK_DIR}/x265/build/linux && cd ${WORK_DIR}/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local" ../../source
make -j $(nproc)

# Install libx265
make install