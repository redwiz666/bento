#!/bin/sh -eux

debian_version="`lsb_release -r | awk '{print $2}'`";
major_version="`echo $debian_version | awk -F. '{print $1}'`";
version_code="`lsb_release -c -s`"

if [ "$major_version" -le "7" ]; then
  # EOL
  wget "https://apt.puppetlabs.com/puppet5-release-${version_code}.deb"
  dpkg -i "puppet5-release-${version_code}.deb"
  apt-get update -y
  apt-get install -y puppet-agent
else
  apt-get install -y puppet
fi
