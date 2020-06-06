#!/bin/sh
echo "Starting FTP server"
/tmp/busybox tcpsvd -vE 0.0.0.0 21 /tmp/busybox ftpd -w /
