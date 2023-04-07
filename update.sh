#!/bin/sh

for i in $(echo "intel bcm rtl mtk" | sed 's/ /\n/g'); do
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/drivers/bluetooth/bt$i.h"
	curl -O "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/drivers/bluetooth/bt$i.c"
done

curl -o 'btusb.update.c' 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/drivers/bluetooth/btusb.c'

echo "\nupstream btusb.c"
diff -u btusb.c btusb.update.c 
