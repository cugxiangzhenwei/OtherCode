--文件模板
insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(1,0,'仿真过程模板','仿真过程模板','','simProTem');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(2,0,'优化过程模板','优化过程模板','','optProTem');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(3,0,'组件','组件','','component');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(4,0,'文档','文档','','doc');

--流程模板
insert into pera_xpdl_type(pk_xpdl_type_id,version,name,description,fk_parent_id,knowledge_flg,type_code) 
values(1,0,'仿真模板','仿真模板','','knowledge','simulation');

insert into pera_xpdl_type(pk_xpdl_type_id,version,name,description,fk_parent_id,knowledge_flg,type_code) 
values(2,0,'设计模板','设计模板','','knowledge','design');