
// PeraSqlTool.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CPeraSqlToolApp:
// �йش����ʵ�֣������ PeraSqlTool.cpp
//

class CPeraSqlToolApp : public CWinApp
{
public:
	CPeraSqlToolApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CPeraSqlToolApp theApp;