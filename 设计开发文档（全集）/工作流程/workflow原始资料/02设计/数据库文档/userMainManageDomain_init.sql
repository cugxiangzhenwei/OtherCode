
-- 
-- ˵����
-- ��erm_dataresource���ֶ�CLAZZNAME���������'#'�����ʾ��Ҫ����Ա���ڲ���Ȩ�޿���
-- 

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1001, 1, '���̶���', '#com.pera.base.workflow.model.xpdl.PeraXpdl', 1000, '', 'clazz', '');

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1002, 2, '����ִ��', '#com.pera.base.workflow.model.flow.PeraFlowProcess', 1000, '', 'clazz', '');

insert into erm_dataresource (OID, VERSION, NAME, CLAZZNAME, WEBMODULEID, MEMO, DATARESOURCETYPE, ISAVAILABLE)
values (1003, 0, '����ģ��', '#com.pera.base.workflow.model.xpdl.PeraXpdlTemplate', 1000, '', 'clazz', '');


insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1001, 2, '�����ֹ�˾', 'userMainManageDomain', 1001, 'string', '');

insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1002, 1, '�����ֹ�˾', 'userMainManageDomain', 1002, 'string', '');

insert into erm_datadimension (OID, VERSION, NAME, ATTRIBUTE, DATARESOURCEOID, ATTRIBUTETYPE, DBATTRIBUTE)
values (1003, 1, '�����ֹ�˾', 'userMainManageDomain', 1003, 'string', '');


insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1001, 0, '�б�', 'LIST', 1001, 5, 'after');

insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1002, 0, '�б�', 'LIST', 1002, 5, 'after');

insert into erm_dataoperation (OID, VERSION, NAME, CODE, DATARESOURCEOID, MASK, OCCASION)
values (1003, 0, '�б�', 'LIST', 1003, 5, 'after');

