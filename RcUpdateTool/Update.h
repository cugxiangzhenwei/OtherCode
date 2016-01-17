#ifndef HEADER_H
#define HEADER_H
#include <vector>
#include <string>
#include <algorithm>
#include <map>
#include <stdio.h>
using namespace std;

#define  FILEVERSION			"FILEVERSION"
#define  PRODUCTVERSION			"PRODUCTVERSION"
#define  COMPANY_VALUE			"VALUE \"CompanyName\","
#define  FILEVERSION_VALUE		"VALUE \"FileVersion\","
#define  COPY_RIGHT_VALUE		"VALUE \"LegalCopyright\","
#define  PRODUCT_VERSION_VALUE  "VALUE \"ProductVersion\","

class CRcUpdate
{
public:
	CRcUpdate(const char * pszRcFile);
	~CRcUpdate();
	bool UpdateRc(int iMajorVersion);
private:
	int ReplaceOne(const char * pszKey,int iStart,const char * pszNewValue); // �����µ���ʼλ��
	string GetSubStr(int iPos,int iCount);
	bool GetRcContent();
	bool WriteRcNew();
	int SeekToKeyValuePos(int &iPos); // ��λ���ֶ�ֵ,������ֵ���ַ�������,�޸ĵ�ǰλ��Ϊ�ֶ�ֵ����ʼλ��
	std::string m_strRcFile;
	std::string m_strSourceRcContent;
	std::string m_strDestRcContent;
	FILE * m_pFile;
};

#endif // #HEADER_H