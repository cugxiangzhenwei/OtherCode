
// CookieUser.h : CookieUser Ӧ�ó������ͷ�ļ�
//
#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"       // ������


// CCookieUserApp:
// �йش����ʵ�֣������ CookieUser.cpp
//

class CCookieUserApp : public CWinApp
{
public:
	CCookieUserApp();


// ��д
public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();

// ʵ��
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CCookieUserApp theApp;
