profile_myappliance() {
    profile_standard

    title="My Appliance"

    apks="
        alpine-base
        linux-lts
        linux-firmware
        openssh
        curl
        jq
        demo
    "

    repositories="
        http://dl-cdn.alpinelinux.org/alpine/v3.23/main
        http://dl-cdn.alpinelinux.org/alpine/v3.23/community
        file://repo/packages
    "

    kernel_cmdline="quiet"
}