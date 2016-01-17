#include <time.h>
#include <stdio.h>
#include <string>
using namespace std;

void PrintHelp()
{
	printf("ʹ�÷�����VesionCreateTool.exe MajorVersionNumber outfile\nʾ����VesionCreateTool.exe 1 C:\\version.h");
}
int main(int argc,char **argv)
{
	if (argc < 3)
	{
		PrintHelp();
		return -1;
	}
	int MajorVesion = atoi(argv[1]);
	string strVesionFile = argv[2];
	
	time_t  t = time(NULL);
	struct tm ct;
	localtime_s(&ct,&t);

	char szVesionInfo[20] ={0};
	sprintf_s(szVesionInfo,"%d.%04d.%02d%02d.%02d%02d",MajorVesion,1900 + ct.tm_year,
		1 + ct.tm_mon,ct.tm_mday,ct.tm_hour,ct.tm_min);

	printf(szVesionInfo);
	FILE *pFile = NULL;
	fopen_s(&pFile,strVesionFile.c_str(),"w");
	if (pFile==NULL)
	{
		printf("�����ļ�[%s]ʧ��\n",strVesionFile.c_str());
		return -2;
	}

	// ע����Ϣ
	fprintf_s(pFile,"//This file is created by VesionCreateTool,%s\n",__TIME__""__DATE__);

	//�汾�ַ���
	fprintf_s(pFile,"#define PRODUCT_VERSION \"%s\"\n",szVesionInfo);
	fprintf_s(pFile,"#define FILE_VERSION \"%s\"\n",szVesionInfo);

	//д�ļ��汾��
	fprintf_s(pFile,"#define FILE_Major_Version_Number %d\n",MajorVesion);
	fprintf_s(pFile,"#define FILE_Minor_Version_Number %04d\n",ct.tm_year + 1900);
	fprintf_s(pFile,"#define FILE_Build_Number %02d%02d\n",1 + ct.tm_mon,ct.tm_mday);
	fprintf_s(pFile,"#define FILE_Revision_Number %02d%02d\n",ct.tm_hour,ct.tm_min);

	// д��Ʒ�汾��
	fprintf_s(pFile,"#define PRODUCT_Major_Version_Number %d\n",MajorVesion);
	fprintf_s(pFile,"#define PRODUCT_Minor_Version_Number %04d\n",ct.tm_year + 1900);
	fprintf_s(pFile,"#define PRODUCT_Build_Number %02d%02d\n",1 + ct.tm_mon,ct.tm_mday);
	fprintf_s(pFile,"#define PRODUCT_Revision_Number %02d%02d\n",ct.tm_hour,ct.tm_min);

	// ��˾����
	fprintf_s(pFile,"#define COMPANY_NAME \"%s\"\n","PeraGlobal");

	//��Ȩ
	fprintf_s(pFile,"#define COPY_RIGHT \"Copyright(C) %4d %s\"\n",ct.tm_year + 1900,"PeraGlobal Inc. All rights reserved.");

	printf("\n���°汾�ļ��ɹ�!\n");
	return 0;
}