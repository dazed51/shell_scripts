#!/bin/bash
set -x

######################################################

#script to create bridge interface and enable systemd-networkd

#Using script
#  - uplink.network file enter interface name should start with en
#  - br0.network file enter network info you wish to use
# TESTING: was done on fedora 34 successfully, debian based systems will need to create /run/systemd/resolve directory and the resolv.conf with nameservers
#########################################################

#disable network manager and enable networkd

startnetd () {

echo -e "disabling network manager and enabling systemd-networkd"	
sleep 2
systemctl enable systemd-networkd
systemctl disable NetworkManager
systemctl enable systemd-resolved

sleep 2
echo -e "linking resolv.conf file to /etc/resolv.conf"
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
sleep 2

echo -e "verifying network directory exits"
if [ -d /etc/systemd/network ]; then
	echo "directory for bridge files exsits"
else 
        echo "directory for bridg file not found creating one"
	sleep 2
	mkdir -p /etc/systemd/network
fi

}
startnetd

#create files and add network information, uncomment and enter network info

sleep 2
netdir='/etc/systemd/network'
echo -e "creating files in network directory"
for i in uplink.network br0.netdev br0.network;
   do
    touch $netdir/$i; done
if [ $? -eq 0 ]; then 
   echo -e "files created successfully"
else
   echo -e  "something happened"
   exit 1
fi

echo -e "adding network info"
sleep 2

cat > ${netdir}/uplink.network << EOF 
[Match]
Name=enp4s0

[Network]
Bridge=br0
EOF

cat > ${netdir}/br0.netdev << EOF1

[NetDev]
Name=br0
Kind=bridge
EOF1

cat > ${netdir}/br0.network << EOF2

[Match]
Name=br0

[Network]
DNS=1.1.1.1
Address=172.20.4.250/24
Gateway=172.20.1.1
EOF2
if [ $? -eq 0 ]; then
   echo -e "files info added successfully"
else
   echo -e  "something happened"
   exit 1
fi


#restart systemd-networkd service
sleep 2
echo -e "restarting networkd after changes and checking status.."
systemctl restart systemd-networkd && sleep 2 && systemctl status  systemd-networkd




