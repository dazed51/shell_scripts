#!/bin/bash

#script to install splunk forwarder on centos/debian/ubuntu/machines

#HOWTO: 

# - where latest x x is the in the script, add the pacakge to be installed and then uncomment the line as needed
# - enter ip address of forwarder server and deploy server if its apply's to your setup

set -xe

ubuntuos16=$(cat /etc/lsb-release | tr '"' ' ' | grep -i "description" | awk '{print $2 " "$3}' |  sed 's/.$//' | sed 's/.$//')
ubuntuos18=$(cat /etc/issue.net | awk '{print $1 " " $2}' | sed 's/.$//' | sed 's/.$//')
debianos=$(cat /etc/issue.net | awk '{print $1 " " $3}')
redhatos=$(cat /etc/redhat-release | awk '{print $1 " " $4}'| sed 's/\..*//')

if [ "${redhatos}" == "CentOS 7" ]; then 
   echo "performing configuration for an redhat/centos server"; 
   #rpm -ivh {lateset rpm  package}
elif [ "${debianos}" == "Debian 9" ]; then
  echo "performing configuration for an debain server";
  #dpkg -i {latest debian package}
elif [ "${ubuntuos16}" == "Ubuntu 16.04" ]; then
  echo "installing forwarder on ${ubuntuos16}"
  #dpkg -i {latest debian package}
elif [ "${ubuntuos18}" == "Ubuntu 18.04" ]; then
   echo "installing forwarder on ${ubuntuos18}"
   #dpkg -i {latest debian package}
fi

echo -e "starting splunk at boot, communication with forwarder server, and deploy server"
sleep 2

/opt/splunkforwarder/bin/splunk enable boot-start #accept license, enter creds for admin user
/opt/splunkforwarder/bin/splunk add forward-server x.x.x.x:9997 #enter forwarder ip 
/opt/splunkforwarder/bin/splunk set deploy-poll x.x.x.x:8089 #enter deploy  ip 

if [ $? -eq 0 ]; then
   echo -e "boot start, and comm started successfully"
else
   echo -e "something went wrong quitting"
   exit 1
fi

echo -e "starting splunk now that configuration is complete"
sleep 2
/etc/init.d/splunk start  
sleep 2
 /etc/init.d/splunk status
