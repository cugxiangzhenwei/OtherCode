------------------------------------------------------
-- Export file for user WORKFLOW                    --
-- Created by Administrator on 2010-10-14, 10:27:10 --
------------------------------------------------------

spool workflow_ddl.log

prompt
prompt Creating table PERA_APPLICATION
prompt ===============================
prompt
create table PERA_APPLICATION
(
  PK_APPLICATION_ID NUMBER(19) not null,
  VERSION           NUMBER(10) not null,
  ICON              VARCHAR2(255 CHAR),
  NAME              VARCHAR2(255 CHAR),
  SERVLET_URL       VARCHAR2(255 CHAR),
  DESCRIPTION       VARCHAR2(1024 CHAR)
)
;
alter table PERA_APPLICATION
  add primary key (PK_APPLICATION_ID);

prompt
prompt Creating table PERA_APPLICATION_IMAGE
prompt =====================================
prompt
create table PERA_APPLICATION_IMAGE
(
  PK_APPLICATION_IMAGE_ID NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  APPLICATION_IMAGE       BLOB,
  FK_APPLICATION_ID       NUMBER(19)
)
;
alter table PERA_APPLICATION_IMAGE
  add primary key (PK_APPLICATION_IMAGE_ID);
alter table PERA_APPLICATION_IMAGE
  add unique (FK_APPLICATION_ID);
alter table PERA_APPLICATION_IMAGE
  add constraint FKFDD1ECD1CFD1E36D foreign key (FK_APPLICATION_ID)
  references PERA_APPLICATION (PK_APPLICATION_ID);

prompt
prompt Creating table PERA_EXTERNAL_LINK_TYPE
prompt ======================================
prompt
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

prompt
prompt Creating table PERA_EXTERNAL_LINK
prompt =================================
prompt
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

prompt
prompt Creating table PERA_FILE_TYPE
prompt =============================
prompt
create table PERA_FILE_TYPE
(
  PK_FILE_TYPE_ID NUMBER(19) not null,
  NAME            VARCHAR2(255 CHAR),
  DESCRIPTION     VARCHAR2(1024 CHAR),
  TYPESUFFIX      RAW(1000)
)
;
alter table PERA_FILE_TYPE
  add primary key (PK_FILE_TYPE_ID);

prompt
prompt Creating table PERA_FLOW_BLOCK
prompt ==============================
prompt
create table PERA_FLOW_BLOCK
(
  PK_FLOW_BLOCK_ID       NUMBER(19) not null,
  FK_PARENT_BLOCK_ID     NUMBER(19),
  FK_FLOW_PROCESS_ID     NUMBER(19),
  STATE                  NUMBER(10),
  BLOCK_ID               VARCHAR2(255),
  FK_FLOW_TRANSACTION_ID NUMBER(19)
)
;
alter table PERA_FLOW_BLOCK
  add primary key (PK_FLOW_BLOCK_ID);
alter table PERA_FLOW_BLOCK
  add constraint FKF4D0257290C62D3 foreign key (FK_FLOW_PROCESS_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_FLOW_BLOCK
  add constraint FKF4D0257F6DA0AD4 foreign key (FK_FLOW_TRANSACTION_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);
alter table PERA_FLOW_BLOCK
  add constraint FKF4D0257F6DA0AD7 foreign key (FK_PARENT_BLOCK_ID)
  references PERA_FLOW_BLOCK (PK_FLOW_BLOCK_ID);

prompt
prompt Creating table PERA_FLOW_PROCESS
prompt ================================
prompt
create table PERA_FLOW_PROCESS
(
  PK_FLOW_PROCESS_ID       NUMBER(19) not null,
  VERSION                  NUMBER(10) not null,
  END_TIME                 TIMESTAMP(6),
  START_TIME               TIMESTAMP(6),
  STATE                    NUMBER(10),
  FK_PARENT_ID             NUMBER(19),
  STARTER_OID              VARCHAR2(255 CHAR),
  PACKAGE_ID               VARCHAR2(255),
  PROCESS_ID               VARCHAR2(255),
  VERSION_NUMBER           VARCHAR2(255),
  FK_FLOW_BLOCK_ID         NUMBER(19),
  FK_FLOW_TRANSACTION_ID   NUMBER(19),
  PROCESS_NAME             VARCHAR2(255),
  USER_MAIN_MANAGE_DOMAIN  VARCHAR2(255 CHAR),
  PROJECT_REFERENCE        VARCHAR2(50 CHAR),
  PROJECT_NAME             VARCHAR2(512 CHAR),
  ROOT_PROCESS_ID          NUMBER(19),
  FRIEND_NAME              VARCHAR2(512 CHAR),
  FRIEND_REFERENCE         VARCHAR2(50 CHAR),
  PROJECT_MANAGER_USERNAME VARCHAR2(50 CHAR),
  PROJECT_MANAGER_REALNAME VARCHAR2(50 CHAR),
  STARTER_NAME             VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_PROCESS
  add primary key (PK_FLOW_PROCESS_ID);
alter table PERA_FLOW_PROCESS
  add constraint FK5EEA0DB96A67FB87 foreign key (FK_PARENT_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_FLOW_PROCESS
  add constraint FK5EEA0DB9D2AD053 foreign key (FK_FLOW_BLOCK_ID)
  references PERA_FLOW_BLOCK (PK_FLOW_BLOCK_ID);
alter table PERA_FLOW_PROCESS
  add constraint FK5EEA0DB9D2AD054 foreign key (FK_FLOW_TRANSACTION_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);

prompt
prompt Creating table PERA_FLOW_TRANSACTION
prompt ====================================
prompt
create table PERA_FLOW_TRANSACTION
(
  PK_FLOW_TRANSACTION_ID NUMBER(19) not null,
  VERSION                NUMBER(10) not null,
  FK_FLOW_PROCESS_ID     NUMBER(19),
  STATE                  NUMBER(10),
  EXEC_TIMES             NUMBER(10),
  EXEC_SEQUENCE          NUMBER(10),
  CREATE_FROM            NUMBER(10),
  CREATE_TYPE            NUMBER(10)
)
;
alter table PERA_FLOW_TRANSACTION
  add primary key (PK_FLOW_TRANSACTION_ID);
alter table PERA_FLOW_TRANSACTION
  add constraint FKEF20528290C62D3 foreign key (FK_FLOW_PROCESS_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);

prompt
prompt Creating table PERA_FLOW_TASK
prompt =============================
prompt
create table PERA_FLOW_TASK
(
  PK_FLOW_TASK_ID         NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  START_TIME              TIMESTAMP(6),
  END_TIME                TIMESTAMP(6),
  USER_OID                VARCHAR2(255 CHAR),
  FK_FLOW_PROCESS_ID      NUMBER(19),
  FK_FLOW_BLOCK_ID        NUMBER(19),
  STATE                   NUMBER(10),
  FK_FLOW_TRANSACTION_ID  NUMBER(19),
  DATA_MAN_PACKAGE        VARCHAR2(1024 CHAR),
  DATA_MAN_BOMID          VARCHAR2(1024 CHAR),
  NODE_ID                 VARCHAR2(255),
  EXPERIMENT_TASK_ID      VARCHAR2(255),
  DESCRIPTION             VARCHAR2(1024 CHAR),
  ABANDON_REASON          VARCHAR2(1024 CHAR),
  BORN                    NUMBER(10),
  NODE_NAME               VARCHAR2(255),
  PLAN_START_TIME         VARCHAR2(255),
  PLAN_END_TIME           VARCHAR2(255),
  AUDIT_VERSION           NUMBER(10),
  SCHEDULE                NUMBER(10),
  BOM_ID                  VARCHAR2(255),
  BOM_NAME                VARCHAR2(255),
  USER_MAIN_MANAGE_DOMAIN VARCHAR2(255 CHAR),
  PRODUCT_ID              VARCHAR2(255 CHAR),
  PRODUCT_PATH            VARCHAR2(2048 CHAR),
  PRODUCT_NAME            VARCHAR2(512 CHAR),
  BOM_ID_APP              VARCHAR2(50 CHAR),
  BOM_NAME_APP            VARCHAR2(255 CHAR),
  BUS_ID_APP              VARCHAR2(50 CHAR),
  BUS_NAME_APP            VARCHAR2(255 CHAR),
  PRODUCT_ID_APP          VARCHAR2(50 CHAR),
  PRODUCT_NAME_APP        VARCHAR2(255 CHAR),
  QUERY_BOM_ID            VARCHAR2(255 CHAR),
  LCA_URL                 VARCHAR2(512 CHAR),
  LCA_LOCATION            VARCHAR2(512 CHAR),
  ACTI_PRIORITY           NUMBER(10),
  DIFFICULTY              NUMBER(10),
  WORKBENCH_WORKPATH      VARCHAR2(255 CHAR),
  WORKBENCH_ENVIROMENT    VARCHAR2(255 CHAR),
  SVN_PATH_APP            VARCHAR2(255 CHAR),
  CREATE_TIME             TIMESTAMP(6),
  USER_REAL_NAME          VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_TASK
  add primary key (PK_FLOW_TASK_ID);
alter table PERA_FLOW_TASK
  add constraint FK194C925B290C62D3 foreign key (FK_FLOW_PROCESS_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_FLOW_TASK
  add constraint FK194C925BD2AD053 foreign key (FK_FLOW_BLOCK_ID)
  references PERA_FLOW_BLOCK (PK_FLOW_BLOCK_ID);
alter table PERA_FLOW_TASK
  add constraint FK194C925BF1C5F3F3 foreign key (FK_FLOW_TRANSACTION_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);

prompt
prompt Creating table PERA_FLOW_ASSIGN_TASK_RECORD
prompt ===========================================
prompt
create table PERA_FLOW_ASSIGN_TASK_RECORD
(
  PK_FLOW_ASSIGN_TASK_RECORD_ID NUMBER(19) not null,
  FK_FLOW_TASK_ID               NUMBER(19),
  START_TIME                    TIMESTAMP(6),
  END_TIME                      TIMESTAMP(6),
  PLAN_END_TIME                 TIMESTAMP(6),
  PLAN_START_TIME               TIMESTAMP(6),
  ASSIGN_TASK_REASON            VARCHAR2(1024 CHAR),
  ASSIGN_TASK_TIME              TIMESTAMP(6),
  EXECUTOR_ID                   VARCHAR2(255 CHAR),
  EXECUTOR_NAME                 VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_ASSIGN_TASK_RECORD
  add primary key (PK_FLOW_ASSIGN_TASK_RECORD_ID);
alter table PERA_FLOW_ASSIGN_TASK_RECORD
  add constraint FK18C7FB51DFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_R_DATA_VALUE
prompt =====================================
prompt
create table PERA_FLOW_R_DATA_VALUE
(
  PK_FLOW_R_DATA_VALUE_ID NUMBER(19) not null,
  FK_FLOW_TASK_ID         NUMBER(19),
  VALUE                   VARCHAR2(255 CHAR),
  ADD_TYPE                NUMBER(10),
  DATA_ID                 VARCHAR2(255)
)
;
alter table PERA_FLOW_R_DATA_VALUE
  add primary key (PK_FLOW_R_DATA_VALUE_ID);
alter table PERA_FLOW_R_DATA_VALUE
  add constraint FK3CAC795FDFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_R_DATA_V_ITEM
prompt ======================================
prompt
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

prompt
prompt Creating table PERA_FLOW_R_DATA_V_FILE
prompt ======================================
prompt
create table PERA_FLOW_R_DATA_V_FILE
(
  PK_FLOW_R_D_V_FILE_ID NUMBER(19) not null,
  VERSION               NUMBER(10) not null,
  FILE_NAME             VARCHAR2(255 CHAR),
  FK_FLOW_R_D_V_ID      NUMBER(19),
  STORE_PATH            VARCHAR2(1024 CHAR),
  SVN_VERSION           VARCHAR2(255 CHAR),
  FK_FLOW_R_D_V_I_ID    NUMBER(19),
  PACKAGE_ID            VARCHAR2(50 CHAR),
  PACKAGE_NAME          VARCHAR2(255 CHAR),
  CLIENT_VERSION        VARCHAR2(255 CHAR),
  STATUS                VARCHAR2(10 CHAR),
  FILE_ID               VARCHAR2(50 CHAR)
)
;
alter table PERA_FLOW_R_DATA_V_FILE
  add primary key (PK_FLOW_R_D_V_FILE_ID);
alter table PERA_FLOW_R_DATA_V_FILE
  add unique (FK_FLOW_R_D_V_ID);
alter table PERA_FLOW_R_DATA_V_FILE
  add unique (FK_FLOW_R_D_V_I_ID);
alter table PERA_FLOW_R_DATA_V_FILE
  add constraint FK5A868D7731C6216F foreign key (FK_FLOW_R_D_V_ID)
  references PERA_FLOW_R_DATA_VALUE (PK_FLOW_R_DATA_VALUE_ID);
alter table PERA_FLOW_R_DATA_V_FILE
  add constraint FK5A868D7749F3B838 foreign key (FK_FLOW_R_D_V_I_ID)
  references PERA_FLOW_R_DATA_V_ITEM (PK_FLOW_R_D_V_I_ID);

prompt
prompt Creating table PERA_FLOW_R_DATA_V_F_DATA
prompt ========================================
prompt
create table PERA_FLOW_R_DATA_V_F_DATA
(
  PK_FLOW_R_D_V_F_D_ID NUMBER(19) not null,
  VERSION              NUMBER(10) not null,
  FILE_DATA            BLOB,
  FK_FLOW_R_D_V_F_ID   NUMBER(19)
)
;
alter table PERA_FLOW_R_DATA_V_F_DATA
  add primary key (PK_FLOW_R_D_V_F_D_ID);
alter table PERA_FLOW_R_DATA_V_F_DATA
  add unique (FK_FLOW_R_D_V_F_ID);
alter table PERA_FLOW_R_DATA_V_F_DATA
  add constraint FKD44B693E49F0D584 foreign key (FK_FLOW_R_D_V_F_ID)
  references PERA_FLOW_R_DATA_V_FILE (PK_FLOW_R_D_V_FILE_ID);

prompt
prompt Creating table PERA_FLOW_TASK_AUDIT
prompt ===================================
prompt
create table PERA_FLOW_TASK_AUDIT
(
  PK_FLOW_TASK_AUDIT_ID NUMBER(19) not null,
  USER_NAME             VARCHAR2(255),
  AUDIT_TIME            TIMESTAMP(6),
  REMARK                VARCHAR2(1024),
  FK_FLOW_TASK_ID       NUMBER(19),
  AGREE                 CHAR(1) not null,
  FINISH                CHAR(1),
  AUDIT_VERSION         NUMBER(10),
  USER_REAL_NAME        VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_TASK_AUDIT
  add primary key (PK_FLOW_TASK_AUDIT_ID);
alter table PERA_FLOW_TASK_AUDIT
  add constraint FKA320F27810E6DD88 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_TASK_EXECUTOR
prompt ======================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_BLOCK
prompt =================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_PROCESS
prompt ===================================
prompt
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
  ROOT_PROCESS_ID         NUMBER(19),
  FRIEND_REFERENCE        VARCHAR2(50 CHAR),
  FRIEND_NAME             VARCHAR2(512 CHAR)
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

prompt
prompt Creating table PERA_HISTORY_TASK
prompt ================================
prompt
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
  PRODUCT_PATH            VARCHAR2(2048 CHAR),
  BOM_ID_APP              VARCHAR2(50 CHAR),
  BOM_NAME_APP            VARCHAR2(255 CHAR),
  BUS_ID_APP              VARCHAR2(50 CHAR),
  BUS_NAME_APP            VARCHAR2(255 CHAR),
  SVN_PATH_APP            VARCHAR2(255 CHAR),
  PRODUCT_ID_APP          VARCHAR2(50 CHAR),
  PRODUCT_NAME_APP        VARCHAR2(255 CHAR),
  LCA_URL                 VARCHAR2(512 CHAR),
  LCA_LOCATION            VARCHAR2(512 CHAR),
  ACTI_PRIORITY           NUMBER(10),
  DIFFICULTY              NUMBER(10),
  QUERY_BOM_ID            VARCHAR2(255 CHAR),
  WORKBENCH_ENVIROMENT    VARCHAR2(255 CHAR),
  WORKBENCH_WORKPATH      VARCHAR2(255 CHAR)
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

prompt
prompt Creating table PERA_FLOW_TASK_PARTNER
prompt =====================================
prompt
create table PERA_FLOW_TASK_PARTNER
(
  PK_FLOW_TASK_PARTNER_ID NUMBER(19) not null,
  PARTNER_OID             VARCHAR2(255 CHAR),
  TYPE                    NUMBER(10),
  FK_FLOW_TASK_ID         NUMBER(19),
  PARTNER_DISPLAY         VARCHAR2(255 CHAR),
  PARTNER_NAME            VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_TASK_PARTNER
  add primary key (PK_FLOW_TASK_PARTNER_ID);
alter table PERA_FLOW_TASK_PARTNER
  add constraint FK510616C4A3692345 foreign key (FK_FLOW_TASK_ID)
  references PERA_HISTORY_TASK (PK_FLOW_TASK_ID);
alter table PERA_FLOW_TASK_PARTNER
  add constraint FK510616C4DFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_TASK_REFUSE
prompt ====================================
prompt
create table PERA_FLOW_TASK_REFUSE
(
  PK_FLOW_TASK_REFUSE_ID NUMBER(19) not null,
  FK_FLOW_TASK_ID        NUMBER(19),
  REMARK                 VARCHAR2(1024 CHAR),
  REFUSE_TIME            TIMESTAMP(6),
  USER_OID               VARCHAR2(255 CHAR),
  USER_NAME              VARCHAR2(255 CHAR)
)
;
alter table PERA_FLOW_TASK_REFUSE
  add primary key (PK_FLOW_TASK_REFUSE_ID);
alter table PERA_FLOW_TASK_REFUSE
  add constraint FKA320F27810E6DD26 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_TASK_USER
prompt ==================================
prompt
create table PERA_FLOW_TASK_USER
(
  PK_FLOW_TASK_USER_ID NUMBER(19) not null,
  USER_OID             VARCHAR2(255 CHAR),
  FK_FLOW_TASK_ID      NUMBER(19),
  CREATE_TIME          TIMESTAMP(6)
)
;
alter table PERA_FLOW_TASK_USER
  add primary key (PK_FLOW_TASK_USER_ID);
alter table PERA_FLOW_TASK_USER
  add constraint FK9A6A4B2FDFE9E6C1 foreign key (FK_FLOW_TASK_ID)
  references PERA_FLOW_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_FLOW_TRANSACTION_R
prompt ======================================
prompt
create table PERA_FLOW_TRANSACTION_R
(
  FK_PREVIOUS_TRANSA_ID NUMBER(19) not null,
  FK_POST_TRANSA_ID     NUMBER(19) not null
)
;
alter table PERA_FLOW_TRANSACTION_R
  add primary key (FK_POST_TRANSA_ID, FK_PREVIOUS_TRANSA_ID);
alter table PERA_FLOW_TRANSACTION_R
  add constraint FK1A8566FBA949CB5C foreign key (FK_POST_TRANSA_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);
alter table PERA_FLOW_TRANSACTION_R
  add constraint FK1A8566FBAF9D3FF3 foreign key (FK_PREVIOUS_TRANSA_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);

prompt
prompt Creating table PERA_FLOW_TRANSITION
prompt ===================================
prompt
create table PERA_FLOW_TRANSITION
(
  PK_FLOW_TRANSITION_ID  NUMBER(19) not null,
  VERSION                NUMBER(10) not null,
  FK_FLOW_TRANSACTION_ID NUMBER(19),
  WALKED                 CHAR(1 CHAR) not null,
  EDGE_ID                VARCHAR2(255),
  FK_FLOW_PROCESS_ID     NUMBER(19)
)
;
alter table PERA_FLOW_TRANSITION
  add primary key (PK_FLOW_TRANSITION_ID);
alter table PERA_FLOW_TRANSITION
  add constraint FKC72545AB290C62D3 foreign key (FK_FLOW_PROCESS_ID)
  references PERA_FLOW_PROCESS (PK_FLOW_PROCESS_ID);
alter table PERA_FLOW_TRANSITION
  add constraint FKC72545ABF1C5F3F3 foreign key (FK_FLOW_TRANSACTION_ID)
  references PERA_FLOW_TRANSACTION (PK_FLOW_TRANSACTION_ID);

prompt
prompt Creating table PERA_HISTORY_R_DATA_VALUE
prompt ========================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_R_DATA_V_ITEM
prompt =========================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_R_DATA_V_FILE
prompt =========================================
prompt
create table PERA_HISTORY_R_DATA_V_FILE
(
  PK_FLOW_R_D_V_FILE_ID NUMBER(19) not null,
  VERSION               NUMBER(10) not null,
  FILE_NAME             VARCHAR2(255 CHAR),
  FK_FLOW_R_D_V_ID      NUMBER(19),
  FK_FLOW_R_D_V_I_ID    NUMBER(19),
  STORE_PATH            VARCHAR2(255 CHAR),
  SVN_VERSION           VARCHAR2(1024 CHAR),
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

prompt
prompt Creating table PERA_HISTORY_R_DATA_V_F_DATA
prompt ===========================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_TASK_AUDIT
prompt ======================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_TASK_PARTNER
prompt ========================================
prompt
create table PERA_HISTORY_TASK_PARTNER
(
  PK_FLOW_TASK_PARTNER_ID NUMBER(19) not null,
  PARTNER_OID             VARCHAR2(255 CHAR),
  PARTNER_DISPLAY         VARCHAR2(255 CHAR),
  TYPE                    NUMBER(10),
  FK_FLOW_TASK_ID         NUMBER(19)
)
;
alter table PERA_HISTORY_TASK_PARTNER
  add primary key (PK_FLOW_TASK_PARTNER_ID);
alter table PERA_HISTORY_TASK_PARTNER
  add constraint FKBF976454A3692345 foreign key (FK_FLOW_TASK_ID)
  references PERA_HISTORY_TASK (PK_FLOW_TASK_ID);

prompt
prompt Creating table PERA_HISTORY_TASK_REFUSE
prompt =======================================
prompt
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

prompt
prompt Creating table PERA_HISTORY_TRANSITION
prompt ======================================
prompt
create table PERA_HISTORY_TRANSITION
(
  PK_FLOW_TRANSITION_ID NUMBER(19) not null,
  VERSION               NUMBER(10) not null,
  EDGE_ID               VARCHAR2(255 CHAR),
  WALKED                CHAR(1 CHAR) not null,
  FK_FLOW_PROCESS_ID    NUMBER(19)
)
;
alter table PERA_HISTORY_TRANSITION
  add primary key (PK_FLOW_TRANSITION_ID);
alter table PERA_HISTORY_TRANSITION
  add constraint FK41CCB73B5CAFA7CF foreign key (FK_FLOW_PROCESS_ID)
  references PERA_HISTORY_PROCESS (PK_FLOW_PROCESS_ID);

prompt
prompt Creating table PERA_HOLIDAY_YEAR
prompt ================================
prompt
create table PERA_HOLIDAY_YEAR
(
  PK_HOLIDAY_YEAR_ID NUMBER(19) not null,
  YEAR               NUMBER(10),
  CREATED_TIME       TIMESTAMP(6),
  NAME               VARCHAR2(255),
  DESCRIPTION        VARCHAR2(1024),
  FROM_DATE          TIMESTAMP(6),
  TO_DATE            TIMESTAMP(6)
)
;
alter table PERA_HOLIDAY_YEAR
  add primary key (PK_HOLIDAY_YEAR_ID);

prompt
prompt Creating table PERA_HOLIDAY_DATA
prompt ================================
prompt
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

prompt
prompt Creating table PERA_HOLIDAY_REGULAR
prompt ===================================
prompt
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

prompt
prompt Creating table PERA_SECURITY_GROUP
prompt ==================================
prompt
create table PERA_SECURITY_GROUP
(
  PK_GROUP_ID  NUMBER(19) not null,
  VERSION      NUMBER(10) not null,
  DESCRIPTION  VARCHAR2(500 CHAR),
  NAME         VARCHAR2(50 CHAR) not null,
  FK_PARENT_ID NUMBER(19)
)
;
alter table PERA_SECURITY_GROUP
  add primary key (PK_GROUP_ID);
alter table PERA_SECURITY_GROUP
  add unique (NAME);
alter table PERA_SECURITY_GROUP
  add constraint FK5438B75BB88B4A02 foreign key (FK_PARENT_ID)
  references PERA_SECURITY_GROUP (PK_GROUP_ID);

prompt
prompt Creating table PERA_SECURITY_PERMISSION
prompt =======================================
prompt
create table PERA_SECURITY_PERMISSION
(
  PK_PERMISSION_ID NUMBER(19) not null,
  VERSION          NUMBER(10) not null,
  DESCN            VARCHAR2(500 CHAR),
  NAME             VARCHAR2(50 CHAR) not null,
  OPERATION        VARCHAR2(255 CHAR),
  STATUS           VARCHAR2(50 CHAR)
)
;
alter table PERA_SECURITY_PERMISSION
  add primary key (PK_PERMISSION_ID);
alter table PERA_SECURITY_PERMISSION
  add unique (NAME);

prompt
prompt Creating table PERA_SECURITY_RESOURCE
prompt =====================================
prompt
create table PERA_SECURITY_RESOURCE
(
  PK_RESOURCE_ID NUMBER(19) not null,
  VERSION        NUMBER(10) not null,
  DESCN          VARCHAR2(500 CHAR) not null,
  NAME           VARCHAR2(50 CHAR) not null,
  RES_STRING     VARCHAR2(255 CHAR) not null,
  RES_TYPE       VARCHAR2(255 CHAR) not null
)
;
alter table PERA_SECURITY_RESOURCE
  add primary key (PK_RESOURCE_ID);
alter table PERA_SECURITY_RESOURCE
  add unique (NAME);

prompt
prompt Creating table PERA_SECURITY_PERMI_RES
prompt ======================================
prompt
create table PERA_SECURITY_PERMI_RES
(
  PERMISSION_ID NUMBER(19) not null,
  RESOURCE_ID   NUMBER(19) not null
)
;
alter table PERA_SECURITY_PERMI_RES
  add primary key (PERMISSION_ID, RESOURCE_ID);
alter table PERA_SECURITY_PERMI_RES
  add constraint FK10D5E59644DFE1CD foreign key (PERMISSION_ID)
  references PERA_SECURITY_PERMISSION (PK_PERMISSION_ID);
alter table PERA_SECURITY_PERMI_RES
  add constraint FK10D5E596A554C62D foreign key (RESOURCE_ID)
  references PERA_SECURITY_RESOURCE (PK_RESOURCE_ID);

prompt
prompt Creating table PERA_SECURITY_ROLE
prompt =================================
prompt
create table PERA_SECURITY_ROLE
(
  PK_ROLE_ID   NUMBER(19) not null,
  VERSION      NUMBER(10) not null,
  NAME         VARCHAR2(50 CHAR) not null,
  DESCRIPTION  VARCHAR2(255 CHAR),
  DISPLAY_NAME VARCHAR2(255 CHAR)
)
;
alter table PERA_SECURITY_ROLE
  add primary key (PK_ROLE_ID);
alter table PERA_SECURITY_ROLE
  add unique (NAME);

prompt
prompt Creating table PERA_SECURITY_ROLE_PERMI
prompt =======================================
prompt
create table PERA_SECURITY_ROLE_PERMI
(
  PERMISSION_ID NUMBER(19) not null,
  ROLE_ID       NUMBER(19) not null
)
;
alter table PERA_SECURITY_ROLE_PERMI
  add primary key (ROLE_ID, PERMISSION_ID);
alter table PERA_SECURITY_ROLE_PERMI
  add constraint FKCB5EA2D444DFE1CD foreign key (PERMISSION_ID)
  references PERA_SECURITY_PERMISSION (PK_PERMISSION_ID);
alter table PERA_SECURITY_ROLE_PERMI
  add constraint FKCB5EA2D48E441EAD foreign key (ROLE_ID)
  references PERA_SECURITY_ROLE (PK_ROLE_ID);

prompt
prompt Creating table PERA_SECURITY_USER
prompt =================================
prompt
create table PERA_SECURITY_USER
(
  PK_USER_ID          NUMBER(19) not null,
  VERSION             NUMBER(10) not null,
  USERNAME            VARCHAR2(20 CHAR) not null,
  PASSWORD            VARCHAR2(255 CHAR) not null,
  FIRST_NAME          VARCHAR2(50 CHAR) not null,
  LAST_NAME           VARCHAR2(50 CHAR) not null,
  EMAIL               VARCHAR2(255 CHAR) not null,
  PHONE_NUMBER        VARCHAR2(255 CHAR),
  WEBSITE             VARCHAR2(255 CHAR),
  PASSWORD_HINT       VARCHAR2(255 CHAR),
  ACCOUNT_ENABLED     CHAR(1 CHAR),
  ACCOUNT_EXPIRED     CHAR(1 CHAR) not null,
  ACCOUNT_LOCKED      CHAR(1 CHAR) not null,
  CREDENTIALS_EXPIRED CHAR(1 CHAR) not null,
  BIRTHDAY            VARCHAR2(19 CHAR),
  GENDER              VARCHAR2(1 CHAR),
  MOBILE_NUMBER       VARCHAR2(255 CHAR),
  NICK_NAME           VARCHAR2(50 CHAR)
)
;
alter table PERA_SECURITY_USER
  add primary key (PK_USER_ID);
alter table PERA_SECURITY_USER
  add unique (USERNAME);
alter table PERA_SECURITY_USER
  add unique (EMAIL);

prompt
prompt Creating table PERA_SECURITY_USER_GROUP
prompt =======================================
prompt
create table PERA_SECURITY_USER_GROUP
(
  GROUP_ID NUMBER(19) not null,
  USER_ID  NUMBER(19) not null
)
;
alter table PERA_SECURITY_USER_GROUP
  add primary key (USER_ID, GROUP_ID);
alter table PERA_SECURITY_USER_GROUP
  add constraint FKD15C856F336EE28D foreign key (USER_ID)
  references PERA_SECURITY_USER (PK_USER_ID);
alter table PERA_SECURITY_USER_GROUP
  add constraint FKD15C856F67B37B07 foreign key (GROUP_ID)
  references PERA_SECURITY_GROUP (PK_GROUP_ID);

prompt
prompt Creating table PERA_SECURITY_USER_ROLE
prompt ======================================
prompt
create table PERA_SECURITY_USER_ROLE
(
  ROLE_ID NUMBER(19) not null,
  USER_ID NUMBER(19) not null
)
;
alter table PERA_SECURITY_USER_ROLE
  add primary key (USER_ID, ROLE_ID);
alter table PERA_SECURITY_USER_ROLE
  add constraint FKFE83CF66336EE28D foreign key (USER_ID)
  references PERA_SECURITY_USER (PK_USER_ID);
alter table PERA_SECURITY_USER_ROLE
  add constraint FKFE83CF668E441EAD foreign key (ROLE_ID)
  references PERA_SECURITY_ROLE (PK_ROLE_ID);

prompt
prompt Creating table PERA_SIMULATION_FILE
prompt ===================================
prompt
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
  UPDATE_USER_REALNAME VARCHAR2(255 CHAR),
  RELATIVE_PATH        VARCHAR2(2048 CHAR)
)
;
alter table PERA_SIMULATION_FILE
  add primary key (PK_SIM_FILE_ID);

prompt
prompt Creating table PERA_SIM_COMPONENT
prompt =================================
prompt
create table PERA_SIM_COMPONENT
(
  PK_ID      NUMBER(19) not null,
  USER_ID    VARCHAR2(510) not null,
  TASK_ID    NUMBER(19) not null,
  EID        VARCHAR2(510) not null,
  ESTATUS    VARCHAR2(2) not null,
  EINPUT     VARCHAR2(2000),
  EOUTPUT    VARCHAR2(2000),
  CREATETIME TIMESTAMP(6) not null,
  VALIDFLAG  VARCHAR2(1) not null
)
;
alter table PERA_SIM_COMPONENT
  add constraint NEW_PRIMARY_KEY primary key (PK_ID);

prompt
prompt Creating table PERA_TASK_REJECT_APPLICATION
prompt ===========================================
prompt
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

prompt
prompt Creating table PERA_XPDL_VERSION
prompt ================================
prompt
create table PERA_XPDL_VERSION
(
  PK_VERSION_ID      NUMBER(19) not null,
  NAME               VARCHAR2(1024),
  MAX_VERSION_NUMBER NUMBER(10),
  PACKAGE_ID         VARCHAR2(50 CHAR)
)
;
alter table PERA_XPDL_VERSION
  add primary key (PK_VERSION_ID);

prompt
prompt Creating table PERA_XPDL
prompt ========================
prompt
create table PERA_XPDL
(
  PK_XPDL_ID               NUMBER(19) not null,
  VERSION                  NUMBER(10) not null,
  CREATION_DATE            VARCHAR2(50 CHAR),
  DESCRIPTION              VARCHAR2(255 CHAR),
  NAME                     VARCHAR2(1024),
  PACKAGE_ID               VARCHAR2(50 CHAR),
  SOURCE_VENDOR_ID         VARCHAR2(50 CHAR),
  STATE                    NUMBER(10),
  PROJECT_REFERENCE        VARCHAR2(50 CHAR),
  VERSION_NUMBER           NUMBER(10),
  XPDL_VERSION             VARCHAR2(50 CHAR),
  FK_VERSION_ID            NUMBER(19),
  PROJECT_NAME             VARCHAR2(512 CHAR),
  CREATE_USER              VARCHAR2(255 CHAR),
  USER_MAIN_MANAGE_DOMAIN  VARCHAR2(255 CHAR),
  PROJECT_PROCESS_NAME     VARCHAR2(255 CHAR),
  PROJECT_TASK_FILE_NAME   VARCHAR2(255 CHAR),
  PROJECT_TASK_FILE_PATH   VARCHAR2(255 CHAR),
  FRIEND_REFERENCE         VARCHAR2(50 CHAR),
  FRIEND_NAME              VARCHAR2(512 CHAR),
  PROJECT_MANAGER_USERNAME VARCHAR2(50 CHAR),
  PROJECT_MANAGER_REALNAME VARCHAR2(50 CHAR),
  CREATE_USER_NAME         VARCHAR2(255 CHAR)
)
;
alter table PERA_XPDL
  add primary key (PK_XPDL_ID);
alter table PERA_XPDL
  add constraint FKBB21B1FB853BC176 foreign key (FK_VERSION_ID)
  references PERA_XPDL_VERSION (PK_VERSION_ID);

prompt
prompt Creating table PERA_XPDL_DATA
prompt =============================
prompt
create table PERA_XPDL_DATA
(
  PK_XPDL_DATA_ID NUMBER(19) not null,
  VERSION         NUMBER(10) not null,
  FK_XPDL_ID      NUMBER(19),
  XPDL            BLOB
)
;
alter table PERA_XPDL_DATA
  add primary key (PK_XPDL_DATA_ID);
alter table PERA_XPDL_DATA
  add unique (FK_XPDL_ID);
alter table PERA_XPDL_DATA
  add constraint FKCCEFF36EB30AC9DE foreign key (FK_XPDL_ID)
  references PERA_XPDL (PK_XPDL_ID);

prompt
prompt Creating table PERA_XPDL_PROJECT
prompt ================================
prompt
create table PERA_XPDL_PROJECT
(
  PK_XPDL_PROJECT_ID NUMBER(19) not null,
  NAME               VARCHAR2(255 CHAR),
  USER_OID           VARCHAR2(255 CHAR),
  START_TIME         TIMESTAMP(6),
  END_TIME           TIMESTAMP(6),
  STATE              NUMBER(10),
  DESCRIPTION        VARCHAR2(1024 CHAR)
)
;
alter table PERA_XPDL_PROJECT
  add primary key (PK_XPDL_PROJECT_ID);

prompt
prompt Creating table PERA_XPDL_SIMULATION_TYPE
prompt ========================================
prompt
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

prompt
prompt Creating table PERA_XPDL_SIMULATION_TEMPLATE
prompt ============================================
prompt
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
  UPDATE_USER_REALNAME    VARCHAR2(255 CHAR),
  CREATE_USER_NAME        VARCHAR2(255 CHAR)
)
;
alter table PERA_XPDL_SIMULATION_TEMPLATE
  add primary key (PK_XPDL_SIM_TEMPLATE_ID);
alter table PERA_XPDL_SIMULATION_TEMPLATE
  add constraint FK9717A76E96304784 foreign key (FK_XPDL_TYPE_ID)
  references PERA_XPDL_SIMULATION_TYPE (PK_XPDL_SIM_TYPE_ID);

prompt
prompt Creating table PERA_XPDL_TYPE
prompt =============================
prompt
create table PERA_XPDL_TYPE
(
  PK_XPDL_TYPE_ID NUMBER(19) not null,
  VERSION         NUMBER(10) not null,
  NAME            VARCHAR2(255 CHAR),
  DESCRIPTION     VARCHAR2(1024 CHAR),
  FK_PARENT_ID    NUMBER(19),
  KNOWLEDGE_FLG   VARCHAR2(255 CHAR),
  TYPE_CODE       VARCHAR2(255 CHAR),
  TYPENUM         NUMBER(10)
)
;
alter table PERA_XPDL_TYPE
  add primary key (PK_XPDL_TYPE_ID);
alter table PERA_XPDL_TYPE
  add constraint FKCCF792FE5CA8F14E foreign key (FK_PARENT_ID)
  references PERA_XPDL_TYPE (PK_XPDL_TYPE_ID);

prompt
prompt Creating table PERA_XPDL_T_V
prompt ============================
prompt
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

prompt
prompt Creating table PERA_XPDL_TEMPLATE
prompt =================================
prompt
create table PERA_XPDL_TEMPLATE
(
  PK_XPDL_TEMPLATE_ID     NUMBER(19) not null,
  VERSION                 NUMBER(10) not null,
  NAME                    VARCHAR2(255 CHAR),
  DESCRIPTION             VARCHAR2(1024 CHAR),
  FK_XPDL_TYPE_ID         NUMBER(19),
  STATE                   NUMBER(10),
  FK_VERSION_ID           NUMBER(19),
  VERSION_NUMBER          NUMBER(10),
  CREATE_USER             VARCHAR2(255 CHAR),
  USER_MAIN_MANAGE_DOMAIN VARCHAR2(255 CHAR),
  CREATED_TIME            TIMESTAMP(6),
  PUBLISH_TIME            TIMESTAMP(6),
  PK_XPDL_SIM_TEMPLATE_ID NUMBER(19),
  FILE_PATH               VARCHAR2(2048 CHAR),
  TEMPLATE_NUMBER         VARCHAR2(255 CHAR),
  CREATE_USER_NAME        VARCHAR2(255 CHAR)
)
;
alter table PERA_XPDL_TEMPLATE
  add primary key (PK_XPDL_TEMPLATE_ID);
alter table PERA_XPDL_TEMPLATE
  add constraint FK6A7D463E1D514D9C foreign key (FK_VERSION_ID)
  references PERA_XPDL_T_V (PK_VERSION_ID);
alter table PERA_XPDL_TEMPLATE
  add constraint FK6A7D463EB7FAF533 foreign key (FK_XPDL_TYPE_ID)
  references PERA_XPDL_TYPE (PK_XPDL_TYPE_ID);

prompt
prompt Creating table PERA_XPDL_TEMPLATE_DATA
prompt ======================================
prompt
create table PERA_XPDL_TEMPLATE_DATA
(
  PK_XPDL_TEMPLATE_DATA_ID NUMBER(19) not null,
  VERSION                  NUMBER(10) not null,
  TEMPLATE_DATA            BLOB,
  FK_TEMPLATE_ID           NUMBER(19)
)
;
alter table PERA_XPDL_TEMPLATE_DATA
  add primary key (PK_XPDL_TEMPLATE_DATA_ID);
alter table PERA_XPDL_TEMPLATE_DATA
  add unique (FK_TEMPLATE_ID);
alter table PERA_XPDL_TEMPLATE_DATA
  add constraint FK7E05910B8A2BA03E foreign key (FK_TEMPLATE_ID)
  references PERA_XPDL_TEMPLATE (PK_XPDL_TEMPLATE_ID);

prompt
prompt Creating sequence HIBERNATE_SEQUENCE
prompt ====================================
prompt
create sequence HIBERNATE_SEQUENCE
minvalue 1
maxvalue 999999999999999999999999999
start with 88539
increment by 1
cache 20;


spool off
