#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# Configuration
###############################################################################

ALPINE_MAJOR_MINOR="3.23"
ALPINE_TAG="v3.23"
ARCH="x86_64"

WORKDIR="$(pwd)"
APORTS_DIR="${WORKDIR}/aports"
OUTPUT_DIR="${WORKDIR}/output"

###############################################################################
# Cleanup previous build artifacts
###############################################################################

rm -rf "${APORTS_DIR}"
mkdir -p "${OUTPUT_DIR}"

###############################################################################
# Clone matching Alpine aports branch
###############################################################################

git clone \
  --depth 1 \
  --branch "${ALPINE_MAJOR_MINOR}-stable" \
  https://github.com/alpinelinux/aports.git \
  "${APORTS_DIR}"

###############################################################################
# Copy custom mkimage profile
###############################################################################

cp \
  "${WORKDIR}/profiles/mkimg.myappliance.sh" \
  "${APORTS_DIR}/scripts/"

###############################################################################
# Optional: Copy custom apkovl generator
###############################################################################

if [[ -f "${WORKDIR}/overlays/genapkovl-myappliance.sh" ]]; then
  cp \
    "${WORKDIR}/overlays/genapkovl-myappliance.sh" \
    "${APORTS_DIR}/scripts/"
fi

###############################################################################
# Build ISO
###############################################################################

cd "${APORTS_DIR}"

./scripts/mkimage.sh \
  --tag "${ALPINE_TAG}" \
  --arch "${ARCH}" \
  --profile myappliance \
  --outdir "${OUTPUT_DIR}" \
  --repository "https://dl-cdn.alpinelinux.org/alpine/${ALPINE_TAG}/main" \
  --repository "https://dl-cdn.alpinelinux.org/alpine/${ALPINE_TAG}/community"

###############################################################################
# Results
###############################################################################

echo
echo "ISO build complete."
echo "Output directory:"
echo "  ${OUTPUT_DIR}"
echo

find "${OUTPUT_DIR}" -type f -name "*.iso"