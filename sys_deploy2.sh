#!/bin/bash

#install git

#grab repo

echo -e  "script to install git and other pre-req packages.."

sleep 2

echo -e "this script will also install ansible, and clone it"

echo -e "adding rpmfusion"
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

#echo -e "adding nvidia repo"
#dnf install fedora-workstation-respoitories
#dnf config-manager --set-enabled rpmfusion-nonfree-nvidia-driver

sleep 2

#echo -e "updating repos"
#updater=$(dnf update && dnf upgrade -y)
#if [ $? -eq 0 ]; then
 #  echo -e "updates applied successfully"
#else
 #  echo -e "check why updates failed"
 #  exit 1
#fi

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
"cmus"
"ruby"
"virt-manager"
"terminator"
"wireguard-tools"
"bpftrace"
"clang"
"firefox"
"open-vm-tools"
"thunderbird"
"git"
#akmod-nvidia"
"arc-theme"
"podman"
"podman-compose"
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


echo -e "installing flatpak repo and pkgs"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo -e "installing flatpaks now..."
sleep 2

for i in com.visualstudio.code  org.eclipse.Java  org.signal.Signal  com.slack.Slack; \
   do flatpak install flathub $i -y ; \ 
done \

#echo -e "installing desktop.."
#dnf groupinstall "Xfce Desktop" -y

#echo -e "enabling display manager.."
#systemctl disable gdm
#systemctl enable lightdm && systemctl set-default graphical.target

sleep 2

echo -e "adding ansible tower"

cat << tower >> $atower
[localhost]
localhost
tower

git clone https://github.com/dazed51/ansible_other.git

echo -e "\n\n"

echo "pulling ansible system config"
ansible-pull -U https://github.com/dazed51/ansible_other.git
