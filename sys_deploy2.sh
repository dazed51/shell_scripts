#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"

gitinstall=$(dnf install git -y ) 
updaterepo=$(dnf update && dnf upgrade -y)
ansibleinstall=$(dnf install ansible -y)
getatom=$(wget https://atom.io/download/rpm)

echo -e "installing git" $gitinstall
echo -e "installing commons" $ansiblerepo
echo -e " installing ansible repo" $pull

sleep 2

echo "installing ansible" $ansibleinstall
echo "updating system" $upaterepo

echo -e "\n\n"

if [ $? -eq 0 ]; then
    echo -e "git installed successfully..verifying" 
    which git
    which ansible
fi

sleep 3


sleep 2
rpm -ivh *.rpm
echo -e "grabbing atom text editor and installing" $getatom

echo -e "cloning repo sys setup repo"

sleep 5

git clone https://github.com/dazed51/ansible_other.git

echo -e "\n\n"

echo "pulling ansible system config"
ansible-pull -U https://github.com/dazed51/ansible_other.git
