@echo off
call :WriteVersionInfo 131 D:\version.h
echo 版本信息更新成功!
pause

:WriteVersionInfo
echo //This file is created bat this version.bat %date% %time% >%2
echo #define PRODUCT_VERSION "%1.%date:~0,4%.%date:~5,2%%date:~8,2%.%time:~0,2%%time:~3,2%" >>%2
echo #define FILE_VERSION    "%1.%date:~0,4%.%date:~5,2%%date:~8,2%.%time:~0,2%%time:~3,2%" >>%2
echo #define FILE_Major_Version_Number %1 >>%2
echo #define FILE_Minor_Version_Number %date:~0,4% >>%2
echo #define FILE_Build_Number %date:~5,2%%date:~8,2% >>%2
echo #define FILE_Revision_Number %time:~0,2%%time:~3,2% >>%2
echo #define PRODUCT_Major_Version_Number %1 >>%2
echo #define PRODUCT_Minor_Version_Number %date:~0,4% >>%2
echo #define PRODUCT_Build_Number %date:~5,2%%date:~8,2% >>%2
echo #define PRODUCT_Revision_Number %time:~0,2%%time:~3,2%  >>%2
goto :eof