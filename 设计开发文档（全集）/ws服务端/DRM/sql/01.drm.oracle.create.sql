/*==============================================================*/
/* DBMS name:      ORACLE Version 9i                            */
/* Created on:     2013-11-15 10:09:17                          */
/*==============================================================*/


alter table DRM_COMMAND
   drop constraint FK_DRM_CMD_REF_JOB;

alter table DRM_JOB_REQ
   drop constraint FK_DRM_REQ_REF_JOB;

alter table DRM_JOB_REQ
   drop constraint FK_DRM_REQ_REF_SOFT;

alter table DRM_NODE_RES
   drop constraint FK_DRM_RES_REF_SOFT;

alter table DRM_NODE_RES
   drop constraint FK_DRM_RES_REF_NODE;

alter table DRM_REMOTEJOB
   drop constraint FK_DRM_JOB_REF_TASK;

alter table DRM_TRANSITION
   drop constraint FK_DRM_TRAN_FROM_REF_JOB;

alter table DRM_TRANSITION
   drop constraint FK_DRM_TRAN_TO_REF_JOB;

alter table DRM_VARIABLE
   drop constraint FK_DRM_VAR_REF_CMD;

drop index INDEX_COMMAND_CPTASKID;

drop table DRM_COMMAND cascade constraints;

drop index INDEX_COMPUTETASK_STARTTIME;

drop index INDEX_COMPUTETASK_PRIORITY;

drop index INDEX_COMPUTETASK_BIZKEY;

drop table DRM_COMPUTETASK cascade constraints;

drop index INDEX_CONFIG_NAME;

drop table DRM_CONFIG cascade constraints;

drop index "Index_COMMAND_REQ_SOFTWAREID";

drop index "Index_COMMAND_REQ_COMMANDID";

drop table DRM_JOB_REQ cascade constraints;

drop index "Index_LOG_BIZKEY";

drop index "Index_LOG_OPTTIME";

drop table DRM_LOG cascade constraints;

drop index "Index_NODE_PRIORITY";

drop index "Index_NODE_NODENAME";

drop table DRM_NODE cascade constraints;

drop index "Index_NODE_RES_SOFTWAREID";

drop index "Index_NODE_RES_NODEID";

drop table DRM_NODE_RES cascade constraints;

drop index "Index_REMOTEJOB_TASKID";

drop index "Index_REMOTEJOB_TASKINSTANCEID";

drop index "Index_REMOTEJOB_STARTTIME";

drop table DRM_REMOTEJOB cascade constraints;

drop table DRM_REPORT_OPTTIME cascade constraints;

drop index INDEX_SOFTWARE_IDENTIFY;

drop index "Index_SOFTWARE_SOFTWARE";

drop table DRM_SOFTWARE cascade constraints;

drop index "Index_TRANSITION_TOJOBID";

drop index "Index_TRANSITION_FROMJOBID";

drop table DRM_TRANSITION cascade constraints;

drop index "Index_VARIABLE_VARNAME";

drop index "Index_VARIABLE_VARMODE";

drop index INDEX_VARIABLE_COMPONETID;

drop table DRM_VARIABLE cascade constraints;

drop sequence DRM_SEQUENCE;

create sequence DRM_SEQUENCE
increment by 1
start with 10000
maxvalue 999999999999999999999999999
minvalue 10000
cache 20;

/*==============================================================*/
/* Table: DRM_COMMAND                                           */
/*==============================================================*/
create table DRM_COMMAND  (
   ID                   NUMBER(19)                      not null,
   JOBID                NUMBER(19),
   COMMAND              VARCHAR(500),
   COMMANDTYPE          NUMBER(10),
   INTPCOMMAND          VARCHAR(100),
   INTPARGUMENT         VARCHAR(200),
   SCRIPTTEXT           clob,
   SCRIPTARGUMENT       VARCHAR(200),
   RETRIESWITHIN        NUMBER(10),
   MAXRETRIESNUM        NUMBER(10),
   RETRIESDELAY         NUMBER(10),
   LOGOUTPUTSTREAM      NUMBER(1),
   LOGERRORSTREAM       NUMBER(1),
   LOGMAXLINE           NUMBER(10),
   ISNEEDRETURNCODE     NUMBER(1),
   RETURNCODE           VARCHAR(100),
   RETURNPARAM          VARCHAR(100),
   WAITDELAY            NUMBER(10),
   WAITFILE             VARCHAR(200),
   WAITSTRING           VARCHAR(100),
   FAILEDTOES           NUMBER(1),
   FAILEDTOOS           NUMBER(1),
   constraint PK_DRM_COMMAND primary key (ID)
);

/*==============================================================*/
/* Index: INDEX_COMMAND_CPTASKID                                */
/*==============================================================*/
create index INDEX_COMMAND_CPTASKID on DRM_COMMAND (
   JOBID ASC
);

/*==============================================================*/
/* Table: DRM_COMPUTETASK                                       */
/*==============================================================*/
create table DRM_COMPUTETASK  (
   ID                   NUMBER(19)                      not null,
   BIZKEY               VARCHAR(100)                    not null,
   TASKNAME             VARCHAR(100),
   PRIORITY             NUMBER(10)                      not null,
   BOTSVN               VARCHAR(200),
   TASKDESC             VARCHAR(200),
   TASKSUBMITER         VARCHAR(200),
   STARTTIME            DATE                            not null,
   ENDTIME              DATE,
   ASSIGNNODE           VARCHAR(200),
   TASKINFO             VARCHAR(200),
   PROCESSNAME          VARCHAR(200),
   ISFORM               NUMBER(19),
   MANIFESTSVN          CLOB,
   INPUTSVN             CLOB,
   constraint PK_DRM_COMPUTETASK primary key (ID)
);

/*==============================================================*/
/* Index: INDEX_COMPUTETASK_BIZKEY                              */
/*==============================================================*/
create index INDEX_COMPUTETASK_BIZKEY on DRM_COMPUTETASK (
   BIZKEY ASC
);

/*==============================================================*/
/* Index: INDEX_COMPUTETASK_PRIORITY                            */
/*==============================================================*/
create index INDEX_COMPUTETASK_PRIORITY on DRM_COMPUTETASK (
   PRIORITY ASC
);

/*==============================================================*/
/* Index: INDEX_COMPUTETASK_STARTTIME                           */
/*==============================================================*/
create index INDEX_COMPUTETASK_STARTTIME on DRM_COMPUTETASK (
   STARTTIME DESC
);

/*==============================================================*/
/* Table: DRM_CONFIG                                            */
/*==============================================================*/
create table DRM_CONFIG  (
   ID                   NUMBER(19)                      not null,
   NAME                 VARCHAR2(200),
   VAL                  VARCHAR2(100),
   constraint PK_DRM_CONFIG primary key (ID)
);

/*==============================================================*/
/* Index: INDEX_CONFIG_NAME                                     */
/*==============================================================*/
create unique index INDEX_CONFIG_NAME on DRM_CONFIG (
   NAME ASC
);

/*==============================================================*/
/* Table: DRM_JOB_REQ                                           */
/*==============================================================*/
create table DRM_JOB_REQ  (
   ID                   NUMBER(19)                      not null,
   JOBID                NUMBER(19)                      not null,
   ISSCRIPT             NUMBER(10),
   RTOS                 VARCHAR(10),
   SOFTWAREID           NUMBER(19),
   constraint PK_DRM_JOB_REQ primary key (ID)
);

/*==============================================================*/
/* Index: "Index_COMMAND_REQ_COMMANDID"                         */
/*==============================================================*/
create index "Index_COMMAND_REQ_COMMANDID" on DRM_JOB_REQ (
   JOBID ASC
);

/*==============================================================*/
/* Index: "Index_COMMAND_REQ_SOFTWAREID"                        */
/*==============================================================*/
create index "Index_COMMAND_REQ_SOFTWAREID" on DRM_JOB_REQ (
   SOFTWAREID ASC
);

/*==============================================================*/
/* Table: DRM_LOG                                               */
/*==============================================================*/
create table DRM_LOG  (
   ID                   NUMBER(19)                      not null,
   OPERATOR             VARCHAR2(100),
   OPTTIME              TIMESTAMP,
   ACTIONDESC           VARCHAR2(500),
   JOBID                NUMBER(19),
   BIZKEY               VARCHAR2(100),
   constraint PK_DRM_LOG primary key (ID)
);

/*==============================================================*/
/* Index: "Index_LOG_OPTTIME"                                   */
/*==============================================================*/
create index "Index_LOG_OPTTIME" on DRM_LOG (
   OPTTIME ASC
);

/*==============================================================*/
/* Index: "Index_LOG_BIZKEY"                                    */
/*==============================================================*/
create index "Index_LOG_BIZKEY" on DRM_LOG (
   BIZKEY ASC
);

/*==============================================================*/
/* Table: DRM_NODE                                              */
/*==============================================================*/
create table DRM_NODE  (
   ID                   NUMBER(19)                      not null,
   NODENAME             VARCHAR2(100)                   not null,
   PRIORITY             NUMBER(10),
   ENABLED              NUMBER(1),
   WORKSTATE            NUMBER(10),
   IPADDRESS            VARCHAR2(100),
   CPU                  VARCHAR2(100),
   MEMORY               VARCHAR2(100),
   CONNECTTIME          DATE,
   LASTLIVETIME         DATE,
   CONCURRENTJOBS       NUMBER(10),
   HEARTSERVER          VARCHAR2(100),
   MAXCONCURRENTJOBS    NUMBER(10),
   RTOS                 VARCHAR2(100),
   constraint PK_DRM_NODE primary key (ID)
);

/*==============================================================*/
/* Index: "Index_NODE_NODENAME"                                 */
/*==============================================================*/
create unique index "Index_NODE_NODENAME" on DRM_NODE (
   NODENAME ASC
);

/*==============================================================*/
/* Index: "Index_NODE_PRIORITY"                                 */
/*==============================================================*/
create index "Index_NODE_PRIORITY" on DRM_NODE (
   PRIORITY DESC
);

/*==============================================================*/
/* Table: DRM_NODE_RES                                          */
/*==============================================================*/
create table DRM_NODE_RES  (
   ID                   NUMBER(19)                      not null,
   NODEID               NUMBER(19)                      not null,
   SOFTWAREID           NUMBER(19)                      not null,
   ENABLED              NUMBER(1)                       not null,
   constraint PK_DRM_NODE_RES primary key (ID)
);

/*==============================================================*/
/* Index: "Index_NODE_RES_NODEID"                               */
/*==============================================================*/
create index "Index_NODE_RES_NODEID" on DRM_NODE_RES (
   NODEID ASC
);

/*==============================================================*/
/* Index: "Index_NODE_RES_SOFTWAREID"                           */
/*==============================================================*/
create index "Index_NODE_RES_SOFTWAREID" on DRM_NODE_RES (
   SOFTWAREID ASC
);

/*==============================================================*/
/* Table: DRM_REMOTEJOB                                         */
/*==============================================================*/
create table DRM_REMOTEJOB  (
   ID                   NUMBER(19)                      not null,
   TASKID               NUMBER(19),
   BIZKEY               VARCHAR(100)                    not null,
   PRIORITY             NUMBER(10)                      not null,
   JOBNAME              VARCHAR2(100),
   STATUS               NUMBER(10),
   COMPLETECODE         NUMBER(10),
   COMPONENTCLASS       VARCHAR2(100),
   STARTTIME            DATE,
   ENDTIME              DATE,
   NODENAME             VARCHAR2(100),
   ERRORMESSAGE         VARCHAR(1000),
   ESTIMATEDTIME        DATE,
   constraint PK_DRM_REMOTEJOB primary key (ID)
);

/*==============================================================*/
/* Index: "Index_REMOTEJOB_STARTTIME"                           */
/*==============================================================*/
create index "Index_REMOTEJOB_STARTTIME" on DRM_REMOTEJOB (
   STARTTIME DESC
);

/*==============================================================*/
/* Index: "Index_REMOTEJOB_TASKINSTANCEID"                      */
/*==============================================================*/
create index "Index_REMOTEJOB_TASKINSTANCEID" on DRM_REMOTEJOB (
   BIZKEY ASC
);

/*==============================================================*/
/* Index: "Index_REMOTEJOB_TASKID"                              */
/*==============================================================*/
create index "Index_REMOTEJOB_TASKID" on DRM_REMOTEJOB (
   TASKID ASC
);

/*==============================================================*/
/* Table: DRM_REPORT_OPTTIME                                    */
/*==============================================================*/
create table DRM_REPORT_OPTTIME  (
   ID                   NUMBER(19),
   NODENAME             VARCHAR(100),
   SOFTWARE             VARCHAR(100),
   OPTTIME              NUMBER(19)
);

/*==============================================================*/
/* Table: DRM_SOFTWARE                                          */
/*==============================================================*/
create table DRM_SOFTWARE  (
   ID                   NUMBER(19)                      not null,
   IDENTITY             VARCHAR2(100)                   not null,
   SOFTWARE             VARCHAR2(100)                   not null,
   EXEPATH              VARCHAR2(1000),
   SHPATH               VARCHAR2(1000),
   constraint PK_DRM_SOFTWARE primary key (ID)
);

comment on table DRM_SOFTWARE is
'定义远程软件的路径（全局变量），比如 统一封装环境 ，全局变量,不区分操作系统，在客户端应该可配置覆盖';

/*==============================================================*/
/* Index: "Index_SOFTWARE_SOFTWARE"                             */
/*==============================================================*/
create unique index "Index_SOFTWARE_SOFTWARE" on DRM_SOFTWARE (
   SOFTWARE ASC
);

/*==============================================================*/
/* Index: INDEX_SOFTWARE_IDENTIFY                               */
/*==============================================================*/
create unique index INDEX_SOFTWARE_IDENTIFY on DRM_SOFTWARE (
   IDENTITY ASC
);

/*==============================================================*/
/* Table: DRM_TRANSITION                                        */
/*==============================================================*/
create table DRM_TRANSITION  (
   ID                   NUMBER(19)                      not null,
   FROMJOBID            NUMBER(19)                      not null,
   TOJOBID              NUMBER(19)                      not null,
   constraint PK_DRM_TRANSITION primary key (ID)
);

/*==============================================================*/
/* Index: "Index_TRANSITION_FROMJOBID"                          */
/*==============================================================*/
create index "Index_TRANSITION_FROMJOBID" on DRM_TRANSITION (
   FROMJOBID ASC
);

/*==============================================================*/
/* Index: "Index_TRANSITION_TOJOBID"                            */
/*==============================================================*/
create index "Index_TRANSITION_TOJOBID" on DRM_TRANSITION (
   TOJOBID ASC
);

/*==============================================================*/
/* Table: DRM_VARIABLE                                          */
/*==============================================================*/
create table DRM_VARIABLE  (
   ID                   NUMBER(19)                      not null,
   COMMANDID            NUMBER(19)                      not null,
   VARMODE              NUMBER(10)                      not null,
   VARNAME              VARCHAR2(100)                   not null,
   DATATYPE             VARCHAR2(100)                   not null,
   DEFAULTVALUE         VARCHAR2(2000),
   RTVALUE              VARCHAR2(2000),
   ATTRITEMID           VARCHAR2(100),
   constraint PK_DRM_VARIABLE primary key (ID)
);

/*==============================================================*/
/* Index: INDEX_VARIABLE_COMPONETID                             */
/*==============================================================*/
create index INDEX_VARIABLE_COMPONETID on DRM_VARIABLE (
   COMMANDID ASC
);

/*==============================================================*/
/* Index: "Index_VARIABLE_VARMODE"                              */
/*==============================================================*/
create index "Index_VARIABLE_VARMODE" on DRM_VARIABLE (
   VARMODE ASC
);

/*==============================================================*/
/* Index: "Index_VARIABLE_VARNAME"                              */
/*==============================================================*/
create index "Index_VARIABLE_VARNAME" on DRM_VARIABLE (
   VARNAME ASC
);

alter table DRM_COMMAND
   add constraint FK_DRM_CMD_REF_JOB foreign key (JOBID)
      references DRM_REMOTEJOB (ID);

alter table DRM_JOB_REQ
   add constraint FK_DRM_REQ_REF_JOB foreign key (JOBID)
      references DRM_REMOTEJOB (ID);

alter table DRM_JOB_REQ
   add constraint FK_DRM_REQ_REF_SOFT foreign key (SOFTWAREID)
      references DRM_SOFTWARE (ID);

alter table DRM_NODE_RES
   add constraint FK_DRM_RES_REF_SOFT foreign key (SOFTWAREID)
      references DRM_SOFTWARE (ID);

alter table DRM_NODE_RES
   add constraint FK_DRM_RES_REF_NODE foreign key (NODEID)
      references DRM_NODE (ID);

alter table DRM_REMOTEJOB
   add constraint FK_DRM_JOB_REF_TASK foreign key (TASKID)
      references DRM_COMPUTETASK (ID);

alter table DRM_TRANSITION
   add constraint FK_DRM_TRAN_FROM_REF_JOB foreign key (FROMJOBID)
      references DRM_REMOTEJOB (ID);

alter table DRM_TRANSITION
   add constraint FK_DRM_TRAN_TO_REF_JOB foreign key (TOJOBID)
      references DRM_REMOTEJOB (ID);

alter table DRM_VARIABLE
   add constraint FK_DRM_VAR_REF_CMD foreign key (COMMANDID)
      references DRM_COMMAND (ID);

