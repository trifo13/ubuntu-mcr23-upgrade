#!/bin/bash

sudo apt update && sudo apt install -y curl gnupg

sudo gpg --batch --yes \
  --output /usr/share/keyrings/mirantis-archive-keyring.pgp --dearmor \
  <<< "$(curl -fsSL https://repos.mirantis.com/ubuntu/gpg)"

sudo sed -i 's|^deb \[arch=amd64\] https://repos.mirantis.com/ubuntu focal stable|# &|' /etc/apt/sources.list

sudo tee -a /etc/apt/sources.list.d/mirantis.sources > /dev/null <<'EOF'
Types: deb
URIs: https://repos.mirantis.com/ubuntu
Suites: focal
Architectures: amd64
Components: stable-23.0
Signed-By: /usr/share/keyrings/mirantis-archive-keyring.pgp
EOF

sudo apt update

apt-cache policy docker-ee docker-ee-cli docker-ee-rootless-extras containerd.io

apt-cache madison docker-ee docker-ee-cli docker-ee-rootless-extras containerd.io

sudo apt install -y docker-ee docker-ee-cli docker-ee-rootless-extras containerd.io
