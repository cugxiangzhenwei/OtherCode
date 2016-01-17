insert into ERM_WEBMODULE (WEBMODULEID, VERSION, WEBMODULENAME, CLASSNAME, DATARESOURCE, CONFIGPATH, BEANNAME, FACEPAGE, STATE, CODE, MEMO, CONTEXTURL)
values (1000, 0, '流程管理', null, null, null, null, null, '0', 'cflow', null, 'http://192.168.20.86:8083/cflow');

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1101, 0, 'pkg_MENU', '主菜单', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1102, 0, 'pkg_TASKBOOK', '任务书管理', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1103, 0, 'pkg_PROJECT', '流程项目管理', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1104, 0, 'pkg_BASE', '基础设置管理', '/workflow/edit/', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1105, 0, 'pkg_APPLICATION', '应用程序管理', '/workflow/monitor/', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1106, 0, 'pkg_WEBSERVICE', '接口', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1107, 0, 'pkg_WORKLIST', '协同工作区', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1108, 0, 'pkg_TEMPLATE', '模板管理', '', 1000, null, 'true', null, null, null, 'pkg');
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID, TYPE)
values (1109, 0, 'pkg_MONITOR', '流程监控', '', 1000, null, 'true', null, null, null, 'pkg');


insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1201, 0, 'function_workflow_quality', '流程项目', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1202, 0, 'function_workflow_template', '模板管理', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1203, 0, 'function_workflow_edit', '流程定义', '/workflow/edit/', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1204, 0, 'function_workflow_monitor', '流程监控', '/workflow/monitor/', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1205, 0, 'function_workflow_base', '基础设置', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1206, 0, 'function_workflow_application', '应用程序', '', 1000, null, 'true', null, null, 1101);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1207, 0, 'function_workflow_worklist', '协同工作区', '', 1000, null, 'true', null, null, 1101);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1211, 0, 'function_workflow_worklist_taskbook', '任务书管理', '', 1000, null, 'true', null, null, 1102);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1212, 0, 'function_workflow_project_task_undeal', '任务书管理-未处理', '', 1000, null, 'true', null, null, 1102);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1213, 0, 'function_workflow_project_task_deal', '任务书管理-已处理', '', 1000, null, 'true', null, null, 1102);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1221, 0, 'function_workflow_worklist_project', '流程项目管理', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1222, 0, 'function_workflow_project_manage_data', '项目管理-待提交模型', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1223, 0, 'function_workflow_project_manage_init', '项目管理-待初始化项目', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1224, 0, 'function_workflow_project_manage_audit', '项目管理-待审批项目', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1225, 0, 'function_workflow_project_manage_exec', '项目管理-执行中项目', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1226, 0, 'function_workflow_project_manage_finished', '项目管理-已完成项目', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1227, 0, 'function_workflow_project_manage_plan', '项目管理-待提交方案', '', 1000, null, 'true', null, null, 1103);
insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1228, 0, 'function_workflow_project_manage_resume', '项目管理-待恢复项目', '', 1000, null, 'true', null, null, 1103);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1231, 0, 'function_workflow_application_executing', '执行应用程序', '', 1000, null, 'true', null, null, 1105);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1251, 0, 'function_workflow_worklist_viewglobalxpdl', '查看全局流程图', '', 1000, null, 'true', null, null, 1107);

insert into ERM_RESOURCE_CONFIG (RSID, VERSION, RESOURCEID, RESOURCENAME, ACTIONPATH, WEBMODULEID, MEMO, ISOPEN, STATE, REQUIRESHTTPS, PARENTID)
values (1261, 0, 'function_workflow_template_manage', '模板管理-模板管理员', '', 1000, null, 'true', null, null, 1108);

insert into ERM_FUNCPERMISSION (OID, VERSION, AUTHORITYCODE, AUTHORITYNAME, AUTHORITYTYPE, RSID, AUTHORITYOID, EXPIREDATE)
values (1302, 0, 'ANONYMOUS', '匿名用户', 'ROLE', 1231, 2, null);


commit;