#!/bin/sh
wifi=`cat /proc/PW/WIFI`
wpa_exec=/gm/bin/wifi_rt8188/wpa_supplicant
echo "wifi=$wifi"
if [ "${wifi:0:4}" == "8188" ]; then
	wifidrv=/gm/drivers/8188eu.ko
	ifname=ra0
fi
if [ "${wifi:0:4}" == "8189" ]; then
	wifidrv=/gm/drivers/8188fu.ko
	ifname=wlan0
fi

echo "wifidrv=$wifidrv,ifname=$ifname"

case $1 in
	wpa)
		echo "reload wpa_supplicant"
		ps 
		killall -9 wpa_supplicant
		ps
		$wpa_exec -Dwext -i$ifname  -c /var/wpa_supplicant.c &
		ps
		;;

	drv)
		echo "reload wlan drv"
		lsmod
		rmmod $wifidrv
		lsmod
        echo "/sbin/insmod $wifidrv"
		/sbin/insmod $wifidrv
		lsmod
			;;
	all)
		echo "reload wlan drv & wpa"
		#ps
		killall -9 wpa_supplicant
		#ps
		rmmod $wifidrv
		#lsmod
		/sbin/insmod $wifidrv
		#lsmod
		sleep 2
		$wpa_exec -Dwext -i$ifname  -c /var/wpa_supplicant.c &
		#ps
		exit 0
		;;

	pre_ap_mode)
		echo "	pre_ap_mode ifname=$ifname"
		mkdir -p /var/lib/misc;
		touch /var/lib/misc/udhcpd.leases;
		mkdir -p /tmp/Wireless
		cp -f /usr/etc/rtl_hostapd_2G_$ifname.conf /tmp/Wireless/rtl_hostapd_2G.conf
		exit 0
		;;
	
	ap_mode)
		echo "enter ap mode ifname=$ifname"
		#ps
		killall -9 wpa_supplicant
		killall -9 udhcpd
		killall -9 hostapd
		#ps
		ifconfig $wifidrv down
		rmmod $wifidrv
		#lsmod
		/sbin/insmod $wifidrv
		#lsmod
		sleep 2
		#enter ap_mode
		/usr/sbin/hostapd /tmp/Wireless/rtl_hostapd_2G.conf -B 		
		sleep 2
		ifconfig $ifname 192.168.0.1;
		/usr/sbin/udhcpd  /usr/etc/udhcpd_$ifname.conf &
		exit 0
		;;
		
	sta_mode)
		echo "enter sta mode ifname=$ifname"
		#ps
		killall -9 wpa_supplicant
		killall -9 udhcpd
		killall -9 hostapd
		#ps
		ifconfig $wifidrv down
		rmmod $wifidrv
		#lsmod
		/sbin/insmod $wifidrv
		#lsmod
		sleep 2
		$wpa_exec -Dwext -i$ifname  -c /var/wpa_supplicant.c &
		#ps
		exit 0
		;;
		
	unload_all)
		echo "unload_all wlan drv & wpa"
		#ps
		killall -9 wpa_supplicant
		#ps
		rmmod $wifidrv
		exit 0
		;;
		
	load_all)
		echo "load_all wlan drv & wpa"
		#lsmod
		/sbin/insmod $wifidrv
		#lsmod
		sleep 2
		$wpa_exec -Dwext -i$ifname  -c /var/wpa_supplicant.c &
		#ps
		exit 0
		;;

	*)
		echo " usage: loadwlan drv/wpa/all"	
		;; 
esac 
