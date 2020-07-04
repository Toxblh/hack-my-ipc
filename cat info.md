# Cat something info about camera

```shell
[root@GM]# cat /proc/PW/SENSOR
2145
[root@GM]# cat /proc/PW/WIFI
8188
[root@GM]# cat /proc/PW/TYPE
8135
[root@GM]# cat /proc/PW/SWID
0000000000000000000000000000000000
[root@GM]# SWID=`cat /proc/PW/SWID`
[root@GM]# echo ${SWID:14:4}
0000
[root@GM]# cat /proc/cpuinfo
Processor       : FA6 rev 3 (v5l)
BogoMIPS        : 709.42
Features        : swp half
CPU implementer : 0x66
CPU architecture: 5TE
CPU variant     : 0x0
CPU part        : 0x626
CPU revision    : 3

Hardware        : Grain-Media GM8136 series
Revision        : 0000
Serial          : 0000000000000000
```

GM8136S,SC2145

LIBDVR : FILE -> misc/scanbus.c, LINE -> 43: fopen :/proc/scsi/scsi
===> line major minor  #blocks  name

===> line

===> line   31        0        512 mtdblock0

===> line   31        1       1856 mtdblock1

===> line   31        2       4672 mtdblock2

===> line   31        3       5248 mtdblock3

===> line   31        4       2048 mtdblock4

===> line   31        5       1024 mtdblock5

===> line   31        6       1024 mtdblock6

===> line  179        0   62521344 mmcblk0

LIBDVR : FILE -> misc/scanbus.c, LINE -> 320: opendir /proc/scsi/usb-storage/
usb_num -1, disk_num 0
scsin:0
type:2
sdx:0
blocks:62521344
name:/dev/mmcblk0

============> InitStorageDev 144:devnum 1
============> InitStorageDev 152:type 2 devinfo[MMC_TYPE] 0
============> InitStorageDev 216:info[0].name /dev/mmcblk0
============> InitStorageDev 228
============> InitStorageDev 239
============> InitStorageDev 244: total_sect 125042688(0x7740000)
============> InitStorageDev 259
