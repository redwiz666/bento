#!/bin/sh -eux

cat >> /etc/fstab <<BENTO
tmpfs    /tmp    tmpfs    defaults,noatime   0  0
tmpfs    /vagrant    tmpfs    defaults,noatime   0  0
BENTO
