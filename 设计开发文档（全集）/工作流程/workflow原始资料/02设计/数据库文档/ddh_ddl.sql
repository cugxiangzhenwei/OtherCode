-----------------------------------------------------
-- Export file for user WORKFLOW                   --
-- Created by Administrator on 2009-7-28, 16:58:03 --
-----------------------------------------------------

spool ddh_ddl.log

prompt
prompt Creating table PERA_DDH_TOOLICON
prompt ================================
prompt
create table PERA_DDH_TOOLICON
(
  PK_TOOLICON_ID NUMBER(19) not null,
  CONTENT        BLOB,
  VERSION        NUMBER(10) not null
)
;
alter table PERA_DDH_TOOLICON
  add constraint PK_PERA_DDH_TOOLICON primary key (PK_TOOLICON_ID);

prompt
prompt Creating table PERA_DDH_SCRIPT
prompt ==============================
prompt
create table PERA_DDH_SCRIPT
(
  PK_SCRIPT_ID NUMBER(19) not null,
  VALUE        VARCHAR2(2048),
  VERSION      NUMBER(10) not null
)
;
alter table PERA_DDH_SCRIPT
  add constraint PK_PERA_DDH_SCRIPT primary key (PK_SCRIPT_ID);

prompt
prompt Creating table PERA_DDH_TOOL
prompt ============================
prompt
create table PERA_DDH_TOOL
(
  PK_TOOL_ID        NUMBER(19) not null,
  CODE              VARCHAR2(16) not null,
  NAME              VARCHAR2(64) not null,
  INVOKER           VARCHAR2(256),
  DESCRIPTION       VARCHAR2(2048),
  FK_TOOLICON_ID    NUMBER(19),
  FK_SCRIPT_ID      NUMBER(19),
  VERSION           NUMBER(10) not null,
  SOFTWAREID        VARCHAR2(64),
  SOFTWARENAME      VARCHAR2(256),
  CLIENTDESCRIPTION VARCHAR2(2048)
)
;
alter table PERA_DDH_TOOL
  add constraint PK_PERA_DDH_TOOL primary key (PK_TOOL_ID);
alter table PERA_DDH_TOOL
  add unique (CODE);
alter table PERA_DDH_TOOL
  add unique (NAME);
alter table PERA_DDH_TOOL
  add constraint FK_TOOL_SCRIPT foreign key (FK_SCRIPT_ID)
  references PERA_DDH_SCRIPT (PK_SCRIPT_ID);
alter table PERA_DDH_TOOL
  add constraint FK_TOOL_TOOLICON foreign key (FK_TOOLICON_ID)
  references PERA_DDH_TOOLICON (PK_TOOLICON_ID);

prompt
prompt Creating table PERA_DDH_CMDLINE_ITEM
prompt ====================================
prompt
create table PERA_DDH_CMDLINE_ITEM
(
  PK_COMMANDLINEITEM_ID NUMBER(19) not null,
  LINE_INDEX            NUMBER(5) not null,
  TYPE                  VARCHAR2(16),
  VALUE                 VARCHAR2(256),
  FK_TOOL_ID            NUMBER(19),
  VERSION               NUMBER(10) not null
)
;
alter table PERA_DDH_CMDLINE_ITEM
  add constraint PK_PERA_DDH_CMDLINE_ITEM primary key (PK_COMMANDLINEITEM_ID);
alter table PERA_DDH_CMDLINE_ITEM
  add constraint FK_CMDLINE_ITEM_TOOL foreign key (FK_TOOL_ID)
  references PERA_DDH_TOOL (PK_TOOL_ID);

prompt
prompt Creating table PERA_DDH_CONFIG
prompt ==============================
prompt
create table PERA_DDH_CONFIG
(
  PK_CONFIG_ID NUMBER(19) not null,
  NAME         VARCHAR2(64),
  VALUE        VARCHAR2(256),
  EXTITEM      VARCHAR2(256),
  DESCRIPTION  VARCHAR2(2048),
  VERSION      NUMBER(10) not null
)
;
alter table PERA_DDH_CONFIG
  add constraint PK_PERA_DDH_CONFIG primary key (PK_CONFIG_ID);

prompt
prompt Creating table PERA_DDH_DEPLOYMENTVAR
prompt =====================================
prompt
create table PERA_DDH_DEPLOYMENTVAR
(
  PK_DEPLOYMENTVAR_ID NUMBER(19) not null,
  NAME                VARCHAR2(64),
  DESCRIPTION         VARCHAR2(2048),
  FK_TOOL_ID          NUMBER(19),
  VERSION             NUMBER(10) not null
)
;
alter table PERA_DDH_DEPLOYMENTVAR
  add constraint PK_PERA_DDH_DEPLOYMENTVAR primary key (PK_DEPLOYMENTVAR_ID);
alter table PERA_DDH_DEPLOYMENTVAR
  add constraint FK_DEPLOYMENTVAR_TOOL foreign key (FK_TOOL_ID)
  references PERA_DDH_TOOL (PK_TOOL_ID);

prompt
prompt Creating table PERA_DDH_FILETYPE
prompt ================================
prompt
create table PERA_DDH_FILETYPE
(
  PK_FILETYPE_ID NUMBER(19) not null,
  NAME           VARCHAR2(128),
  FILEEXTENSION  VARCHAR2(32),
  DESCRIPTION    VARCHAR2(2048),
  VERSION        NUMBER(10) not null,
  MAINEXTENSION  VARCHAR2(32)
)
;
alter table PERA_DDH_FILETYPE
  add constraint PK_PERA_DDH_FILETYPE primary key (PK_FILETYPE_ID);

prompt
prompt Creating table PERA_DDH_FILETYPEMETADATA
prompt ========================================
prompt
create table PERA_DDH_FILETYPEMETADATA
(
  PK_FILETYPEMETADATA_ID NUMBER(19) not null,
  FK_FILETYPE_ID         NUMBER(19),
  NAME                   VARCHAR2(128),
  METADATATYPE           VARCHAR2(32),
  REMARK                 VARCHAR2(2048),
  VERSION                NUMBER(10) not null
)
;
alter table PERA_DDH_FILETYPEMETADATA
  add constraint PK_PERA_DDH_FILETYPEMETADATA primary key (PK_FILETYPEMETADATA_ID);
alter table PERA_DDH_FILETYPEMETADATA
  add constraint FK_FILETYPEMETADATA_FILETYPE foreign key (FK_FILETYPE_ID)
  references PERA_DDH_FILETYPE (PK_FILETYPE_ID);

prompt
prompt Creating table PERA_DDH_TOOL_FILETYPE
prompt =====================================
prompt
create table PERA_DDH_TOOL_FILETYPE
(
  TOOL_ID     NUMBER(19) not null,
  FILETYPE_ID NUMBER(19) not null
)
;
alter table PERA_DDH_TOOL_FILETYPE
  add constraint FK_TOOL_FILETYPE_F_FILETYPE foreign key (FILETYPE_ID)
  references PERA_DDH_FILETYPE (PK_FILETYPE_ID);
alter table PERA_DDH_TOOL_FILETYPE
  add constraint FK_TOOL_FILETYPE_F_TOOL foreign key (TOOL_ID)
  references PERA_DDH_TOOL (PK_TOOL_ID);


spool off
