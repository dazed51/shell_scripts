#!/bin/bash

#change hostname passing argument
#null minion_id file
#restart minion service
#change /etc/hosts file

minionid='/etc/salt/minion_id'
old_hostname="$(hostname)"
new_hostname="$1"

if [ -z "$new_hostname" ]; then
   echo -n "please enter new hostname: "
   read new_hostname < /dev/tty
fi

if [ -z "$new_hostname" ]; then
   echo "error: no hostname entered. exiting"
   exit 1
fi

echo "changing hostname from $old_hostname to $new_hostname"

hostnamectl set-hostname $new_hostname

sleep 2

echo -e "removing old hostname from $minionid"

cat  /dev/null > $minionid

if [ $? -eq 0 ]; then
   echo -e "name was nulled successfully"
   sleep 2
   echo -e "verifying file"
   cat $minionid
   sleep 2
   echo -e "restarting minion service..." 
   service salt-minion restart
   sleep 2
   service salt-minion status
   sleep 2
   echo -e "verifying $minionid .."
   sleep 2
   cat $minionid
else
   echo -e "updating of name failed, please check"
   exit 1

fi










