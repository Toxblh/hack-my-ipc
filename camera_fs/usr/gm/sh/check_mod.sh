#!/bin/bash

echo "ready to check mod2"
modinfo_file=/tmp/modinfo
#care_mod_str="frammap ft3dnr200 adda308 vcap300_common vcap0 vcap300_isp vpd_slave vpd_master fisp_algorithm"
care_mod_str="frammap ft3dnr200 adda308 vcap300_common vcap0 vcap300_isp vpd fisp_algorithm"
#care_mod_str="dm_mod"
care_mod_num=8
#9
care_mod_loaded_num=0
care_mod_live_num=0

cat /proc/modules | cut -d' ' -f1,5 > $modinfo_file
cat $modinfo_file

echo "****care modules list[$care_mod_num] "
echo $care_mod_str 

while read mod_info
do
	local modu_name=${mod_info%' '*}
	local modu_status=${mod_info/*' '}
	
	local is_care=0
#	case "$modu_name" in
#		"frammap"|"ft3dnr200"|"adda308"|"vcap300_common"|"vcap0"|"vcap300_isp"|"vpd_slave"|"vpd_master"|"fisp_algorithm")
#			is_care=1
#        ;;
#	esac
	case "$modu_name" in
		"frammap"|"ft3dnr200"|"adda308"|"vcap300_common"|"vcap0"|"vcap300_isp"|"vpd"|"fisp_algorithm")
			is_care=1
        ;;
	esac
	
	local is_live=0
	if [ $modu_status = "Live" ]; then 
		is_live=1
	fi
	if [ $is_care -eq 1 ]; then
		echo "modinfo=<$mod_info> =>"
		echo "name=<$modu_name>status=<$modu_status>is_care=[$is_care]is_live=[$is_live]"
		let care_mod_loaded_num=$care_mod_loaded_num+1 
		if [ $is_live -eq 1 ]; then
			let care_mod_live_num=$care_mod_live_num+1 
		fi
	fi
done < $modinfo_file
echo "****result: live mod=$care_mod_live_num, care mod=$care_mod_num"
if [ $care_mod_live_num -eq $care_mod_num ]; then
    echo "start-----"
    exit
else
	echo "reboot-Ready set WatchDog"
	#reboot
	/mnt/voice/wdt 1
	echo "Reboot 1s later"
fi
