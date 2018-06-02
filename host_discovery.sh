#!/bin/sh

#About: This script is meant to be a quick way to discover basic information for host

#How to: When using this script from bseadm jumpbox, you can run in the following ways:

#ssh  <HOST or HOST.FQDN> 'bash -s' < host_discovery.sh

#TODO: fqdn function, other improvements

#vars

chkdns=$(cat /etc/resolv.conf)

sys=`uname -ar`
os=`uname -s`

sunos() {

#verifying if system is solaris
if [ "$os" = "SunOS" ]; then
        echo -e "$HOSTNAME is a solaris host"
    echo -e "gathering system information.."
    sleep 2
    echo -e "verifying host is up: "
        ping  $HOSTNAME
    if [ $? -eq 0 ]; then
                echo -e "host is up "
        else
                echo -e "host is down, please check for ilo access "
        fi
    echo -e "##############################################"
        sleep 5
    echo -e "verifying hostname: "
        echo -e $HOSTNAME
        echo -e "verifying OS, and kernel: $sys"
    echo -e "##############################################"
    echo -e "verifying uptime: "
    uptime
        echo -e "##############################################"
        echo -e "verifying dns servers: "
        echo -e $chkdns
    echo -e "##############################################"
        sleep 2
        echo -e "verifying vcs cluster exists: "
        cat /etc/llthosts &> /dev/null
        if [ $? -eq 0 ]; then
                echo -e "cluster exists"
        cat /etc/llthosts
        else
                echo -e "no cluster exists"
 fi
    echo -e "###############################################"
    zoneadm list -cv &> /dev/null
    if [ $? -eq 0 ]; then
                echo -e "zones exists on this host"
#        zoneadm list -cv
    else
        echo -e " no zones exists"
fi
fi
}
sunos
#verifying if system is linux
linuxos () {
if [ "$os" = "Linux" ]; then
    redhatver=$(cat /etc/redhat-release)
        echo -e "$HOSTNAME is a redhat linux host"
    echo -e "gathering system information.."
    sleep 2
    echo -e "verifying host is up: "
        ping -q -c2  $HOSTNAME > /dev/null
      if [ $? -eq 0 ]; then
                echo -e "$HOSTNAME is alive"
      else
                echo -e "$HOSTNAME must be down, please check access from ilo and service now if system has been decomed"
    sleep 3
        fi
        echo -e "##############################################"
    sleep 5
    echo -e "verifying hostname: "
    echo -e $HOSTNAME
    echo -e "verifying OS, and kernel: $sys"
    echo -e "##############################################"
        echo -e "verifying version of redhat: "
        echo -e $redhatver
        echo -e "##############################################"
    echo -e "verifying uptime: "
    uptime
    echo -e "##############################################"
    echo -e "verifying dns servers: "
    echo -e $chkdns
    echo -e "##############################################"
fi
}
linuxos

#verifying system is AIX
aixos() {
if [ "$OS" = "AIX" ]; then
    echo -e "$HOSTNAME is a aix  host"
    echo -e "gathering system information.."
    sleep 2
    echo -e "verifying host is up: "
    ping  $HOSTNAME
    echo -e "##############################################"
    sleep 5
    echo -e "verifying hostname: "
    echo -e $HOSTNAME
    echo -e "verifying OS, and kernel: $SYS"
    echo -e "##############################################"
    echo -e "verifying uptime: "
    uptime
    echo -e "##############################################"
    echo -e "verifying dns servers: "
    echo -e $chkdns
    echo -e "##############################################"
fi
}
aixos
