
// HookCookieTestView.cpp : CHookCookieTestView ���ʵ��
//

#include "stdafx.h"
// SHARED_HANDLERS ������ʵ��Ԥ��������ͼ������ɸѡ�������
// ATL ��Ŀ�н��ж��壬�����������Ŀ�����ĵ����롣
#ifndef SHARED_HANDLERS
#include "HookCookieTest.h"
#endif

#include "HookCookieTestDoc.h"
#include "HookCookieTestView.h"
#include "MainFrm.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CHookCookieTestView

IMPLEMENT_DYNCREATE(CHookCookieTestView, CHtmlView)

BEGIN_MESSAGE_MAP(CHookCookieTestView, CHtmlView)
	// ��׼��ӡ����
	ON_COMMAND(ID_FILE_PRINT, &CHtmlView::OnFilePrint)
	ON_COMMAND(ID_REFRESH, &CHookCookieTestView::OnRefresh)
END_MESSAGE_MAP()

// CHookCookieTestView ����/����

CHookCookieTestView::CHookCookieTestView()
{
	// TODO: �ڴ˴���ӹ������

}

CHookCookieTestView::~CHookCookieTestView()
{
}

BOOL CHookCookieTestView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: �ڴ˴�ͨ���޸�
	//  CREATESTRUCT cs ���޸Ĵ��������ʽ

	return CHtmlView::PreCreateWindow(cs);
}

void CHookCookieTestView::OnInitialUpdate()
{
	CHtmlView::OnInitialUpdate();
	SetSilent(TRUE);
	//char *szURL = "http://192.168.50.165/portal/erm/portal/index";
	char *szURL = "http://www.jd.com";
	//char *szURL = "http://www.taobao.com/";
	//char *szURL = "about:blank";
	Navigate2(szURL,NULL,NULL);
}


// CHookCookieTestView ��ӡ



// CHookCookieTestView ���

#ifdef _DEBUG
void CHookCookieTestView::AssertValid() const
{
	CHtmlView::AssertValid();
}

void CHookCookieTestView::Dump(CDumpContext& dc) const
{
	CHtmlView::Dump(dc);
}

CHookCookieTestDoc* CHookCookieTestView::GetDocument() const // �ǵ��԰汾��������
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CHookCookieTestDoc)));
	return (CHookCookieTestDoc*)m_pDocument;
}
#endif //_DEBUG


// CHookCookieTestView ��Ϣ�������


void CHookCookieTestView::OnRefresh()
{
	// TODO: �ڴ���������������
	Refresh();
}


void CHookCookieTestView::OnNavigateComplete2(LPCTSTR strURL)
{
	// TODO: �ڴ����ר�ô����/����û���
	if (strcmp(strURL, "about:blank"))
	{
		CMainFrame *pFrameWnd = dynamic_cast<CMainFrame*>(GetParentFrame());
		if (pFrameWnd)
			pFrameWnd->m_editUrlAddress.SetWindowText(strURL);
	}
	CHtmlView::OnNavigateComplete2(strURL);
}
