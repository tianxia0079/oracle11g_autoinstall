sqlplus / as sysdba #进入数据库
select status from v$instance;　　#查看数据库运行状态
create user test identified by test; #创建数据库用户，连接时数据库实例名为orcl，用户名test密码test
grant connect to test;
grant resource to test;