
// HookCookieTest.h : HookCookieTest Ӧ�ó������ͷ�ļ�
//
#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"       // ������

// CHookCookieTestApp:
// �йش����ʵ�֣������ HookCookieTest.cpp
//

class CHookCookieTestApp : public CWinApp
{
public:
	CHookCookieTestApp();


// ��д
public:
	virtual BOOL InitInstance();
	virtual int ExitInstance();

// ʵ��
	afx_msg void OnAppAbout();
	DECLARE_MESSAGE_MAP()
};

extern CHookCookieTestApp theApp;
