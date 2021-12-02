#!/bin/bash

# VARIABLES
. variables

# Install packages
sudo apt install ca-certificates curl gnupg lsb-release netcat
sudo rm -f /usr/share/keyrings/docker-archive-keyring.gpg 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

# Setup docker
echo \
'{
    "insecure-registries": ["'$REPO'"]
}' | sudo tee /etc/docker/daemon.json
sudo usermod -aG docker $USER
sudo systemctl restart docker

# Install kubectl
sudo curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
sudo chown root. /usr/local/bin/kubectl && sudo chmod 755 /usr/local/bin/kubectl

# Install werf
# https://ru.werf.io/installation.html?version=1.2&channel=ea&os=linux&method=trdl&arch=amd64#%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0-%D0%B7%D0%B0%D0%B2%D0%B8%D1%81%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D0%B5%D0%B9
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bash_profile
export PATH="$HOME/bin:$PATH"
curl -L "https://tuf.trdl.dev/targets/releases/0.1.3/linux-amd64/bin/trdl" -o /tmp/trdl
mkdir -p ~/bin
install /tmp/trdl ~/bin/trdl
trdl add werf https://tuf.werf.io 1 b7ff6bcbe598e072a86d595a3621924c8612c7e6dc6a82e919abe89707d7e3f468e616b5635630680dd1e98fc362ae5051728406700e6274c5ed1ad92bea52a2
echo 'command -v trdl &>/dev/null && source $(trdl use werf 1.2 ea)' >> ~/.bashrc
werf version

# Install minikube
# https://minikube.sigs.k8s.io/docs/start/
# for Ubuntu:
sudo curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o /usr/local/bin/minikube

