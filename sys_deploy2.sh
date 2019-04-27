#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"

echo -e "adding rpmfusion"
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sleep 2

echo -e "updating repos"
updater=$(dnf update && dnf upgrade -y)
if [ $? -eq 0 ]; then
   echo -e "updates applied successfully"
else
   echo -e "check why updates failed"
   exit 1
fi

pkgs=(
"ansible"
"kernel-devel"
"gcc"
"make"
"flex"
"bison"
"flatpak"
"vlc"
"python-pip"
)

for i in "${pkgs[@]}"
do 
   dnf install $i -y;
done

atower='/etc/ansible/hosts'

echo -e "\n\n"

if [ $? -eq 0 ]; then
    echo -e "git installed successfully..verifying" 
    which git
    which ansible
fi

echo -e "adding some stuff from pip repos and installing"
pip install youtube-dl

echo -e "installing flatpak repo and pkgs"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "adding ansible tower"

cat << tower >> $atower
[localhost]
localhost
tower

git clone https://github.com/dazed51/ansible_other.git

echo -e "\n\n"

echo "pulling ansible system config"
ansible-pull -U https://github.com/dazed51/ansible_other.git
