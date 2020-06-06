#Transfer vg_boot.sh spec.cfg param.cfg from master to slave site (/mnt/mtd)
boot_actor=single
free -m
mount -t cramfs /dev/mtdblock3  /usr
mount -t cramfs /dev/mtdblock4  /mnt/voice
mount -t cramfs /dev/mtdblock5  /mnt/custom
mount -t jffs2  /dev/mtdblock6  /mnt/mtd 

/mnt/voice/wdt 120

#/sbin/insmod /gm/drivers/frammap.ko
#cat /proc/frammap/ddr_info

mkdir -p /mnt/mtd/Config /mnt/mtd/Log /mnt/mtd/Config/ppp /mnt/mtd/Config/Json

telnetd &
free -m
#timecheck &

#/gm/bin/netinit &

if [ -e /mnt/mtd/Config/RT2870STA.dat ]; then
        echo "/mnt/mtd/Config/RT2870STA.dat, exist!";
else
        echo "no exist  exec cp RT2870STA.dat";
        cp /etc/wifi/RT2870STA.dat /mnt/mtd/Config/
fi

if [ -e /mnt/mtd/up_state.txt ]; then
        echo "mnt/mtd/up_state.txt, exist!";
else
        echo "no exist  exec cp up_state.txt";
        cp /etc/wifi/up_state.txt /mnt/mtd/
fi

video=`cat /proc/PW/SENSOR`
video_frontend=${video:0:4}
wifi=`cat /proc/PW/WIFI`
cpu_type=`cat /proc/PW/TYPE`

SWID=`cat /proc/PW/SWID`

type=${SWID:14:4}
echo "SWID      type $type"
if [ "$type" == "1700" ]; then
        cpu_type=8136
        video_frontend=9712
        wifi=8188
fi
if [ "$type" == "1701" ]; then
        cpu_type=8135
        video_frontend=9712
        wifi=8188
fi
if [ "$type" == "1702" ]; then
        cpu_type=8135
        video_frontend=1045
        wifi=8188
fi



echo "cpu_type $cpu_type"
echo "wifi $wifi"
echo "sensor $video_frontend"

ifname=ra0
if [ "${wifi:0:4}" == "8188" ]; then
        echo "/sbin/insmod /gm/drivers/8188eu.ko"
        /sbin/insmod /gm/drivers/8188eu.ko
		ifname=ra0
fi
if [ "${wifi:0:4}" == "8189" ]; then
        echo "/sbin/insmod /gm/drivers/8188fu.ko"
        /sbin/insmod /gm/drivers/8188fu.ko
		ifname=wlan0
fi

if [ "${wifi:0:4}" == "7601" ]; then
        echo "/sbin/insmod /gm/drivers/mt7601.ko"
        /sbin/insmod /gm/drivers/mtutil7601Usta.ko
        /sbin/insmod /gm/drivers/mt7601Usta.ko
        /sbin/insmod /gm/drivers/mtnet7601Usta.ko
		ifname=wlan0
fi

free -m
echo "ready start wpa_supplicant{$ifname}"

cp /etc/wifi/wpa_supplicant.c /var

mkdir -p /var/run/wpa_supplicant

#cp /gm/bin/wifi_rt8188/wpa_supplicant /var/

/gm/bin/wifi_rt8188/wpa_supplicant -Dwext -i$ifname  -c /var/wpa_supplicant.c &
#/var/wpa_supplicant -Dwext -i$ifname  -c /var/wpa_supplicant.c &

free -m
echo "wpa start ok"

sh /usr/etc/user_pre.sh
# for get pci_epcnt/cpu_enum
# pci_epcnt = n, the GM8210_EP count.
# cpu_enum = 0(host_fa726), 1(host_fa626), 2(host_7500), 3(dev_fa726), 4(dev_fa626)

sh /usr/gm/sh/vg_boot.sh
#sh /mount-tf.sh

sh /usr/etc/user.sh


