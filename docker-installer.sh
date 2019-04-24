#!/bin/sh

#
# This script installs Docker to Raspberry Pi.
# You need to sudo to execute it.
#

apt-get install apt-transport-https ca-certificates software-properties-common -y
curl -fsSL get.docker.com -o get-docker.sh && sh get-docker.sh
usermod -aG docker pi
curl https://download.docker.com/linux/raspbian/gpg
deb https://download.docker.com/linux/raspbian/ stretch stable >> /etc/apt/sources.list
apt-get update
apt-get purge docker-ce
apt-get update
apt-get install docker-ce=18.06.2~ce~3-0~raspbian
systemctl start docker.service
