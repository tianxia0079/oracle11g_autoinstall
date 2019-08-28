#!/bin/bash
#以oracle用户运行，su - oracle
cat >> .bash_profile <<EOF
ORACLE_BASE=/u01/app/oracle
ORACLE_HOME=\$ORACLE_BASE/product/11.2.0/db_1
ORACLE_SID=orcl 
export NLS_LANG=AMERICAN_AMERICA.UTF8
PATH=\$PATH:\$ORACLE_HOME/bin
export ORACLE_BASE ORACLE_HOME ORACLE_SID PATH
umask 022
EOF
source .bash_profile
unzip linux.x64_11gR2_database_1of2.zip
unzip linux.x64_11gR2_database_2of2.zip
chown -R oracle:oinstall database
cd database/response
cp db_install.rsp  db_install.rsp.bak
sed -i "s/^oracle.install.option=/oracle.install.option=INSTALL_DB_SWONLY/g" db_install.rsp
sed -i "s/^ORACLE_HOSTNAME=/ORACLE_HOSTNAME= orcl/g" db_install.rsp
sed -i "s/^UNIX_GROUP_NAME=/UNIX_GROUP_NAME=oinstall/g" db_install.rsp
sed -i "s/^INVENTORY_LOCATION=/INVENTORY_LOCATION=\/u01\/app\/oraInventory/g" db_install.rsp
sed -i "s/^SELECTED_LANGUAGES=en/SELECTED_LANGUAGES=en,zh_CN/g" db_install.rsp
sed -i "s/^ORACLE_HOME=/ORACLE_HOME=\/u01\/app\/oracle\/product\/11.2.0\/db_1/g" db_install.rsp
sed -i "s/^ORACLE_BASE=/ORACLE_BASE=\/u01\/app\/oracle/g" db_install.rsp
sed -i "s/^oracle.install.db.InstallEdition=/oracle.install.db.InstallEdition=EE/g" db_install.rsp
sed -i "s/^oracle.install.db.DBA_GROUP=/oracle.install.db.DBA_GROUP=dba/g" db_install.rsp
sed -i "s/^oracle.install.db.OPER_GROUP=/oracle.install.db.OPER_GROUP=dba/g" db_install.rsp
sed -i "s/^DECLINE_SECURITY_UPDATES=/DECLINE_SECURITY_UPDATES=true/g" db_install.rsp
cd ..
./runInstaller -silent -responseFile /home/oracle/database/response/db_install.rsp 
#可能会包INS-13014目标不满足一些可选要求，查看日志，如果是pdksh缺少的话，可以忽略直接进行下一步。没有异常，不报错的话会在三两分钟后出现使用root用户执行orainstRoot.sh和root.sh的提示