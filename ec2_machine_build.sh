!/bin/bash
shopt -u nocasematch
set -xe

#TODO: case statement to compare systems, REMINDER: clean up shell options, turn nocasematch to off, after turning it on to ignore lower case#

ubuntuos16=$(cat /etc/lsb-release | tr '"' ' ' | grep -i "description" | awk '{print $2 " "$3}' |  sed 's/.$//' | sed 's/.$//')
ubuntuos18=$(cat /etc/issue.net | awk '{print $1 " " $2}' | sed 's/.$//' | sed 's/.$//')
ubuntuos20=$(cat /etc/issue.net | awk '{print $1 " " $2}' | sed 's/.$//' | sed 's/.$//')
debianos=$(cat /etc/issue.net | awk '{print $1 " " $3}')
redhatos=$(cat /etc/redhat-release | awk '{print $1 " " $4}'| sed 's/\..*//')

#verify if machine is a centos machine or debian based


if [ "${redhatos}" == "CentOS 7" ]; then 
   echo "performing configuration for an redhat/centos server"; 
elif [ "${debianos}" == "Debian 9" ]; then
  echo "performing configuration for an debain server";
 elif [ "${ubuntuos20}" == "Ubuntu 20.04" ]; then
  echo "performing configuration for an ubuntu 20 server";
  sleep 2
  echo "installing pre-req packages, but first syncing repos.. "
  apt update -y && apt install aptitude -y && aptitude dist-upgrade -y
   #echo "machine is other, check to see what version of the os is running, goodbye"; 
   #exit 1
fi

sleep 2

echo -e "starting base configuration for machine running $redhatos"

#some var

aptpkgs=(
"nano"
"openssh-server"
"mutt"
"sudo"
"make"
"cmake"
"bison"
"bc"
"screen"
"mlocate"
"python3-pip"
)

for i in ${aptpkgs[@]}; do
    aptitude install $i -y
  if  [ $? -eq 0 ]; then
    echo -e "installing packages.."
  elif
    [ $? -eq 1 ]; then
    echo  -e "install of packages failed"
    sleep 2
    exit 1
fi
done

sleep 2

echo -e "adjusting systemctl timezone"
timedatectl set-timezone America/New_York

sleep 2 
echo -e "verifying  timezone.. "
timedatectl

echo -e "setting hostname"
hostnamectl set-hostname misp-prod01

echo -e "verifying hostname"
sleep 2
hostnamectl


the_brain()
{
bbanner='/etc/thebrain'
echo -e "setting the brain ssh banner..."
sleep 2

cat /home/vagrant/shell_scripts/thebrain > /etc/thebrain

}
the_brain

sleep 2

echo -e "syncing repos, and checking for any updates.. "
aptitude update -y && aptitude  dist-upgrade -y  && aptitude clean
