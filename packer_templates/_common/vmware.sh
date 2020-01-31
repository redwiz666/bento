#!/bin/sh -eux

case "$PACKER_BUILDER_TYPE" in
vmware-iso|vmware-vmx)

    apt install open-vm-tools -y
esac
