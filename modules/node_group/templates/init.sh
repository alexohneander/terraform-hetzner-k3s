#!/bin/bash

apt-get -yq update
apt-get install -yq \
    ca-certificates \
    curl \
    ntp \
    open-iscsi \
    findmnt \
    grep \
    awk \
    blkid \
    lsblk

# Enable iscsi
systemctl enable iscsid
systemctl start iscsid

# k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_CHANNEL=${k3s_channel} K3S_URL=https://${master_ipv4}:6443 K3S_TOKEN=${k3s_token} sh -s - \
    --kubelet-arg 'cloud-provider=external'
