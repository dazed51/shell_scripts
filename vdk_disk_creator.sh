#!/bin/bash

#script to create qcow2 images, passing the name of disk and size from the cli

#syntax example: sudo qemu-img create -f qcow2 ubuntu-box2-vm-disk1-5G 5G

#script to run as bash vdk_disk_creat.sh $1(name of image) $2(disk size)

imgname="$1"
imgsize="$2"

virt_disk_create()
{
    echo -e "creating disk image"
    sleep 2
    qemu-img create -f qcow2 $1  $2  2> /dev/null

    if [ $? == 0 ];
        then 
            echo -e "creating disk.."
        else
            echo -e "something went wrong, please input correct values"
    fi

    if [ -z "$1" ];
        then 
            echo -e "nothing passed, acceptable input is name and than size of disk"
        exit 1
    fi
}
virt_disk_create "$1" "$2"