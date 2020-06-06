#!/bin/sh
eth_ip=192.168.10.201
case $1 in
	1)
		eth_ip=192.168.10.201
		;;

	2)
		eth_ip=192.168.10.202
		;;

	3)
		eth_ip=192.168.10.203
		;;

	4)
		eth_ip=192.168.10.204
		;;

	5)
		eth_ip=192.168.10.205
		;;
		
	*)
		echo " usage: $0 (1--5)"
		exit 0		
		;; 
esac 
echo "set eth0 ip-$eth_ip"
ifconfig eth0 $eth_ip up
sleep 2
mount -t nfs -o nolock 192.168.10.59:/home/share/sdx/General /mnt/nfs
cd /var 
ls -l /mnt/nfs/gm_steppermotor.ko
cp /mnt/nfs/gm_steppermotor.ko .
cp /mnt/nfs/TestTool .
cp /mnt/nfs/pt*.cfg .
./TestTool -l
ls -l
rmmod gm_steppermotor.ko
insmod gm_steppermotor.ko	
lsmod
