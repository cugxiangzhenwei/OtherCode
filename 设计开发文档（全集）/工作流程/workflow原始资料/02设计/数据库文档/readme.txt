
SQL文件说明：

1、应用程序模块
ddh_ddl.sql-创建表语句
ddh_dml.sql-更新表语句（部署新版本时不需要执行）
ddh_init.sql-初始化语句

2、数据授权
step1_acls_dll.sql-创建表语句步骤一
step2_acls_function_dll_for_wf.sql-创建表语句步骤二
erm_acls_oracle_dml.sql-更新表语句（部署新版本时不需要执行）

3、工作流系统
workflow_ddl.sql-创建表语句
update_dml.sql-更新表语句（部署新版本时不需要执行）
workflow_erm_init.sql-初始化权限语句
userMainManageDomain_init.sql-初始化人员所在部门授权语句