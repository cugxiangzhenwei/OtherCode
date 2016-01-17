#include "Update.h"
#include <time.h>
CRcUpdate::CRcUpdate(const char * pszRcFile)
{
	if (NULL == pszRcFile)
	{
		m_strRcFile = "";
	}
	else
		m_strRcFile = pszRcFile;

	m_pFile = NULL;
	m_strSourceRcContent = "";
	m_strDestRcContent   = "";
}
CRcUpdate::~CRcUpdate()
{
	if (m_pFile)
	{
		fclose(m_pFile);
		m_pFile = NULL;
	}
}
bool CRcUpdate::GetRcContent()
{
	if (m_strRcFile != "")
		fopen_s(&m_pFile,m_strRcFile.c_str(),"rb"); // ��ֻ����ʽ���ļ�

	if (m_pFile==NULL)
	{
		printf("���ļ�[%s]ʧ��...\n",m_strRcFile.c_str());
		return false;
	}

	fseek(m_pFile,0,SEEK_END);
	int iFileSize = ftell(m_pFile);
	char * pBuf = new char[iFileSize+1];
	memset(pBuf,0,sizeof(char)*(iFileSize+1));
	fseek(m_pFile,0,SEEK_SET);
	size_t iRead = fread_s(pBuf,iFileSize,sizeof(char),iFileSize,m_pFile);
	fclose(m_pFile); // ����֮��ر��ļ�
	m_pFile = NULL;
	if (iRead != iFileSize)
	{
		delete pBuf;
		printf("��ȡ�ļ����ݳ���...\n");
		return false;
	}

	pBuf[iFileSize] = 0;
	m_strSourceRcContent = pBuf;
	delete pBuf;
	return true;
}
bool CRcUpdate::WriteRcNew()
{
	if (m_strRcFile != "")
		fopen_s(&m_pFile,m_strRcFile.c_str(),"wb"); // ��ֻ����ʽ���ļ�

	fseek(m_pFile,0,SEEK_SET);
	size_t iLength = m_strDestRcContent.length();
	size_t iWritten = fwrite(m_strDestRcContent.c_str(),1,iLength,m_pFile);
	if (iLength!=iWritten)
	{
		printf("д���µ��ı�ʧ��...\n");
		return false;
	}

	fclose(m_pFile);
	m_pFile = NULL;
	return true;
}
int CRcUpdate::SeekToKeyValuePos(int &iPos)
{
	const char * pszKey = m_strSourceRcContent.c_str() + iPos;
	if (m_strSourceRcContent.empty())
		return 0;

	while(m_strSourceRcContent[iPos]==' ')
	   iPos++;

	const char *pszValueStar = m_strSourceRcContent.c_str() + iPos;
	int iEnd = iPos + 1;
	while(m_strSourceRcContent[iEnd] != '\n')
	   iEnd++;

	const char * pszValue = m_strSourceRcContent.c_str() + iPos;
	return iEnd - iPos;
}
string CRcUpdate::GetSubStr(int iPos,int iCount)
{
	return string (m_strSourceRcContent.c_str() + iPos,iCount);
}
int CRcUpdate::ReplaceOne(const char * pszKey,int iStart,const char * pszNewValue) // �����µ���ʼλ��
{
	int iKeyLength = strlen(pszKey);
	int iPosFind = m_strSourceRcContent.find(pszKey,iStart,iKeyLength);
	if (iPosFind == string::npos)
		return string::npos;

	iPosFind +=iKeyLength+1; 
	int iValueLen = SeekToKeyValuePos(iPosFind); // ��ȡ�ֶ�ֵ����ʵλ�ú��ֶ�ֵ�ַ�����
	int iPosReplace = iPosFind;
	if (iStart != 0)
	{
		string strOld = GetSubStr(iPosFind,iValueLen);//��ȡԭʼֵ
		iPosReplace = m_strDestRcContent.find(strOld.c_str()); // �ڸ��¹����ַ����в���λ��
	}
	
	m_strDestRcContent = m_strDestRcContent.replace(iPosReplace,iValueLen,pszNewValue); // �滻 FILEVERSION ֵ
	return iPosFind + iValueLen;
}
bool CRcUpdate::UpdateRc(int iMajorVersion)
{
	if (!GetRcContent())
		return false;

	m_strDestRcContent = m_strSourceRcContent;

	time_t  t = time(NULL);
	struct tm ct;
	localtime_s(&ct,&t);

	char szVesionInfo[30] ={0}; // ��ȡ FILEVERSION_VALUE �� PRODUCT_VERSION_VALUE (�ַ���)
	sprintf_s(szVesionInfo,"\"%d.%04d.%02d%02d.%02d%02d\"",iMajorVersion,1900 + ct.tm_year,
		1 + ct.tm_mon,ct.tm_mday,ct.tm_hour,ct.tm_min);

	char szFILEVERSION[30] = {0}; // ��ȡ FILEVERSION �� PRODUCTVERSION (���ִ�)
	sprintf_s(szFILEVERSION,"%d ,%04d , %02d%02d , %02d%02d"
		,iMajorVersion,
		1900 + ct.tm_year,
		1 + ct.tm_mon,ct.tm_mday,
		ct.tm_hour,ct.tm_min);

	char szCopyRight[500] = {0};
	sprintf_s(szCopyRight,"\"Copyright(C) %04d PeraGlobal Inc. All rights reserved.\"",1900 + ct.tm_year);

	int iNewStart = 0;
	iNewStart = ReplaceOne(FILEVERSION,iNewStart,szFILEVERSION);
	iNewStart = ReplaceOne(PRODUCTVERSION,iNewStart,szFILEVERSION);
	iNewStart = ReplaceOne(COMPANY_VALUE,iNewStart,"\"PeraGlobal Inc.\"");
	iNewStart = ReplaceOne(FILEVERSION_VALUE,iNewStart,szVesionInfo);
	iNewStart = ReplaceOne(COPY_RIGHT_VALUE,iNewStart,szCopyRight);
	iNewStart = ReplaceOne(PRODUCT_VERSION_VALUE,iNewStart,szVesionInfo);
	return WriteRcNew();
}