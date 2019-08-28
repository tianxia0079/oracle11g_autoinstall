# oracle11g_autoinstall
oracle11g 静默安装
https://www.cnblogs.com/biaopei/p/10845305.html

CentOS release 6.10 (Final) 亲测可用.
centos7应该也可以用.
 
遇到问题总结：
1.  修改hostname 主要是为了可以ping orcl
保障  vi /etc/hosts ip 对应到 orcl即可
[oracle@vm1 ~]$ cat /etc/hosts
192.168.136.128 vm1 orcl orcl localhost
（1脚本）
2.提示命令找不到  
systemctl 不存在  修改脚本 ，用 service代替
（2脚本）
3.查看执行结果，如果有明显异常，处理
实施中出现的一个异常：
/home/oracle/database/response/ 里的某个文件，由于重复执行3脚本，导致这个文件配置项重复配置，文件内容就错了，需要把这文件下内容 rm掉 .重新执行3
3执行完有日志，看日志没有明显error，就执行：
#root执行
sh /u01/app/oraInventory/orainstRoot.sh
sh /u01/app/oracle/product/11.2.0/db_1/root.sh
#两个分别执行即可，前面的执行完结果就是那样提示权限，不是执行异常了！

(3脚本)
 
oracle常用脚本
https://blog.csdn.net/yubinhehaha/article/details/88304759




