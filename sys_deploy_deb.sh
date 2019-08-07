#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"


pkgs=(
"ansible"
"kernel-devel"
"gcc"
"make"
"flex"
"bison"
"vlc"
"python-pip"
"cmus"
"rtorrent"
"qemu-kvm"
"libvirt-clients"
"libvert-daemon-system"
"bridge-utils"
"virtinst"

)

for i in "${pkgs[@]}"
do 
   aptitude install $i -y;
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

echo -e "adding wireguard repo"
echo "deb http://deb.debian.org/debian/ unstable main" > /etc/apt/sources.list.d/unstable.list
printf 'Package: *\nPin: release a=unstable\nPin-Priority: 90\n' > /etc/apt/preferences.d/limit-unstable
sleep 2
echo -e "updating repo after adding wireguard"
aptitude update

echo -e "adding ansible tower"

cat << tower >> $atower
[localhost]
localhost
tower

echo -e "\n\n"

echo "pulling ansible system config"
ansible-pull -U https://github.com/dazed51/ansible_deb.git
