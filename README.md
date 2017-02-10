# j0rg3/docker-bitmessage-gui 


# Bitmessage GUI in a Docker container

- [Introduction](#introduction)
- [Installation](#installation)
- [Notes](#notes)
- [References](#references)


# Introduction
The purpose of this project is to make the Bitmessage GUI interface available on a system, through a [Docker](https://www.docker.com/) container, with the fluidity of applications natively installed.

A description of how and why this project came to be can be found at [`j0rg3.com`](http://j0rg3.com).

# Installation
```bash
git clone https://github.com/georgeglarson/docker-bitmessage-gui

cd docker-bitmessage-gui

.\install.sh
```

The installation script will:
- pull Docker image
- make local directories
- generate SSH keys
- create symbolic links

Alternatively, you can execute the commands yourself:
```bash
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
```

# Notes
The commands contained in the 'bitmessage' script:
```bash
DID=$(docker run -p 8444:8444 -v ~/.config/PyBitmessage/:/root/.config/PyBitmessage -v ~/.config/PyBitmessage/keys/:/root/.ssh/ -dit j0rg3/bitmessage-gui bash) && \
DIP=$(docker inspect $DID | grep IPAddress | cut -d '"' -f 4) && \ 
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -oIdentityFile=~/.config/PyBitmessage/keys/docker-bitmessage-keys -X $DIP ./PyBitmessage/src/bitmessagemain.py && \
docker kill $DID
```

# References
[http://j0rg3.com](http://j0rg3.com)


