#!/bin/bash
echo "PublicIP:"
read PUBLIC_IP

echo "NodeIP:"
read NODE_IP

export K3S_TOKEN=$(pwgen 25 1)
export INSTALL_K3S_SKIP_DOWNLOAD=true

curl -sfL https://get.k3s.io | sh -s - server \
    --cluster-init \
    --flannel-backend=wireguard-native \
    --flannel-iface=wg0 \
    --node-ip=$NODE_IP \
    --advertise-address=$NODE_IP \
    --node-external-ip=$PUBLIC_IP \
    --tls-san=$PUBLIC_IP # Optional, needed if using a fixed registration address

echo "K3S_TOKEN: $K3S_TOKEN"