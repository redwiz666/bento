#!/bin/sh -eux

arch="`uname -r | sed 's/^.*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\(-[0-9]\{1,2\}\)-//'`"
debian_version="`lsb_release -r | awk '{print $2}'`";
major_version="`echo $debian_version | awk -F. '{print $1}'`";
version_code="`lsb_release -c -s`"

# Update EOL APT repositories
if [ "$major_version" -le "7" ]; then
  cat <<EOF >>/etc/apt/sources.list;
  deb http://archive.debian.org/debian/ $version_code main
  deb-src http://archive.debian.org/debian/ $version_code main
  deb http://archive.debian.org/debian-security $version_code/updates main
  deb-src http://archive.debian.org/debian-security $version_code/updates main
EOF

  echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99allow_unauth
fi

# Disable systemd apt timers/services
if [ "$major_version" -ge "9" ]; then
  systemctl stop apt-daily.timer;
  systemctl stop apt-daily-upgrade.timer;
  systemctl disable apt-daily.timer;
  systemctl disable apt-daily-upgrade.timer;
  systemctl mask apt-daily.service;
  systemctl mask apt-daily-upgrade.service;
  systemctl daemon-reload;
fi

# Disable periodic activities of apt
cat <<EOF >/etc/apt/apt.conf.d/10periodic;
APT::Periodic::Enable "0";
APT::Periodic::Update-Package-Lists "0";
APT::Periodic::Download-Upgradeable-Packages "0";
APT::Periodic::AutocleanInterval "0";
APT::Periodic::Unattended-Upgrade "0";
EOF

apt-get update;

apt-get -y upgrade linux-image-$arch;
apt-get -y install linux-headers-`uname -r`;
