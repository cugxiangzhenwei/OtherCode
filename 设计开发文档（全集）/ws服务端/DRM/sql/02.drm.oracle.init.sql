delete from drm_config;
insert into drm_config (id,name,val) values (12000,'agent.concurrent.download','true');
insert into drm_config (id,name,val) values (12001,'agent.concurrent.compExecutor','5');
insert into drm_config (id,name,val) values (12002,'agent.concurrent.enabled.dynamicCpu','true');
insert into drm_config (id,name,val) values (12003,'agent.heartbeat.interval','3');
insert into drm_config (id,name,val) values (12004,'agent.enabled.multiOnNode','true');
insert into drm_config (id,name,val) values (12101,'server.default.pageSize','20');

commit;


delete from drm_software;
insert into drm_software (id,software,identity,exePath,shPath) values (11000,'GRC','GRCRunners','%FREE%/Flexware.Runtime.GRCRunners.exe','');
insert into drm_software (id,software,identity,exePath,shPath) values (11001,'ansys','ansys140','%ANSYS140_DIR%\bin\intel\ansys140.exe','/ansys_inc/v145/ansys/bin/ansy145');
insert into drm_software (id,software,identity,exePath,shPath) values (11002,'java','java','%JAVA_HOME%\bin\java.exe','%JAVA_HOME%/bin/java');
insert into drm_software (id,software,identity,exePath,shPath) values (11003,'abaqus','abaqus','','/usr/simulia/Commands/abaqus');
insert into drm_software (id,software,identity,exePath,shPath) values (11004,'patran','patran','C:\MSC.Software\Patran\2008_r2\bin\patran.exe','');
insert into drm_software (id,software,identity,exePath,shPath) values (11005,'nastran','nastran','C:\MSC.Software\MD_Nastran\bin\mdnastran.exe','/msc/MD_Nastran/20111/bin/mdnast20111');
insert into drm_software (id,software,identity,exePath,shPath) values (11006,'excel','excel','C:\Program Files\Microsoft Office\Office12\EXCEL.EXE','');
insert into drm_software (id,software,identity,exePath,shPath) values (11007,'word','winword','C:\Program Files\Microsoft Office\Office12\WINWORD.EXE','');
insert into drm_software (id,software,identity,exePath,shPath) values (11008,'workbench','RunWB2','C:\Program Files\ANSYS Inc\v140\Framework\bin\Win32\runwb2.exe','');
commit;