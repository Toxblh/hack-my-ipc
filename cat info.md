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
```
