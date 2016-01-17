
-- 
-- 说明：
-- 表erm_dataresource中字段CLAZZNAME，如果增加'#'，则表示需要按人员所在部门权限控制
-- 

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1001, 1, '流程定义', '#com.pera.base.workflow.model.xpdl.PeraXpdl', 1000, '', 'clazz', '');

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1002, 2, '流程执行', '#com.pera.base.workflow.model.flow.PeraFlowProcess', 1000, '', 'clazz', '');

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1003, 0, '流程模板', '#com.pera.base.workflow.model.xpdl.PeraXpdlTemplate', 1000, '', 'clazz', '');


insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1001, 2, '所属分公司', 'userMainManageDomain', 1001, 'string', '');

insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1002, 1, '所属分公司', 'userMainManageDomain', 1002, 'string', '');

insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1003, 1, '所属分公司', 'userMainManageDomain', 1003, 'string', '');


insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1001, 0, '列表', 'LIST', 1001, 5, 'after');

insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1002, 0, '列表', 'LIST', 1002, 5, 'after');

insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1003, 0, '列表', 'LIST', 1003, 5, 'after');

