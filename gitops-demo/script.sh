#!/bin/bash

# install docker
sudo apt update
curl -fsSL https://get.docker.com | sh
systemctl enable --now docker
sudo usermod -aG docker adminuser

newgrp docker

# install kind
curl -Lo ./kind \
https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind

# install kubectl
curl -LO \
"https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/