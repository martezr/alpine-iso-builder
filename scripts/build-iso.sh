#!/usr/bin/env bash
set -euxo pipefail

ALPINE_VERSION=v3.23
ARCH=x86_64

apk add --no-cache \
  alpine-sdk \
  abuild \
  xorriso \
  squashfs-tools \
  syslinux \
  mkinitfs

git clone --depth 1 \
  --branch 3.23-stable \
  https://github.com/alpinelinux/aports.git

cp scripts/mkimage.myappliance.sh aports/scripts/

cd aports

# IMPORTANT: run via profile name (not --profile)
MKIMG_PROFILE_DIR=../scripts ./scripts/mkimage.sh \
  -t "$ALPINE_VERSION" \
  -a "$ARCH" \
  myappliance