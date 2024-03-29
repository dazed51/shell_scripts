#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"

aptpkgs=(

"cmake"
"make"
"gcc"
"python-pip"
"cmus"
"rtorrent"
"vim"
"snapd"
"bpftrace"
"terminator"
"ruby"
"ruby-dev"
"gedit"
"git"
"ansible"
"bcc"
"bc"
"python3-pip"
)


for i in "${aptpkgs[@]}"
do
    aptitude install $i -y
done

#ansible location

atower='/etc/ansible/hosts'

echo -e "\n\n"

echo -e "installing snap to install stuff"

#snap install signal-desktop
#snap install tusk
#snap install --classic
snap install slack --classic

if [ $? -eq 0 ]; then
    echo -e "git installed successfully..verifying" 
    which git
    which ansible
fi

cat << tower >> $atower
[localhost]
localhost
tower

echo -e "cloning repo sys setup repo"

sleep 5

git clone https://github.com/dazed51/ansible.git

echo -e "\n\n"

echo "pulling ansible system config"
ansible-pull -U https://github.com/dazed51/ansible.git
