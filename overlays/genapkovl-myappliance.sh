#!/bin/sh

set -eu

mkdir -p "$tmpdir/etc"

cat > "$tmpdir/etc/motd" <<EOF
Custom Alpine Appliance
EOF