
#ifndef _ZTOOLS_TOOLS_H_
#define _ZTOOLS_TOOLS_H_

#include <stdarg.h>
#include <string>
#include <vector>
#include <cassert>
#include <iostream>
#include <cctype>
#include <algorithm>

#define _ZTOOLS_LOG4_ 1
#ifdef _ZTOOLS_LOG4_
#define LOG4CPLUS_DISABLE_DLL_RUNTIME_WARNING
////////////////////////////////////////��־ͷ�ļ����궨��
#include <log4cplus/logger.h>
#include <log4cplus/fileappender.h>
#include <log4cplus/layout.h>
#include <log4cplus/ndc.h>
#include <log4cplus/helpers/loglog.h>
#include <log4cplus/loggingmacros.h>

using namespace log4cplus;

#ifdef _DEBUG
#pragma comment(lib, "log4cplusSD.lib")
#else
#pragma comment(lib, "log4cplusS.lib")
#endif
/////////////////////////////////////////��־ͷ�ļ����궨��
static bool s_bLogInit = false;
#endif

namespace ZTools
{

	//UTF8ת���ֽڣ��������ֶ��ͷ�pmb
	bool UTF8ToMB(char*& pmb, const char* pu8);
	//���ֽ�תUTF8���������ֶ��ͷ�pu8
	bool MBToUTF8(char*& pu8, const char* pmb);

	//UTF8ת���ֽ�
	std::string& UTF8ToMB(std::string& str);
	//���ֽ�תUTF8
	std::string& MBToUTF8(std::string& str);

	std::string hexencode(const std::string& input);

	//��ʽ���ַ���
	std::string FormatString(const char *fmt, ...);
	//��ʽ���ַ���
	std::string& FormatString(std::string& strResult, const char *fmt, ...);
	//�ַ�����д
	std::string& UpperString(std::string& str);
	//�ַ���Сд
	std::string& LowerString(std::string& str);
	std::wstring s2ws(const std::string& s);
	std::string ws2s(const std::wstring& ws);

	//����ת�ַ���
	template <class T> 
	std::string ConvertToString(T value);
	//�ַ���ת����
	template <class T> 
	void convertFromString(T &value, const std::string &s);
	void split(std::string& s, std::string& delim, std::vector< std::string >* ret);
	DISPID FindId(IDispatch *pObj, LPOLESTR pName);
	HRESULT InvokeMethod(IDispatch *pObj, LPOLESTR pName, VARIANT *pVarResult, VARIANT *p, int cArgs);
	HRESULT GetProperty(IDispatch *pObj, LPOLESTR pName, VARIANT *pValue);
	HRESULT SetProperty(IDispatch *pObj, LPOLESTR pName, VARIANT *pValue);

	//��־
	void InitZToolsLog(const std::string strLogFileName = "", const std::string strModuleName = "");
	void WriteZToolsLog(const std::string &LogMessage, int LogLevel = 0/*TRACE_LOG_LEVEL*/);
	void WriteZToolsFormatLog(const char *fmt, ...);
	//��ǰ·��
	std::string GetCurrentModulePath(std::string strModule = "");
	std::string GetNowTimeStr();
	//��ǰʱ�����ɵ�һ��ʮ�����ƴ�
	std::string GetCurrentTimeString16();
	//ȡϵͳ�����Ӧ���ַ�������
	std::string GetLastErrorMessageString(DWORD dwError = 0);
}
#endif /*_ZTOOLS_TOOLS_H_*/