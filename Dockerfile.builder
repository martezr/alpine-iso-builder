FROM alpine:3.23

RUN apk add --no-cache \
    alpine-sdk \
    apk-tools \
    squashfs-tools \
    xorriso \
    syslinux \
    git \
    bash