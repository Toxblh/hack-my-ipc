#!/bin/sh
#cpu_type=`cat /proc/PW/TYPE`
#SWID=`cat /proc/PW/SWID`

#type=${SWID:14:4}
#echo "SWID	type $type"
#if [ "$type" == "1700" ]; then
#	cpu_type=8136
#fi 
#if [ "$type" == "1701" ]; then
#	cpu_type=8135
#fi 
#if [ "$type" == "1702" ]; then
#	cpu_type=8135
#fi 


#if [ "${cpu_type:0:4}" == "8136" ]; then
#	cp /usr/gm/cfg/8136/gmlib.cfg /mnt/mtd/gmlib.cfg
#fi

#if [ "${cpu_type:0:4}" == "8135" ]; then
#	cp /usr/gm/cfg/8135/gmlib.cfg /mnt/mtd/gmlib.cfg
#fi

video=`cat /proc/PW/SENSOR`
video_frontend=${video:0:4}

SWID=`cat /proc/PW/SWID`

type=${SWID:14:4}
echo "SWID	type $type"
if [ "$type" == "1700" ]; then
	video_frontend=9712
fi 
if [ "$type" == "1701" ]; then
	video_frontend=9712
fi 
if [ "$type" == "1702" ]; then
	video_frontend=1045
fi 

echo "video_frontend $video_frontend"
case "$video_frontend" in
        "9715"|"9712"|"9710")
        	cp /usr/gm/cfg/8135/720P/gmlib.cfg /mnt/mtd/gmlib.cfg
        	echo "720P-gmlib"       
        ;;
        "1045"|"1145"|"1245")
		cp /usr/gm/cfg/8135/720P/gmlib.cfg /mnt/mtd/gmlib.cfg
		echo "720P-gmlib"       
        ;;
	"1225"|"0130"|"1135"|"1235"|"2143")
		cp /usr/gm/cfg/8135/960P/gmlib.cfg /mnt/mtd/gmlib.cfg
		echo "960P-gmlib"
        ;;
	"2136")
		cp /usr/gm/cfg/8135/1_3M/gmlib.cfg /mnt/mtd/gmlib.cfg
		echo "1_3M-gmlib"
        ;;
	"2135"|"2035"|"2145"|"0F22"|"2235")
		cp /usr/gm/cfg/8135/2MP/gmlib.cfg /mnt/mtd/gmlib.cfg
		echo "8135-2MP-gmlib"
	;;
     	*)
        echo "Invalid argument for video frontend: $video_frontend"
        exit
        ;;
esac

#cp /usr/gm/cfg/gmlib.cfg /mnt/mtd/gmlib.cfg

#mkdir -p /mnt/mtd/Config /mnt/mtd/Log /mnt/mtd/Config/ppp /mnt/mtd/Config/Json

#telnetd &

#timecheck &

#netinit &

#if [ -e /mnt/mtd/Config/RT2870STA.dat ]; then
#	echo "/mnt/mtd/Config/RT2870STA.dat, exist!";
#else
#	echo "no exist  exec cp RT2870STA.dat";
#	cp /usr/etc/RT2870STA.dat /mnt/mtd/Config/
#fi
