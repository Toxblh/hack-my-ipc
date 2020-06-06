#!/bin/sh
if [ -e "/dev/mmcblk0" ]; then
	echo "mount sd card"
	fsck.fat -a /dev/mmcblk0
	mount -t vfat /dev/mmcblk0 /mnt/sd0
	ls -l /mnt/sd0
fi	
