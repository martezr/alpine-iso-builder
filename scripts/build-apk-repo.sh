#!/usr/bin/env bash
set -euxo pipefail

APKBUILD_DIR="$(pwd)/aports-local"
REPO_DIR="$(pwd)/repo/packages"
KEY_DIR="$(pwd)/keys"

mkdir -p "$REPO_DIR" "$KEY_DIR"

# Install build tooling
apk add --no-cache alpine-sdk abuild

# Create build user (important fix for your earlier errors)
adduser -D builder
addgroup builder abuild
if [ -d "$APKBUILD_DIR" ]; then
  chown -R builder:builder "$APKBUILD_DIR"
fi
chown -R builder:builder "$APKBUILD_DIR"

# Init abuild environment (no doas, no root install issues)
su builder -c "abuild-keygen -a -n"

cp /home/builder/.abuild/*.rsa.pub /etc/apk/keys/
cp /home/builder/.abuild/*.rsa.pub "$KEY_DIR/"

# Build all custom APKs
for dir in "$APKBUILD_DIR"/*; do
  [ -d "$dir" ] || continue

  su builder -c "cd $dir && abuild -r"
done

# Copy packages into repo
find /home/builder/packages -type f -name "*.apk" -exec cp {} "$REPO_DIR" \;

# Index repo
apk index -o "$REPO_DIR/APKINDEX.tar.gz" "$REPO_DIR"/*.apk