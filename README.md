# Hack my IP camera - My long story (not finished yet)

I bought my first secure camera, and think it will be great! Nobody can't to connect and grab video direct without copy additional soft. Nobody can't read a flashcard if steal the camera. I can connect only via an application and need to use a password for decrypt the video stream... It's cool until then you create a smart home and would like to connect the camera only in a local network without access to the internet for the camera. And have access inside the home using an encrypted VPN network.

I bought a camera on amazon. And I would like to send encrypted video stream to my home server (rPI) for analyse video and send a useful notification for some action. Also, my general idea it is video recognition where is my cat and follow it. It's needed when I'm not at home to see all good or not.

PS I asked the seller about how to get RSTP or ONVIF stream and nothing only via their service (but how long it will be live? It's a cloud! No internet - and that transform to high-tech rubbish)

But I bought really not a bad secure camera. And I start my hack with Nmap

Nmap show to me open ports

```shell
telnet 23
unknow 34567
unknow 23456
```

Okay next step it was to find a password, few hours to try password from the internet (yes it's a bit slow, but I had time)

```shell
login: root
password: noty
```

And I in!

```shell
login: can't chdir to home directory '/root'
Welcome to

    _____    __      ___       __     ___       _     _    _
   |  ___|  /  \    / __ \    /  \   |  _ \    /  \   \ \ / /
   | |___  / /\ \  | /__\ \  / /\ \  | | \ |  / /\ \   \ V /
   |  ___|| |__| | |  _   / | |__| | | | | | | |__| |   \ /
   | |    |  __  | | |  \ \ |  __  | | |_/ / |  __  |   | |
   |_|    |_|  |_| |_|   \_\|_|  |_| |___ /  |_|  |_|   |_|

For further information check:
http://www.faraday.com/



BusyBox v1.19.4 (2017-06-05 13:11:43 CST) built-in shell (ash)
Enter 'help' for a list of built-in commands.
[root@GM]#
```

Cool! I think - "It super still needs to reconfigure the main process for open RTSP stream or another and it will be done! But If I found how to send photos from the camera already will be awesome!"

_And it was a start of my epopee..._

And fast check what I have

```shell
[root@GM]# uname -a
Linux 3.3.0 #19 PREEMPT Tue Sep 19 09:20:55 CST 2017 armv5tel GNU/Linux
```

Nice it's Linux for ARM v5tel

```shell
[root@GM]# ps
  PID USER       VSZ STAT COMMAND
    1 root       808 S    {squashfs_init} /gm/bin/busybox ash /squashfs_init
    2 root         0 SW   [kthreadd]
    3 root         0 SW   [ksoftirqd/0]
    5 root         0 SW   [kworker/u:0]
    6 root         0 SW<  [khelper]
    7 root         0 SW   [kdevtmpfs]
    8 root         0 DW   [FMEM_IDLE]
    9 root         0 SW   [sync_supers]
   10 root         0 SW   [bdi-default]
   11 root         0 SW<  [kblockd]
   12 root         0 SW   [khubd]
   13 root         0 SW<  [rpciod]
   15 root         0 SW   [khungtaskd]
   16 root         0 DW   [kswapd0]
   17 root         0 SW   [fsnotify_mark]
   18 root         0 SW<  [nfsiod]
   19 root         0 SW<  [ftspi020.0]
   21 root         0 SW   [mtdblock0]
   22 root         0 SW   [mtdblock1]
   23 root         0 SW   [mtdblock2]
   24 root         0 SW   [mtdblock3]
   25 root         0 SW   [mtdblock4]
   26 root         0 SW   [mtdblock5]
   27 root         0 SW   [mtdblock6]
   30 root         0 DW   [i2c_hangs_detec]
   31 root         0 SW   [kworker/u:2]
   32 root         0 SW   [mmcqd/0]
   56 root       816 S    {linuxrc} init
   85 root         0 SWN  [jffs2_gcd_mtd6]
   89 root       824 S    telnetd
  106 root      1376 S    /gm/bin/wifi_rt8188/wpa_supplicant -Dwext -ira0 -c /
  125 root         0 SW<  [log_thread]
  126 root         0 SWN  [threadmon]
  127 root         0 SW<  [log_notify]
  131 root         0 DW<  [gm_cache_extend]
  134 root         0 DW<  [em_callback]
  135 root         0 DW<  [em_putjob]
  136 root         0 SW<  [osg_callback]
  137 root         0 SW   [ivs_callback]
  142 root         0 DW   [saradc thread]
  164 root         0 DW   [isp_ae]
  165 root         0 DW   [isp_awb]
  166 root         0 DW   [isp_af]
  169 root         0 SW   [RTW_CMD_THREAD]
  192 root         0 SW   [vcap_md]
  195 root         0 SW   [isp_mon]
  200 root         0 DW   [mcp100_cb_threa]
  201 root         0 DW   [mcp100_getjob_t]
  204 root         0 DW   [favce_cb_thread]
  205 root         0 DW   [favce_engine0_t]
  214 root         0 DW   [scaler_add_tabl]
  217 root         0 DW<  [scaler_callback]
  218 root         0 DW   [scaler_2ddma_ca]
  225 root         0 DW   [gm_au_stop0]
  226 root         0 DW   [gm_au_stop1]
  227 root         0 SW<  [audio_in]
  228 root         0 SW<  [audio_out]
  235 root         0 DW<  [gm_group]
  236 root         0 DW<  [gm_gs_notify]
  239 root         0 DW   [gm_enc_cap_out_]
  240 root         0 DW   [gm_enc_scl_out_]
  241 root         0 DW   [gm_au_encode_dd]
  242 root         0 DW   [gm_au_playback_]
  243 root         0 DW   [gm_vpslv]
  244 root         0 DW<  [gm_vpd_notify]
  245 root         0 DW<  [datain_callback]
  246 root         0 DW<  [dataout_callbac]
  247 root         0 SW<  [dataout_timeout]
  248 root         0 SW   [usr_decode]
  289 root      311m S    /usr/sbin/Alloca
  290 root       812 S    /bin/sh
  306 root         0 SW   [flush-179:0]
 1782 root         0 DW   [kworker/0:1]
 1799 root       812 S    -sh
 1806 root         0 SW   [kworker/0:0]
 1811 root         0 SW   [kworker/0:3]
 1814 root         0 SW   [kworker/0:2]
 1815 root       808 R    ps
```

So already not bad

- telnetd - for telnet
- /gm/bin/wifi_rt8188/wpa_supplicant -Dwext -ira0 -c / - it is for work with Wifi
- another '[ * ]' - it's modules for linux or "drivers"
- and /usr/sbin/Alloca - looks like main process for camera

Let's see what is really reserver ports

```shell
[root@GM]# netstat -tupln
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:23456           0.0.0.0:*               LISTEN      289/Alloca
tcp        0      0 0.0.0.0:34567           0.0.0.0:*               LISTEN      289/Alloca
tcp        0      0 0.0.0.0:23              0.0.0.0:*               LISTEN      89/telnetd
udp        0      0 0.0.0.0:34568           0.0.0.0:*                           289/Alloca
udp        0      0 0.0.0.0:34569           0.0.0.0:*                           289/Alloca
```

Aga... open ports we already see in nmap - 23, 23456, 34567 and also 34568, 34569 in UDP and that all opened in Alloca

Okay, I know Alloca is main process - we can dump the file and try to look some interesting inside the program, but after check I have only telnet and ftpget, but in start of the way I did know how to use it best and do some
