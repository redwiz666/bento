#!/bin/sh -eux

apt-get update;

apt-get -y install linux-headers-`uname -r`;
