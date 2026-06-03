#!/usr/bin/env bash
set -euxo pipefail

ALPINE_VERSION=v3.23
ARCH=x86_64

git clone --depth 1 \
    --branch ${ALPINE_VERSION} \
    https://github.com/alpinelinux/aports.git

cp profiles/mkimg.myappliance.sh \
    aports/scripts/

cd aports

./scripts/mkimage.sh \
    --tag "${ALPINE_VERSION}" \
    --arch "${ARCH}" \
    --profile myappliance \
    --outdir ../output \
    --repository \
      https://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/main \
    --repository \
      https://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/community