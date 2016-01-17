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
	int ReplaceOne(const char * pszKey,int iStart,const char * pszNewValue); // 返回新的起始位置
	string GetSubStr(int iPos,int iCount);
	bool GetRcContent();
	bool WriteRcNew();
	int SeekToKeyValuePos(int &iPos); // 定位到字段值,并返回值的字符串长度,修改当前位置为字段值的起始位置
	std::string m_strRcFile;
	std::string m_strSourceRcContent;
	std::string m_strDestRcContent;
	FILE * m_pFile;
};

#endif // #HEADER_H