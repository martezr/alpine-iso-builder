profile_myappliance() {
    profile_standard

    kernel_addons=""

    apks="$apks \
        alpine-base \
        openssh \
        curl \
        jq"

    hostname="my-appliance"

    kernel_cmdline="quiet"
}