#!/bin/sh -eux

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >> /etc/network/interfaces

cat >> /etc/network/interfaces <<BENTO
auto eth0
allow-hotplug eth0
iface eth0 inet dhcp
BENTO
