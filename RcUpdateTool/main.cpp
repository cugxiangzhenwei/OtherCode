#include "Update.h"
void PrintHelp()
{
	printf("ʹ�÷�����RcUpdateTool.exe MajorVersionNumber rcFile \nʾ����RcUpdateTool.exe 1 C:\\TestApp.rc");
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
		printf("����rc�ļ�[%s]�ɹ�!\n",argv[2]);
	}
	return 0;
}