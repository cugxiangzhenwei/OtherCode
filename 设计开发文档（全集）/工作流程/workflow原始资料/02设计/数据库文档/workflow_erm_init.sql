insert into ERM_WEBMODULE (WEBMODULEID, VERSION, WEBMODULENAME, CLASSNAME, DATARESOURCE, CONFIGPATH, BEANNAME, FACEPAGE, STATE, CODE, MEMO, CONTEXTURL)
values (1000, 0, '���̹���', null, null, null, null, null, '0', 'cflow', null, 'http://192.168.20.86:8083/cflow');

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1101, 0, 'pkg_MENU', '���˵�', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1102, 0, 'pkg_TASKBOOK', '���������', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1103, 0, 'pkg_PROJECT', '������Ŀ����', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1104, 0, 'pkg_BASE', '�������ù���', '/workflow/edit/', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1105, 0, 'pkg_APPLICATION', 'Ӧ�ó������', '/workflow/monitor/', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1106, 0, 'pkg_WEBSERVICE', '�ӿ�', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1107, 0, 'pkg_WORKLIST', 'Эͬ������', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1108, 0, 'pkg_TEMPLATE', 'ģ�����', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1109, 0, 'pkg_MONITOR', '���̼��', '', 1000, null, 'true', null, null, null, 'pkg');


insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1201, 0, 'function_workflow_quality', '������Ŀ', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1202, 0, 'function_workflow_template', 'ģ�����', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1203, 0, 'function_workflow_edit', '���̶���', '/workflow/edit/', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1204, 0, 'function_workflow_monitor', '���̼��', '/workflow/monitor/', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1205, 0, 'function_workflow_base', '��������', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1206, 0, 'function_workflow_application', 'Ӧ�ó���', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1207, 0, 'function_workflow_worklist', 'Эͬ������', '', 1000, null, 'true', null, null, 1101);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1211, 0, 'function_workflow_worklist_taskbook', '���������', '', 1000, null, 'true', null, null, 1102);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1212, 0, 'function_workflow_project_task_undeal', '���������-δ����', '', 1000, null, 'true', null, null, 1102);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1213, 0, 'function_workflow_project_task_deal', '���������-�Ѵ���', '', 1000, null, 'true', null, null, 1102);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1221, 0, 'function_workflow_worklist_project', '������Ŀ����', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1222, 0, 'function_workflow_project_manage_data', '��Ŀ����-���ύģ��', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1223, 0, 'function_workflow_project_manage_init', '��Ŀ����-����ʼ����Ŀ', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1224, 0, 'function_workflow_project_manage_audit', '��Ŀ����-��������Ŀ', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1225, 0, 'function_workflow_project_manage_exec', '��Ŀ����-ִ������Ŀ', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1226, 0, 'function_workflow_project_manage_finished', '��Ŀ����-�������Ŀ', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1227, 0, 'function_workflow_project_manage_plan', '��Ŀ����-���ύ����', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1228, 0, 'function_workflow_project_manage_resume', '��Ŀ����-���ָ���Ŀ', '', 1000, null, 'true', null, null, 1103);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1231, 0, 'function_workflow_application_executing', 'ִ��Ӧ�ó���', '', 1000, null, 'true', null, null, 1105);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1251, 0, 'function_workflow_worklist_viewglobalxpdl', '�鿴ȫ������ͼ', '', 1000, null, 'true', null, null, 1107);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1261, 0, 'function_workflow_template_manage', 'ģ�����-ģ�����Ա', '', 1000, null, 'true', null, null, 1108);

insert into ERM_FUNCPERMISSION (OID, VERSION, AUTHORITYCODE, AUTHORITYNAME, AUTHORITYTYPE, RSID, AUTHORITYOID, EXPIREDATE)
values (1302, 0, 'ANONYMOUS', '�����û�', 'ROLE', 1231, 2, null);


commit;