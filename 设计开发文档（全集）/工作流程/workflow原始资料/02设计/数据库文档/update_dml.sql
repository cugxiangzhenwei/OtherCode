
-- 2009-3-28 --------------------------------------------------
create table PERA_FLOW_TASK_AUDIT
(
  PK_FLOW_TASK_AUDIT_ID NUMBER(19) not null,
  USER_NAME             VARCHAR2(255),
  AUDIT_TIME                  TIMESTAMP(6),
  REMARK                VARCHAR2(1024),
  FK_FLOW_TASK_ID       NUMBER(19),
  AGREE                 CHAR(1) not null,
  FINISH                CHAR(1)
)
;
alter table PERA_FLOW_TASK_AUDIT
  add primary key (PK_FLOW_TASK_AUDIT_ID);
alter table PERA_FLOW_TASK_AUDIT
  add constraint FKA320F27810E6DD88 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);


-- 2009-4-1 ----------------------------------------------------
alter table PERA_FLOW_TASK add (DESCRIPTION varchar2 (1024)); 


-- 2009-4-1 ----------------------------------------------------
alter table PERA_FLOW_TRANSACTION add (CREATE_FROM number(10));  


-- 2009-4-3 --------------------------------------------------
alter table PERA_FLOW_TASK add (ABANDON_REASON varchar2 (1024));  


-- 2009-4-21 --------------------------------------------------
alter table PERA_FLOW_TASK add (BORN number(10));


--2009-4-25 --------------------------------------------------

create table PERA_FLOW_R_DATA_V_ITEM
(
  PK_FLOW_R_D_V_I_ID NUMBER(19) not null,
  VERSION            NUMBER(10) not null,
  FK_FLOW_R_D_V_ID   NUMBER(19),
  VALUE              VARCHAR2(255 CHAR),
  SHOW_INDEX         NUMBER(10)
)
;
alter table PERA_FLOW_R_DATA_V_ITEM
  add primary key (PK_FLOW_R_D_V_I_ID);
alter table PERA_FLOW_R_DATA_V_ITEM
  add constraint FK5A88130E31C6216F foreign key (FK_FLOW_R_D_V_ID)
  references PERA_FLOW_R_DATA_VALUE (PK_FLOW_R_DATA_VALUE_ID);

alter table PERA_FLOW_R_DATA_V_FILE add (FK_FLOW_R_D_V_I_ID number(19));

alter table PERA_FLOW_R_DATA_V_FILE
  add constraint FK5A868D7749F3B838 foreign key (FK_FLOW_R_D_V_I_ID)
  references PERA_FLOW_R_DATA_V_ITEM (PK_FLOW_R_D_V_I_ID);

-- 2009-5-8 ---------------------------------------------------

alter table PERA_XPDL modify(NAME varchar2 (1024));

alter table PERA_XPDL_VERSION modify(NAME varchar2 (1024));

-- 2009-5-21 --------------------------------------------------

alter table PERA_FLOW_TASK add (NODE_NAME varchar2 (255)); 

alter table PERA_FLOW_TASK add (PLAN_START_TIME varchar2 (255)); 

alter table PERA_FLOW_TASK add (PLAN_END_TIME varchar2 (255)); 

alter table PERA_FLOW_PROCESS add (PROCESS_NAME varchar2 (255)); 

-- 2009-5-31 --------------------------------------------------

alter table PERA_XPDL add (CREATE_USER varchar2 (255)); 

-- 2009-6-26 --------------------------------------------------

alter table PERA_FLOW_TASK add (AUDIT_VERSION number(10));

alter table PERA_FLOW_TASK_AUDIT add (AUDIT_VERSION number(10));

-- 2009-7-1 ---------------------------------------------------

create table PERA_XPDL_T_V
(
  PK_VERSION_ID      NUMBER(19) not null,
  VERSION            NUMBER(10) not null,
  NAME               VARCHAR2(1024 CHAR),
  MAX_VERSION_NUMBER NUMBER(10),
  DESCRIPTION        VARCHAR2(1024 CHAR)
)
;
alter table PERA_XPDL_T_V
  add primary key (PK_VERSION_ID);

alter table PERA_XPDL_TEMPLATE add (FK_VERSION_ID number(19));

alter table PERA_XPDL_TEMPLATE add (VERSION_NUMBER number(10));

alter table PERA_XPDL_TEMPLATE
  add constraint FK6A7D463E1D514D9C foreign key (FK_VERSION_ID)
  references PERA_XPDL_T_V (PK_VERSION_ID);

-- 2009-7-6 ---------------------------------------------------

alter table PERA_FLOW_TASK add (SCHEDULE number(10)); 

-- 2009-7-20 ---------------------------------------------------

alter table PERA_XPDL_TEMPLATE add (CREATE_USER varchar2 (255)); 

alter table PERA_XPDL_TEMPLATE add (USER_MAIN_MANAGE_DOMAIN varchar2 (255));

alter table PERA_XPDL add (USER_MAIN_MANAGE_DOMAIN varchar2 (255));

-- 2009-7-24 ---------------------------------------------------

create table PERA_TASK_REJECT_APPLICATION
(
  PK_APPLICATION_ID       NUMBER(19) not null,
  APPLICATION_USER        VARCHAR2(255 CHAR),
  APPLICATION_DESCRIPTION VARCHAR2(1024 CHAR),
  EXECUTE_USER            VARCHAR2(255 CHAR),
  FLOW_PROCESS_ID         NUMBER(19),
  STATE                   NUMBER(10),
  FLOW_TASK_ID            NUMBER(19),
  TASK_NAME               VARCHAR2(255 CHAR),
  FLOW_PROCESS_NAME       VARCHAR2(255 CHAR),
  APP_TIME                TIMESTAMP(6)
)
;
alter table PERA_TASK_REJECT_APPLICATION
  add primary key (PK_APPLICATION_ID);

alter table PERA_FLOW_TASK add (BOM_ID varchar2 (255));  

alter table PERA_FLOW_TASK add (BOM_NAME varchar2 (255));  

-- 2009-7-31 --------------------------------------------------

alter table PERA_FLOW_R_DATA_V_FILE add (PACKAGE_ID varchar2(50));

alter table PERA_FLOW_R_DATA_V_FILE add (PACKAGE_NAME varchar2(255));

alter table PERA_FLOW_R_DATA_V_FILE add (CLIENT_VERSION varchar2(255));

alter table PERA_FLOW_R_DATA_V_FILE add (STATUS varchar2(10));

-- 2009-8-18 --------------------------------------------------

alter table PERA_FLOW_PROCESS add (USER_MAIN_MANAGE_DOMAIN varchar2(255));

alter table PERA_FLOW_TASK add (USER_MAIN_MANAGE_DOMAIN varchar2(255));

-- 2009-9-9 --------------------------------------------------

alter table PERA_FLOW_PROCESS add (PROJECT_NAME varchar2 (512)); 

alter table PERA_FLOW_PROCESS add (PROJECT_REFERENCE varchar2 (50)); 

alter table PERA_FLOW_TASK add (PRODUCT_ID varchar2 (255));  

alter table PERA_FLOW_TASK add (PRODUCT_PATH varchar2 (2048));  

alter table PERA_FLOW_TASK add (PRODUCT_NAME varchar2 (512));  

-- 2009-9-16 --------------------------------------------------

alter table PERA_FLOW_TASK add (BOM_NAME_APP varchar2 (255));  

alter table PERA_FLOW_TASK add (BOM_ID_APP varchar2 (50));  

alter table PERA_FLOW_TASK add (BUS_NAME_APP varchar2 (255));  

alter table PERA_FLOW_TASK add (BUS_ID_APP varchar2 (50));  

alter table PERA_FLOW_TASK add (PRODUCT_NAME_APP varchar2 (255));  

alter table PERA_FLOW_TASK add (PRODUCT_ID_APP varchar2 (50));  

-- 2009-9-21 --------------------------------------------------

alter table PERA_FLOW_TASK add (QUERY_BOM_ID varchar2 (255));  

-- 2009-10-14 --------------------------------------------------

alter table PERA_FLOW_TASK modify(DATA_MAN_BOMID varchar2 (1024));

alter table PERA_FLOW_TASK modify(DATA_MAN_PACKAGE varchar2 (1024));

-- 2009-10-28 --------------------------------------------------

alter table PERA_FLOW_TASK add(LCA_URL varchar2 (512));

alter table PERA_FLOW_TASK add(LCA_LOCATION varchar2 (512));

-- 2009-11-2 --------------------------------------------------

alter table PERA_FLOW_TASK add(ACTI_PRIORITY number(10));

alter table PERA_FLOW_TASK add(DIFFICULTY number(10));

alter table PERA_FLOW_TASK add(WORKBENCH_WORKPATH varchar2 (255));

alter table PERA_FLOW_TASK add(WORKBENCH_ENVIROMENT varchar2 (255));

-- 2009-11-6 --------------------------------------------------

alter table PERA_FLOW_PROCESS add(ROOT_PROCESS_ID number(19));

-- 2009-11-18 --------------------------------------------------

alter table PERA_XPDL add (PROJECT_PROCESS_NAME varchar2(255));

alter table PERA_XPDL add (PROJECT_TASK_FILE_NAME varchar2(255));

alter table PERA_XPDL add (PROJECT_TASK_FILE_PATH varchar2(255));

-- 2009-12-1 --------------------------------------------------

alter table PERA_XPDL add (FRIEND_REFERENCE varchar2(50));

alter table PERA_XPDL add (FRIEND_NAME varchar2(512));

-- 2010-1-13 --------------------------------------------------

create table PERA_HISTORY_BLOCK
(
  PK_FLOW_BLOCK_ID   NUMBER(19) not null,
  BLOCK_ID           VARCHAR2(255 CHAR),
  FK_PARENT_BLOCK_ID NUMBER(19),
  FK_FLOW_PROCESS_ID NUMBER(19),
  STATE              NUMBER(10)
)
;
alter table PERA_HISTORY_BLOCK
  add primary key (PK_FLOW_BLOCK_ID);
alter table PERA_HISTORY_BLOCK
  add constraint FKD408D6C75CAFA7CF foreign key (FK_FLOW_PROCESS_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_HISTORY_BLOCK
  add constraint FKD408D6C7A3425ED3 foreign key (FK_PARENT_BLOCK_ID)
  references PERA_HISTORY_BLOCK (PK_FLOW_BLOCK_ID);


create table PERA_HISTORY_PROCESS
(
  PK_FLOW_PROCESS_ID      NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  USER_MAIN_MANAGE_DOMAIN VARCHAR2(255 CHAR),
  PACKAGE_ID              VARCHAR2(255 CHAR),
  PROCESS_ID              VARCHAR2(255 CHAR),
  PROCESS_NAME            VARCHAR2(255 CHAR),
  VERSION_NUMBER          VARCHAR2(255 CHAR),
  END_TIME                TIMESTAMP(6),
  START_TIME              TIMESTAMP(6),
  STATE                   NUMBER(10),
  FK_PARENT_ID            NUMBER(19),
  FK_FLOW_BLOCK_ID        NUMBER(19),
  STARTER_OID             VARCHAR2(255 CHAR),
  PROJECT_REFERENCE       VARCHAR2(50 CHAR),
  PROJECT_NAME            VARCHAR2(512 CHAR),
  ROOT_PROCESS_ID         NUMBER(19)
)
;
alter table PERA_HISTORY_PROCESS
  add primary key (PK_FLOW_PROCESS_ID);
alter table PERA_HISTORY_PROCESS
  add constraint FKE40286299E0B4083 foreign key (FK_PARENT_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_HISTORY_PROCESS
  add constraint FKE4028629B993244F foreign key (FK_FLOW_BLOCK_ID)
  references PERA_HISTORY_BLOCK (PK_FLOW_BLOCK_ID);

create table PERA_HISTORY_TASK
(
  PK_FLOW_TASK_ID         NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  USER_MAIN_MANAGE_DOMAIN VARCHAR2(255 CHAR),
  NODE_ID                 VARCHAR2(255 CHAR),
  NODE_NAME               VARCHAR2(255 CHAR),
  START_TIME              TIMESTAMP(6),
  END_TIME                TIMESTAMP(6),
  USER_OID                VARCHAR2(255 CHAR),
  FK_FLOW_PROCESS_ID      NUMBER(19),
  FK_FLOW_BLOCK_ID        NUMBER(19),
  STATE                   NUMBER(10),
  DATA_MAN_BOMID          VARCHAR2(255 CHAR),
  DATA_MAN_PACKAGE        VARCHAR2(255 CHAR),
  EXPERIMENT_TASK_ID      VARCHAR2(255 CHAR),
  BORN                    NUMBER(10),
  DESCRIPTION             VARCHAR2(1024 CHAR),
  ABANDON_REASON          VARCHAR2(1024 CHAR),
  PLAN_END_TIME           VARCHAR2(255 CHAR),
  PLAN_START_TIME         VARCHAR2(255 CHAR),
  AUDIT_VERSION           NUMBER(10),
  BOM_ID                  VARCHAR2(255 CHAR),
  BOM_NAME                VARCHAR2(255 CHAR),
  SCHEDULE                NUMBER(10),
  PRODUCT_ID              VARCHAR2(255 CHAR),
  PRODUCT_NAME            VARCHAR2(512 CHAR),
  PRODUCT_PATH            VARCHAR2(2048 CHAR)
)
;
alter table PERA_HISTORY_TASK
  add primary key (PK_FLOW_TASK_ID);
alter table PERA_HISTORY_TASK
  add constraint FKBC8C6FEB5CAFA7CF foreign key (FK_FLOW_PROCESS_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_HISTORY_TASK
  add constraint FKBC8C6FEBB993244F foreign key (FK_FLOW_BLOCK_ID)
  references PERA_HISTORY_BLOCK (PK_FLOW_BLOCK_ID);


create table PERA_HISTORY_R_DATA_VALUE
(
  PK_FLOW_R_DATA_VALUE_ID NUMBER(19) not null,
  DATA_ID                 VARCHAR2(255 CHAR),
  FK_FLOW_TASK_ID         NUMBER(19),
  VALUE                   VARCHAR2(255 CHAR),
  ADD_TYPE                NUMBER(10)
)
;
alter table PERA_HISTORY_R_DATA_VALUE
  add primary key (PK_FLOW_R_DATA_VALUE_ID);
alter table PERA_HISTORY_R_DATA_VALUE
  add constraint FKAB3DC6EFA3692345 foreign key (FK_FLOW_TASK_ID)
  references PERA_HISTORY_TASK (PK_FLOW_TASK_ID);

create table PERA_HISTORY_R_DATA_V_ITEM
(
  PK_FLOW_R_D_V_I_ID NUMBER(19) not null,
  VERSION            NUMBER(10) not null,
  FK_FLOW_R_D_V_ID   NUMBER(19),
  SHOW_INDEX         NUMBER(10),
  VALUE              VARCHAR2(255 CHAR)
)
;
alter table PERA_HISTORY_R_DATA_V_ITEM
  add primary key (PK_FLOW_R_D_V_I_ID);
alter table PERA_HISTORY_R_DATA_V_ITEM
  add constraint FKBE20777EC6445B6B foreign key (FK_FLOW_R_D_V_ID)
  references PERA_HISTORY_R_DATA_VALUE (PK_FLOW_R_DATA_VALUE_ID);


create table PERA_HISTORY_R_DATA_V_FILE
(
  PK_FLOW_R_D_V_FILE_ID NUMBER(19) not null,
  VERSION               NUMBER(10) not null,
  FILE_NAME             VARCHAR2(255 CHAR),
  FK_FLOW_R_D_V_ID      NUMBER(19),
  FK_FLOW_R_D_V_I_ID    NUMBER(19),
  STORE_PATH            VARCHAR2(255 CHAR),
  SVN_VERSION           VARCHAR2(255 CHAR),
  PACKAGE_ID            VARCHAR2(50 CHAR),
  PACKAGE_NAME          VARCHAR2(255 CHAR),
  CLIENT_VERSION        VARCHAR2(255 CHAR),
  STATUS                VARCHAR2(10 CHAR)
)
;
alter table PERA_HISTORY_R_DATA_V_FILE
  add primary key (PK_FLOW_R_D_V_FILE_ID);
alter table PERA_HISTORY_R_DATA_V_FILE
  add unique (FK_FLOW_R_D_V_ID);
alter table PERA_HISTORY_R_DATA_V_FILE
  add unique (FK_FLOW_R_D_V_I_ID);
alter table PERA_HISTORY_R_DATA_V_FILE
  add constraint FKBE1EF1E7A08C9434 foreign key (FK_FLOW_R_D_V_I_ID)
  references PERA_HISTORY_R_DATA_V_ITEM (PK_FLOW_R_D_V_I_ID);
alter table PERA_HISTORY_R_DATA_V_FILE
  add constraint FKBE1EF1E7C6445B6B foreign key (FK_FLOW_R_D_V_ID)
  references PERA_HISTORY_R_DATA_VALUE (PK_FLOW_R_DATA_VALUE_ID);


create table PERA_HISTORY_R_DATA_V_F_DATA
(
  PK_FLOW_R_D_V_F_D_ID NUMBER(19) not null,
  VERSION              NUMBER(10) not null,
  FILE_DATA            BLOB,
  FK_FLOW_R_D_V_F_ID   NUMBER(19)
)
;
alter table PERA_HISTORY_R_DATA_V_F_DATA
  add primary key (PK_FLOW_R_D_V_F_D_ID);
alter table PERA_HISTORY_R_DATA_V_F_DATA
  add unique (FK_FLOW_R_D_V_F_ID);
alter table PERA_HISTORY_R_DATA_V_F_DATA
  add constraint FKB35C71AEA089B180 foreign key (FK_FLOW_R_D_V_F_ID)
  references PERA_HISTORY_R_DATA_V_FILE (PK_FLOW_R_D_V_FILE_ID);


create table PERA_HISTORY_TASK_AUDIT
(
  PK_FLOW_TASK_AUDIT_ID NUMBER(19) not null,
  USER_NAME             VARCHAR2(255 CHAR),
  AUDIT_TIME            TIMESTAMP(6),
  REMARK                VARCHAR2(1024 CHAR),
  FK_FLOW_TASK_ID       NUMBER(19),
  AGREE                 CHAR(1 CHAR) not null,
  FINISH                CHAR(1 CHAR) not null,
  AUDIT_VERSION         NUMBER(10)
)
;
alter table PERA_HISTORY_TASK_AUDIT
  add primary key (PK_FLOW_TASK_AUDIT_ID);
alter table PERA_HISTORY_TASK_AUDIT
  add constraint FK2C6D9A67A3692345 foreign key (FK_FLOW_TASK_ID)
  references PERA_HISTORY_TASK (PK_FLOW_TASK_ID);


create table PERA_HISTORY_TASK_REFUSE
(
  PK_FLOW_TASK_REFUSE_ID NUMBER(19) not null,
  FK_FLOW_TASK_ID        NUMBER(19),
  REMARK                 VARCHAR2(1024 CHAR),
  REFUSE_TIME            TIMESTAMP(6),
  USER_OID               VARCHAR2(255 CHAR)
)
;
alter table PERA_HISTORY_TASK_REFUSE
  add primary key (PK_FLOW_TASK_REFUSE_ID);
alter table PERA_HISTORY_TASK_REFUSE
  add constraint FK7D67B2E8A3692345 foreign key (FK_FLOW_TASK_ID)
  references PERA_HISTORY_TASK (PK_FLOW_TASK_ID);


create table PERA_HISTORY_TRANSITION
(
  PK_FLOW_TRANSITION_ID  NUMBER(19) not null,
  VERSION                NUMBER(10) not null,
  EDGE_ID                VARCHAR2(255 CHAR),
  WALKED                 CHAR(1 CHAR) not null,
  FK_FLOW_PROCESS_ID     NUMBER(19),
  FK_FLOW_TRANSACTION_ID NUMBER(19)
)
;
alter table PERA_HISTORY_TRANSITION
  add primary key (PK_FLOW_TRANSITION_ID);
alter table PERA_HISTORY_TRANSITION
  add constraint FK41CCB73B49D6F580 foreign key (FK_FLOW_TRANSACTION_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_HISTORY_TRANSITION
  add constraint FK41CCB73B5CAFA7CF foreign key (FK_FLOW_PROCESS_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);

-- 2010-1-28 --------------------------------------------------

create table PERA_EXTERNAL_LINK_TYPE
(
  PK_EXTERNAL_LINK_TYPE_ID NUMBER(19) not null,
  VERSION                  NUMBER(10) not null,
  NAME                     VARCHAR2(255 CHAR),
  DESCRIPTION              VARCHAR2(1024 CHAR),
  FK_PARENT_ID             NUMBER(19)
)
;
alter table PERA_EXTERNAL_LINK_TYPE
  add primary key (PK_EXTERNAL_LINK_TYPE_ID);
alter table PERA_EXTERNAL_LINK_TYPE
  add constraint FKA9D45A263C8E5B3 foreign key (FK_PARENT_ID)
  references PERA_EXTERNAL_LINK_TYPE (PK_EXTERNAL_LINK_TYPE_ID);

create table PERA_EXTERNAL_LINK
(
  PK_EXTERNAL_LINK_ID      NUMBER(19) not null,
  VERSION                  NUMBER(10) not null,
  NAME                     VARCHAR2(255 CHAR),
  DESCRIPTION              VARCHAR2(1024 CHAR),
  FK_EXTERNAL_LINK_TYPE_ID NUMBER(19),
  LINK_VALUE               VARCHAR2(255 CHAR)
)
;
alter table PERA_EXTERNAL_LINK
  add primary key (PK_EXTERNAL_LINK_ID);
alter table PERA_EXTERNAL_LINK
  add constraint FKC95F11D381F940D2 foreign key (FK_EXTERNAL_LINK_TYPE_ID)
  references PERA_EXTERNAL_LINK_TYPE (PK_EXTERNAL_LINK_TYPE_ID);

-- 2010-2-3 --------------------------------------------------

create table PERA_HOLIDAY_YEAR
(
  PK_HOLIDAY_YEAR_ID NUMBER(19) not null,
  YEAR               NUMBER(10),
  CREATED_TIME       TIMESTAMP(6)
)
;
alter table PERA_HOLIDAY_YEAR
  add primary key (PK_HOLIDAY_YEAR_ID);

create table PERA_HOLIDAY_DATA
(
  PK_HOLIDAY_DATA_ID NUMBER(19) not null,
  YEAR               NUMBER(10),
  MONTH              NUMBER(10),
  DAY                NUMBER(10),
  TIME               TIMESTAMP(6),
  CREATED_TIME       TIMESTAMP(6),
  FK_HOLIDAY_YEAR_ID NUMBER(19)
)
;
alter table PERA_HOLIDAY_DATA
  add primary key (PK_HOLIDAY_DATA_ID);
alter table PERA_HOLIDAY_DATA
  add constraint FK32F7A0CCB7F4D4F2 foreign key (FK_HOLIDAY_YEAR_ID)
  references PERA_HOLIDAY_YEAR (PK_HOLIDAY_YEAR_ID);

-- 2010-2-9 --------------------------------------------------

alter table PERA_HOLIDAY_YEAR add (NAME varchar2(255));

alter table PERA_HOLIDAY_YEAR add (DESCRIPTION varchar2(1024));

alter table PERA_HOLIDAY_YEAR add (FROM_DATE timestamp(6));

alter table PERA_HOLIDAY_YEAR add (TO_DATE timestamp(6));

-- 2010-3-1 --------------------------------------------------

alter table PERA_FLOW_TASK add(SVN_PATH_APP varchar2(255));

create table PERA_FLOW_TASK_PARTNER
(
  PK_FLOW_TASK_PARTNER_ID NUMBER(19) not null,
  PARTNER_OID             VARCHAR2(255 CHAR),
  TYPE                    NUMBER(10),
  FK_FLOW_TASK_ID         NUMBER(19),
  PARTNER_DISPLAY         VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_TASK_PARTNER
  add primary key (PK_FLOW_TASK_PARTNER_ID);
alter table PERA_FLOW_TASK_PARTNER
  add constraint FK510616C4DFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

-- 2010-3-2 --------------------------------------------------

create table PERA_HOLIDAY_REGULAR
(
  PK_HOLIDAY_REGULAR_ID NUMBER(19) not null,
  MONTH_INDEX           NUMBER(10),
  FROM_DATE             NUMBER(10),
  TO_DATE               NUMBER(10),
  NAME                  VARCHAR2(255 CHAR),
  AUTO                  CHAR(1 CHAR) not null,
  DESCRIPTION           VARCHAR2(1024 CHAR),
  CREATED_TIME          TIMESTAMP(6)
)
;
alter table PERA_HOLIDAY_REGULAR
  add primary key (PK_HOLIDAY_REGULAR_ID);

-- 2010-3-25 --------------------------------------------------

alter table PERA_FLOW_PROCESS add (FRIEND_NAME varchar2 (512)); 

alter table PERA_FLOW_PROCESS add (FRIEND_REFERENCE varchar2 (50)); 

-- 2010-4-12 ---------------------------------------------------

alter table PERA_XPDL_TEMPLATE add (CREATED_TIME timestamp(6)); 

-- 2010-4-23 ---------------------------------------------------

alter table PERA_XPDL_TEMPLATE add (PUBLISH_TIME timestamp(6)); 

-- 2010-5-26 ---------------------------------------------------

alter table PERA_XPDL_TYPE add (KNOWLEDGE_FLG varchar2 (255)); 

alter table PERA_XPDL_TYPE add (TYPE_CODE varchar2 (255)); 

create table PERA_SIMULATION_FILE
(
  PK_SIM_FILE_ID       NUMBER(19) not null,
  FILE_PATH            VARCHAR2(2048 CHAR),
  ORIGINAL_FILE_NAME   VARCHAR2(2048 CHAR),
  RELA_TABLE_TAG       VARCHAR2(2048 CHAR),
  FILE_SIZE            NUMBER(19),
  RELA_TABLE_ID        NUMBER(19),
  CREATE_USER          VARCHAR2(255 CHAR),
  CREATE_USER_REALNAME VARCHAR2(255 CHAR),
  CREATED_TIME         TIMESTAMP(6),
  UPDATE_TIME          TIMESTAMP(6),
  UPDATE_USER          VARCHAR2(255 CHAR),
  UPDATE_USER_REALNAME VARCHAR2(255 CHAR)
)
;
alter table PERA_SIMULATION_FILE
  add primary key (PK_SIM_FILE_ID);

create table PERA_XPDL_SIMULATION_TYPE
(
  PK_XPDL_SIM_TYPE_ID NUMBER(19) not null,
  VERSION             NUMBER(10) not null,
  NAME                VARCHAR2(255 CHAR),
  DESCRIPTION         VARCHAR2(1024 CHAR),
  FK_PARENT_ID        NUMBER(19),
  CATEGORY            VARCHAR2(512 CHAR)
)
;
alter table PERA_XPDL_SIMULATION_TYPE
  add primary key (PK_XPDL_SIM_TYPE_ID);
alter table PERA_XPDL_SIMULATION_TYPE
  add constraint FKCAD20C2E3ADE439F foreign key (FK_PARENT_ID)
  references PERA_XPDL_SIMULATION_TYPE (PK_XPDL_SIM_TYPE_ID);

create table PERA_XPDL_SIMULATION_TEMPLATE
(
  PK_XPDL_SIM_TEMPLATE_ID NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  NAME                    VARCHAR2(255 CHAR),
  DESCRIPTION             VARCHAR2(1024 CHAR),
  STATE                   NUMBER(10),
  VERSION_NUMBER          NUMBER(10),
  CREATE_USER             VARCHAR2(255 CHAR),
  CREATED_TIME            TIMESTAMP(6),
  PUBLISH_TIME            TIMESTAMP(6),
  USER_MAIN_MANAGE_DOMAIN VARCHAR2(255 CHAR),
  FILE_PATH               VARCHAR2(2048 CHAR),
  TEMPLATE_NUMBER         VARCHAR2(255 CHAR),
  FK_XPDL_TYPE_ID         NUMBER(19),
  CREATE_USER_REALNAME    VARCHAR2(255 CHAR),
  UPDATE_TIME             TIMESTAMP(6),
  UPDATE_USER             VARCHAR2(255 CHAR),
  UPDATE_USER_REALNAME    VARCHAR2(255 CHAR)
)
;
alter table PERA_XPDL_SIMULATION_TEMPLATE
  add primary key (PK_XPDL_SIM_TEMPLATE_ID);
alter table PERA_XPDL_SIMULATION_TEMPLATE
  add constraint FK9717A76E96304784 foreign key (FK_XPDL_TYPE_ID)
  references PERA_XPDL_SIMULATION_TYPE (PK_XPDL_SIM_TYPE_ID);

-- 2010-6-1 ---------------------------------------------------

alter table PERA_FLOW_TRANSITION add (FK_FLOW_PROCESS_ID NUMBER(19)); 

alter table PERA_FLOW_TRANSITION
  add constraint FKC72545AB290C62D3 foreign key (FK_FLOW_PROCESS_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);

alter table PERA_FLOW_TASK_USER add (CREATE_TIME timestamp(6)); 

-- 2010-6-2 ---------------------------------------------------

alter table PERA_SIMULATION_FILE add (RELATIVE_PATH varchar2(2048)); 

alter table PERA_FLOW_TASK add(CREATE_TIME timestamp(6));

-- 2010-6-10 ---------------------------------------------------

alter table PERA_FLOW_R_DATA_V_FILE modify(STORE_PATH varchar2 (1024));


-- 2010-8-6 ---------------------------------------------------

alter table PERA_FLOW_TASK modify(SVN_PATH_APP varchar2 (512));

-- 2010-8-10 ---------------------------------------------------

alter table PERA_XPDL add (PROJECT_MANAGER_USERNAME varchar2(50));

alter table PERA_XPDL add (PROJECT_MANAGER_REALNAME varchar2(50));

alter table PERA_FLOW_PROCESS add (PROJECT_MANAGER_USERNAME varchar2(50));

alter table PERA_FLOW_PROCESS add (PROJECT_MANAGER_REALNAME varchar2(50));

-- 2010-8-17 ---------------------------------------------------

alter table PERA_XPDL add (CREATE_USER_NAME varchar2(255));

alter table PERA_XPDL_TEMPLATE add (CREATE_USER_NAME varchar2(255));

alter table PERA_XPDL_SIMULATION_TEMPLATE add (CREATE_USER_NAME varchar2(255));

alter table PERA_FLOW_PROCESS add (STARTER_NAME varchar2(255));

alter table PERA_FLOW_TASK add (USER_REAL_NAME varchar2(255));

alter table PERA_FLOW_TASK_AUDIT add (USER_REAL_NAME varchar2(255));

alter table PERA_FLOW_TASK_PARTNER add (PARTNER_NAME varchar2(255));

alter table PERA_FLOW_TASK_REFUSE add (USER_NAME varchar2(255));

-- 2010-8-18 ---------------------------------------------------

alter table PERA_FLOW_R_DATA_V_FILE add (FILE_ID varchar2(50));

-- 2010-8-19 ---------------------------------------------------

alter table PERA_FLOW_TRANSACTION add (CREATE_TYPE number(10));

-- 2010-8-26 ---------------------------------------------------

alter table PERA_XPDL_TYPE add (TYPENUM number(10)); 

-- 2010-10-14 ---------------------------------------------------

create table PERA_FLOW_TASK_EXECUTOR
(
  PK_FLOW_TASK_EXECUTOR_ID NUMBER(19) not null,
  FK_FLOW_TASK_ID          NUMBER(19),
  USER_OID                 VARCHAR2(255 CHAR),
  FINISH_TIME              TIMESTAMP(6)
)
;

alter table PERA_FLOW_TASK_EXECUTOR
  add primary key (PK_FLOW_TASK_EXECUTOR_ID);

alter table PERA_FLOW_TASK_EXECUTOR
  add constraint FK2A3FE37DFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);




