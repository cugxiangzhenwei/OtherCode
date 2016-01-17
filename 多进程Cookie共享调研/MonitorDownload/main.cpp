#include <stdio.h>
#include <string>
#include <Windows.h>
#include <comutil.h>
using namespace std;
#pragma comment(lib, "comsupp.lib")
void ProOneFile(const wstring & strFile,FILETIME &ftLastWriteTime,const wstring &strDest)
{
	FILETIME localFileTime;
	FileTimeToLocalFileTime(&ftLastWriteTime,&localFileTime);
	SYSTEMTIME  st;
	FileTimeToSystemTime(&localFileTime,&st);

	SYSTEMTIME stNow;
	GetLocalTime(&stNow); 

	int iTimeMinuteDis = (stNow.wDay -  st.wDay)*24*60 + (stNow.wHour -  st.wHour)*60 + (stNow.wMinute -  st.wMinute);
	if (iTimeMinuteDis > 8)
	{
		printf("�ƶ��ļ�:%s\n",(wchar_t*)_bstr_t(strFile.c_str()));
		_wrename(strFile.c_str(),strDest.c_str());
	}
}
void ProOne(const wstring & strSrc,const wstring & strDest)
{
	WCHAR szFind[MAX_PATH] = {L"\0"};
	WIN32_FIND_DATAW findFileData;
	BOOL bRet;

	wcscpy_s(szFind, MAX_PATH, strSrc.c_str());
	wcscat_s(szFind, L"\\*.*");     //����һ��Ҫָ��ͨ�������Ȼ�����ȡ�����ļ���Ŀ¼

	HANDLE hFind = ::FindFirstFileW(szFind, &findFileData);
	if (INVALID_HANDLE_VALUE == hFind)
		return;

	//�����ļ���
	while (TRUE)
	{
		if (findFileData.cFileName[0] != L'.')
		{
			if (findFileData.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
				continue;

			WCHAR szFullPath[MAX_PATH] = {0};
			swprintf_s(szFullPath,L"%s\\%s", strSrc.c_str(), findFileData.cFileName);
			wstring strMoveTo = strDest + wstring(L"\\") + findFileData.cFileName;
			ProOneFile(szFullPath,findFileData.ftLastWriteTime,strMoveTo);
		}
		bRet = ::FindNextFile(hFind, &findFileData);
		if (!bRet)
			break;
	}

	::FindClose(hFind);
}
int main(int argc,char * argv[])
{
	if(argc!=3)
	{
		printf("�������㣬��ָ��ԴĿ¼���ƶ��ļ���Ŀ��·��");
		return 0;
	}

	wstring strSrcDir = (wchar_t*)_bstr_t(argv[1]);
	wstring strDest = (wchar_t*)_bstr_t(argv[2]);
	printf("�������,ԴĿ¼Ϊ��%s\n�ƶ��ļ�Ŀ��Ŀ¼Ϊ��%s",argv[1],argv[2]);
	while(1)
	{
		ProOne(strSrcDir,strDest);
		Sleep(800);
	}
}