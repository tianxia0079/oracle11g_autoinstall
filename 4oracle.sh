#/bin/bash
#以oracle用户运行
netca /silent /responseFile /home/oracle/database/response/netca.rsp #静默方式配置监听
ls $ORACLE_HOME/network/admin/    #正常情况下会自动生成listener.ora sqlnet.ora
cd /home/oracle/database/response
cp dbca.rsp db
sed -i '78s/.*/GDBNAME= "orcl"/' dbca.rsp
sed -i '170s/.*/SID = "orcl"/' dbca.rsp
sed -i '211s/.*/SYSPASSWORD = "123456"/' dbca.rsp
sed -i '221s/.*/SYSTEMPASSWORD = "123456"/' dbca.rsp
sed -i '252s/.*/SYSMANPASSWORD = "123456"/' dbca.rsp
sed -i '262s/.*/DBSNMPPASSWORD = "123456"/' dbca.rsp
sed -i '360s/.*/DATAFILEDESTINATION=\/u01\/app\/oracle\/oradata/' dbca.rsp
sed -i '370s/.*/RECOVERYAREADESTINATION=\/u01\/app\/oracle\/fast_recovery_area/' dbca.rsp
sed -i '418s/.*/CHARACTERSET= "AL32UTF8"/' dbca.rsp
sed -i '553s/.*/TOTALMEMORY= "3276"/' dbca.rsp   #值设置为物理内存的60%
dbca -silent -responseFile /home/oracle/database/response/dbca.rsp  #开始静默安装，安装结束后会提示100%，数据库也跟着起来了
ps -ef | grep ora_ | grep -v grep  #检测oracle进程
lsnrctl status