CURRENT = $(shell uname -r)
KDIR = /lib/modules/$(CURRENT)/build
PWD = $(shell pwd)/drivers/bluetooth
MODDIR = /lib/modules/$(CURRENT)/kernel/drivers/bluetooth
MODNAME = btusb
MODVER = 0.8-custom
MODNAMELONG = $(MODNAME)/$(MODVER)

default:
	make -C $(KDIR) M=$(PWD) modules
	mv $(PWD)/btusb.ko .

clean:
	make -C $(KDIR) M=$(PWD) clean
	rm btusb.ko

install: default
	make -C $(KDIR) M=$(PWD) INSTALL_MOD_DIR=updates modules_install
	modprobe -r btusb
	modprobe btusb

dkms-install: uninstall
	modprobe -r btusb
	cp -r . /usr/src/$(MODNAME)-$(MODVER)
	dkms install $(MODNAMELONG)
	modprobe btusb

uninstall:
	modprobe -r btusb
	-dkms remove $(MODNAMELONG)
	rm -rf /usr/src/$(MODNAME)-$(MODVER)
	rm -f $(KDIR)/../updates/btusb.ko.zst
	depmod
	modprobe btusb

update:
	cd $(PWD) && ./update.sh
