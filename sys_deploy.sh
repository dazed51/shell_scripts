#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"

gitinstall=$(apt-get install git -y )
ansiblerepo=$(apt-get install software-properties-common -y) 
pull=$(apt-add-repository ppa:ansible/ansible -y)
updaterepo=$(apt-get update && apt-get upgrade -y)
ansibleinstall=$(apt-get install ansible -y)
getatom=$(wget https://atom.io/download/deb)
getsnapd=$(apt-get install snapd -y)

#ansible location

atower='/etc/ansible/hosts'

echo -e "installing git" $gitinstall
echo -e "installing commons" $ansiblerepo
echo -e " installing ansible repo" $pull

sleep 2

echo "installing ansible" $ansibleinstall
echo "updating system" $upaterepo

echo -e "\n\n"

echo -e "installing snap to install stuff" $getsnapd

snap install spotify
snap install tusk


if [ $? -eq 0 ]; then
    echo -e "git installed successfully..verifying" 
    which git
    which ansible
fi

sleep 3


sleep 2
dpkg -i *.deb
echo -e "grabbing atom text editor and installing" $getatom


echo -e "adding ansible tower"

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
