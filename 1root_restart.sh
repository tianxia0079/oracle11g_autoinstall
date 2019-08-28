#!/bin/bash
#以root用户运行 set ff=UNIX
#注意修改第三行的ip为自己的ip地址
echo "192.168.11.128 orcl orcl"  >> /etc/hosts
cat >> /etc/sysconfig/network <<EOF
network=yes
hostname=orcl
EOF