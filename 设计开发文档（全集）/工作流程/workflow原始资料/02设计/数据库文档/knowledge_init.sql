--�ļ�ģ��
insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(1,0,'�������ģ��','�������ģ��','','simProTem');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(2,0,'�Ż�����ģ��','�Ż�����ģ��','','optProTem');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(3,0,'���','���','','component');

insert into pera_xpdl_simulation_type(pk_xpdl_sim_type_id,version,name,description,fk_parent_id,category) 
values(4,0,'�ĵ�','�ĵ�','','doc');

--����ģ��
insert into pera_xpdl_type(pk_xpdl_type_id,version,name,description,fk_parent_id,knowledge_flg,type_code) 
values(1,0,'����ģ��','����ģ��','','knowledge','simulation');

insert into pera_xpdl_type(pk_xpdl_type_id,version,name,description,fk_parent_id,knowledge_flg,type_code) 
values(2,0,'���ģ��','���ģ��','','knowledge','design');