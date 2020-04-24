#!/bin/bash

echo -e "script must but run as root, or at least have privledges to it"

sleep 2

if [ $(id -u) = 0 ]; then
   echo -e "looks you are root"
else
   echo -e "your are someone other then root"
   exit 1
fi

function rmnetplan () {
   echo -e "removing netplan"
   aptitude remove netplan.io -y -qq
   aptitude purge netplan.io -y  -qq
   echo -e holding netplan back so that will not be installed
   apt-mark hold netplan.io

   if [ -d  /etc/netplan ]; then
    echo -e "removing netplan config files"
    rm -rf /etc/netplan 
  else
    echo -e "files dont exist, they must have been already removed"
  fi

}
rmnetplan 

sleep 2

if [ $? -eq 0 ]; then
   echo -e "netplan removed successully"
else
   echo -e "netplan is still installed"
   exit
fi

sleep 2

echo -e "enabling networkd system and adding networkd dhcp conifguration"

function netdconfig () {

systemctl enable systemd-networkd
sleep 2
systemctl disable NetworkManager 

netfile='/etc/systemd/network/99-wildcard.network'

if [ ! -f ${netfile} ]; then
  echo -e "systemd network file does not exist, adding configuartion"
fi

cat > ${netfile} << EOF 
[Match]
Name=en* #after script is executed make adjustment as need as it pertains to the name of your NIC
  
[Network]
DHCP=yes
EOF

}
netdconfig

function dnsdconfig() {

echo -e "enabling systemd-resolved"
systemctl enable systemd-resolved

dnsfile='/run/systemd/resolve/resolv.conf'

if [  -f ${dnsfile} ]; then
  echo -e "file exists creating symlink"
  rm /etc/resolv.conf
  sleep 2
  ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
fi
}
dnsdconfig

echo -e "removal of netplan complete, enabling and configuration of networkd is complete!, please reboot your system!"
echo -e "after the reboot ensure that netword is able to pull an ip, dns etc using the following cmds"
echo  -e "\n\n"
echo -e "verify network: networkctl"
echo -e "verify interface: networkctl list <interface>"
echo -e "verify dns: systemd-resolve --status" 
