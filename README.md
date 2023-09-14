My patch to fix `hci0: Opcode 0x c77 failed: -56` issue from kernel log and
`No default controller available` in bluetoothctl. Stuttering audio in bluetooth
device will also be fixed (in my case) probably because the kernel is using
generic driver as fallback.

## Applying patch

The patch is simply adding the hardware ID and manufacturer of the bluetooth
device to usb device table in `btusb.c`. For alternative way check
[this branch](https://github.com/Cudiph/btusb/tree/patchfile)

1. Update code to current kernel version and Get the ID

```console
$ ./update.sh
$ lsusb | grep tooth
Bus 002 Device 003: ID 13d3:3537 IMC Networks Bluetooth Radio
```

2. stage the changes with `$ git add .` so next diff from git will only show the
   custom patch

3. Edit the source code

```diff
static const struct usb_device_id blacklist_table[] = {
  ...

	/* Additional Realtek 8822BE Bluetooth devices */
	{ USB_DEVICE(0x13d3, 0x3526), .driver_info = BTUSB_REALTEK },
+	{ USB_DEVICE(0x13d3, 0x3537), .driver_info = BTUSB_REALTEK },
	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },

  ...
}
```

4. Generate the patch with

```sh
git diff > btusb.patch
```

5. Apply patch with

```sh
patch < btusb.patch
```

6. Install module manually

```sh
sudo make install
```

or using dkms (will automatically rebuild when updating kernel)

```sh
sudo make dkms-install
```

## Uninstalling

```sh
sudo make uninstall
```

## References

- https://askubuntu.com/questions/791584/bluetooth-not-working-in-ubuntu-16-04-with-0cf33004-atheros-adapter
- https://gist.github.com/hwchong/8738e100ec4e140bae2cac2894c29d65
