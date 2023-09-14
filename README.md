## creating patch and install
1. clone this repo 
1. edit the btusb source code or other parts.
1. `$ git diff > patches/btusb.patch`
1. `# dkms install .`

## Maintenance
`$ make update`

