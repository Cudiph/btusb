#!/bin/sh

KERNEL_SEMVER=$(uname -r | cut -d- -f1)
PATCH_VER=$(echo "$KERNEL_SEMVER" | cut -d. -f3)

if [ "$PATCH_VER" = '0' ]; then
    KERNEL_SEMVER=$(echo "$KERNEL_SEMVER" | awk -F ".0" '{print $1}')
fi

for i in $(echo "intel bcm rtl mtk" | sed 's/ /\n/g'); do
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.h?h=v$KERNEL_SEMVER"
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/bt$i.c?h=v$KERNEL_SEMVER"
done

curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/plain/drivers/bluetooth/btusb.c?h=v$KERNEL_SEMVER"
