#!/bin/bash
#以root用户运行
#内核参数设置kernel.shmall=2097152其中16G物理内存建议设为4194304类推8G应为2097152
#kernel.shmmax=4294967296一般设置为物理内存的一半,8G:4294967296也可以全部用完8*1024*1024*1024
yum install -y  binutils compat-libstdc++-33 elfutils-libelf elfutils-libelf-devel glibc glibc-common glibc-devel gcc gcc-c++ libaio-devel libaio libgcc libstdc++ libstdc++-devel make sysstat unixODBC unixODBC-devel ksh numactl-devel zip unzip
cat >> /etc/sysctl.conf <<EOF
fs.file-max = 6815744
fs.aio-max-nr = 1048576
kernel.shmall = 2097152        
kernel.shmmax = 4294967296    
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
net.ipv4.ip_local_port_range = 9000 65500
net.core.rmem_default = 4194304
net.core.rmem_max = 4194304
net.core.wmem_default = 262144
net.core.wmem_max = 1048576
EOF
sysctl -p #使配置文件生效
cat >> /etc/security/limits.conf <<EOF
oracle           soft    nproc           2047
oracle           hard    nproc           16384
oracle           soft    nofile          1024
oracle           hard    nofile          65536
EOF
cat >> /etc/pam.d/login <<EOF
session    required     /lib/security/pam_limits.so
session    required     pam_limits.so
EOF
cat >> /etc/profile <<EOF
if [ $USER = "oracle" ]; then
   if [ $SHELL = "/bin/ksh" ]; then
      ulimit -p 16384
      ulimit -n 65536
   else
      ulimit -u 16384 -n 65536
   fi
fi
EOF
groupadd oinstall
groupadd dba
useradd -g oinstall -G dba oracle 
mkdir -p /u01/app/oracle/product/11.2.0/db_1
mkdir -p /u01/app/oracle/oradata
mkdir -p /u01/app/oraInventory
mkdir -p /u01/app/oracle/fast_recovery_area
chown -R oracle:oinstall /u01/app/oracle
chown -R oracle:oinstall /u01/app/oraInventory
chmod -R 755 /u01/app/oracle
chmod -R 755 /u01/app/oraInventory
systemctl disable firewalld
systemctl stop  firewalld
setenforce 0
sed -i 's/=enforcing/=disabled/g' /etc/selinux/config
mv linux.x64_11gR2_database_1of2.zip /home/oracle    
mv linux.x64_11gR2_database_2of2.zip /home/oracle
cp thiinstalloracle.sh /home/oracle/
cp fouinstalloracle.sh /home/oracle/