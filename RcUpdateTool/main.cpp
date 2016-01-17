#include "Update.h"
void PrintHelp()
{
	printf("使用方法：RcUpdateTool.exe MajorVersionNumber rcFile \n示例：RcUpdateTool.exe 1 C:\\TestApp.rc");
}
int main(int argc,char**argv)
{
	if (argc !=3)
	{
		PrintHelp();
		return 0;
	}
	int iMajorVer = atoi(argv[1]);
	CRcUpdate upRc(argv[2]);
	if (upRc.UpdateRc(iMajorVer))
	{
		printf("更新rc文件[%s]成功!\n",argv[2]);
	}
	return 0;
}