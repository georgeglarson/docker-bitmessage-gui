#!/bin/bash
# filename: install.sh
set -euxo pipefail

#download Docker container image
docker pull j0rg3/docker-bitmessage-gui

# make directory for Bitmessage configuration, data and SSH keys
# nothing will happen if directory already exists
mkdir -p ~/.config/PyBitmessage/keys

# generate keys for SSH
cd ~/.config/PyBitmessage/keys
ssh-keygen -b 4096 -P "" -C $"$(whoami)@$(hostname)-$(date -I)" -f docker-bitmessage-keys

# link so Docker container will see as pubkey
ln -s docker-bitmessage-keys.pub authorized_keys

# link to Bitmessage script for system-wide access
ln -s ~/docker-bitmessage/bitmessage /usr/local/bin/bitmessage


