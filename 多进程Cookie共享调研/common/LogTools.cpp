#include "StdAfx.h"
#include "LogTools.h"
#include <imagehlp.h>

namespace LogTools
{
	void InitZToolsLog(const std::string & strLogFileName/* = ""*/, const std::string strModuleName/* = ""*/)
	{
#ifdef _ZTOOLS_LOG4_
		if (s_bLogInit)
		{
			return;
		}
		s_bLogInit = true;

		std::string strLogFilePath;

		char drive[_MAX_DRIVE];
		char dir[_MAX_DIR];
		char fname[_MAX_FNAME];
		char ext[_MAX_EXT];
		char exeFullPath[MAX_PATH]; // MAX_PATH
		HMODULE hMod = NULL;
		hMod = GetModuleHandle(strModuleName.c_str());
		GetModuleFileName(hMod, exeFullPath, MAX_PATH);//�õ�����ģ�����ƣ�ȫ·��
		_splitpath_s( exeFullPath, drive, dir, fname, ext );

		if (strLogFileName.empty())
		{
			CString str;
			str.Format("%s%sLogZTools\\LogZTools_%s.log", drive, dir, fname);
			strLogFilePath = str;
		}
		else if (strLogFileName.find('.') == std::string::npos)
		{
			CString str;
			str.Format("%s%sLogZTools\\LogZTools_%s.log", drive, dir, strLogFileName.c_str());
			strLogFilePath = str;
		}
		else
		{
			CString str;
			str.Format("%s%sLogZTools\\%s", drive, dir, strLogFileName.c_str());
			strLogFilePath = str;
		}

		MakeSureDirectoryPathExists(strLogFilePath.c_str());

		//log4cplus::initialize();
		helpers::LogLog::getLogLog()->setInternalDebugging(false);
		SharedAppenderPtr _appendPtr(new RollingFileAppender(LOG4CPLUS_TEXT(strLogFilePath), 2000*1024, 5));  
		std::string strPattern;  
		//strPattern = "%D{%Y-%m-%d %H:%M:%S.%q}  - %m [%l]%n";//������������е�������
		strPattern = "%D{%Y-%m-%d %H:%M:%S.%q}  - %m%n";
		_appendPtr->setName(LOG4CPLUS_TEXT("First"));
		_appendPtr->setLayout( std::auto_ptr<Layout>(new PatternLayout(strPattern))); 

		Logger::getRoot().addAppender(_appendPtr); 

		Logger root = Logger::getRoot();
		Logger test = Logger::getInstance(LOG4CPLUS_TEXT("test"));
		Logger subTest = Logger::getInstance(LOG4CPLUS_TEXT("test.subtest"));
		subTest.setLogLevel(0);
#endif

	}

	void WriteZToolsFormatLog(const char *fmt, ...)
	{
#ifdef _ZTOOLS_LOG4_
		std::string strResult="";
		if (NULL != fmt)
		{
			va_list marker = NULL;            
			va_start(marker, fmt);                            //��ʼ����������
			size_t nLength = _vscprintf(fmt, marker) + 1;    //��ȡ��ʽ���ַ�������
			std::vector<char> vBuffer(nLength, '\0');        //�������ڴ洢��ʽ���ַ������ַ�����
			int nWritten = _vsnprintf_s(&vBuffer[0], vBuffer.size(), nLength, fmt, marker);
			if (nWritten>0)
			{
				strResult = &vBuffer[0];
			}            
			va_end(marker);                                    //���ñ�������
		}
		WriteZToolsLog(strResult);
#endif
	}

	void WriteZToolsLog( const std::string &LogMessage, int LogLevel /*= 0/*TRACE_LOG_LEVEL*/ )
	{

#ifdef USE_DLGLOG
		CPeraWorkspaceApp* pApp = (CPeraWorkspaceApp*)AfxGetApp();
		if(pApp && pApp->m_dlgLog.GetSafeHwnd())
		{
			pApp->m_dlgLog.SendMessage(WM_LOG, (WPARAM)new CString(LogMessage.c_str()));
		}
#endif // USE_DLGLOG


#ifdef _ZTOOLS_LOG4_
		InitZToolsLog();
		Logger root = Logger::getRoot();
		Logger test = Logger::getInstance(LOG4CPLUS_TEXT("test"));
		Logger subTest = Logger::getInstance(LOG4CPLUS_TEXT("test.subtest"));

		switch(LogLevel)
		{
		case NOT_SET_LOG_LEVEL:
			break;
		case TRACE_LOG_LEVEL:
			LOG4CPLUS_TRACE(subTest, LogMessage);
			break;
		case DEBUG_LOG_LEVEL:
			LOG4CPLUS_DEBUG(subTest, LogMessage);
			break;
		case INFO_LOG_LEVEL:
			LOG4CPLUS_INFO(subTest, LogMessage);
			break;
		case ERROR_LOG_LEVEL:
			LOG4CPLUS_ERROR(subTest, LogMessage);
			break;
		case FATAL_LOG_LEVEL:
			LOG4CPLUS_FATAL(subTest, LogMessage);
			break;
		default:
			break;
		}
#endif
	}
}