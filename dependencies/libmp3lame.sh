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

# Clean up the previous installation
rm -f ${WORK_DIR}/lame-3.100.tar.gz

# Check if libmp3lame installation has been executed
mkdir -p ${WORK_DIR} && cd ${WORK_DIR}
if [ -d "${WORK_DIR}/lame-3.100" ]; then
  echo "libmp3lame is already installed."
  exit
fi 

# Download libmp3lame
curl -L -O http://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar xzvf lame-3.100.tar.gz

# Build libmp3lame
cd lame-3.100
autoreconf --install
./configure --prefix="/usr/local" --enable-nasm
make -j $(nproc)

# Install libmp3lame
make install