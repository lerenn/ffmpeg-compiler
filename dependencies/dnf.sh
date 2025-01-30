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

# Install dnf-plugins-core
dnf install dnf-plugins-core -y

# Add CUDA repo
dnf config-manager -y addrepo --overwrite \
      --from-repofile=https://developer.download.nvidia.com/compute/cuda/repos/fedora39/x86_64/cuda-fedora39.repo

# Add RPM Fusion
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y

# Install development tools
dnf group install development-tools -y
dnf install mpfr-devel gmp-devel libmpc-devel \
      zlib-devel glibc-devel.i686 glibc-devel isl-devel \
      g++ gcc-gnat gcc-gdc libgphobos-static -y

# Install build requirements.
dnf install -y \
      autoconf \
      automake \
      cmake \
      cuda-nvcc-12-6 \
      freetype-devel \
      gcc \
      gcc-c++ \
      gettext-devel \
      git \
      libogg-devel \
      libtool \
      libvorbis-devel \
      libvpx-devel \
      make \
      mercurial \
      nasm \
      opus-devel \
      pkgconfig \
      yasm \
      zlib-devel
