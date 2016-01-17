
// MainFrm.cpp : CMainFrame ���ʵ��
//

#include "stdafx.h"
#include "CookieUser.h"

#include "CookieUserDoc.h"
#include "CookieUserView.h"
#include "MainFrm.h"
#include "wininet.h"
#include "UsrDefine.h"
#include "KeyCode.h"
#include "StlHeader.h"
#pragma comment(lib,"wininet.lib")


#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CMainFrame

IMPLEMENT_DYNCREATE(CMainFrame, CFrameWnd)

BEGIN_MESSAGE_MAP(CMainFrame, CFrameWnd)
	ON_WM_CREATE()
	ON_WM_COPYDATA()
	ON_WM_DESTROY()
	ON_MESSAGE(WM_CD_GETCOOKIE,CMainFrame::OnMsgSendCookie)
END_MESSAGE_MAP()

static UINT indicators[] =
{
	ID_SEPARATOR,           // ״̬��ָʾ��
	ID_INDICATOR_CAPS,
	ID_INDICATOR_NUM,
	ID_INDICATOR_SCRL,
};

// CMainFrame ����/����

CMainFrame::CMainFrame()
{
	// TODO: �ڴ���ӳ�Ա��ʼ������
}

CMainFrame::~CMainFrame()
{
}

int CMainFrame::OnCreate(LPCREATESTRUCT lpCreateStruct)
{
	if (CFrameWnd::OnCreate(lpCreateStruct) == -1)
		return -1;

	m_wndReBar.Create(this);
	m_editUrlAddress.Create(WS_CHILD | WS_VISIBLE, CRect(0, 0, 0, 20), &m_wndReBar, 10050005);
	m_wndReBar.AddBar(&m_editUrlAddress);


	if (!m_wndStatusBar.Create(this))
	{
		TRACE0("δ�ܴ���״̬��\n");
		return -1;      // δ�ܴ���
	}
	m_wndStatusBar.SetIndicators(indicators, sizeof(indicators)/sizeof(UINT));

	SetWindowText("CookieUser");
	SetIcon(AfxGetApp()->LoadIcon(IDR_MAINFRAME),FALSE);
	SetProp(GetSafeHwnd(),"use_hook_cookie",HANDLE(1));

	CWnd * pDeskTopWnd = CWnd::GetDesktopWindow();
	CWnd *pFind = pDeskTopWnd->GetWindow(GW_CHILD);
	while(pFind)  //������Cookie�ṩ������Cookie
	{
		if (::GetProp(pFind->GetSafeHwnd(),"hook_cookie"))
		{
			COPYDATASTRUCT stCopyData = {0};
			stCopyData.cbData = 0;
			stCopyData.lpData = NULL;
			stCopyData.dwData = WM_CD_GETCOOKIE;
			::SendMessage(pFind->GetSafeHwnd(), WM_COPYDATA, 
				reinterpret_cast<WPARAM>(GetSafeHwnd()),
				reinterpret_cast<LPARAM>(&stCopyData));
		}

		pFind = pFind->GetWindow(GW_HWNDNEXT);
	}
	SetProp(GetSafeHwnd(),"hook_cookie",HANDLE(1));
	return 0;
}

BOOL CMainFrame::PreCreateWindow(CREATESTRUCT& cs)
{
	if( !CFrameWnd::PreCreateWindow(cs) )
		return FALSE;
	// TODO: �ڴ˴�ͨ���޸�
	//  CREATESTRUCT cs ���޸Ĵ��������ʽ

	cs.style &= ~FWS_ADDTOTITLE;
	return TRUE;
}

// CMainFrame ���

#ifdef _DEBUG
void CMainFrame::AssertValid() const
{
	CFrameWnd::AssertValid();
}

void CMainFrame::Dump(CDumpContext& dc) const
{
	CFrameWnd::Dump(dc);
}
#endif //_DEBUG


// CMainFrame ��Ϣ�������


BOOL CMainFrame::PreTranslateMessage(MSG* pMsg)
{
	// TODO: �ڴ����ר�ô����/����û���
	if (pMsg->hwnd == m_editUrlAddress.GetSafeHwnd() && pMsg->message == WM_KEYDOWN && pMsg->wParam == VK_RETURN)
	{
		CString strUrl;
		m_editUrlAddress.GetWindowText(strUrl);
		CCookieUserView *pView = dynamic_cast<CCookieUserView*>(GetActiveView());
		if (pView)
			pView->Navigate(strUrl);
	}

	return CFrameWnd::PreTranslateMessage(pMsg);
}


BOOL CMainFrame::OnCopyData(CWnd* pWnd, COPYDATASTRUCT* pCopyDataStruct)
{
	// TODO: �ڴ������Ϣ�����������/�����Ĭ��ֵ
	if (pCopyDataStruct->dwData == WM_CD_GETCOOKIE)
	{
		PostMessage(WM_CD_GETCOOKIE,0,0);
	}
	else if (pCopyDataStruct->dwData == WM_CD_SETCOOKIE)
	{
		CookieData *pData = static_cast<CookieData*>(pCopyDataStruct->lpData);
		if (pData->dwProcessId == GetCurrentProcessId())
			return TRUE; // �����Լ�����Ϣ������Ҫ����Cookie

		wchar_t *pszUrl = NULL, *pszCookieName = NULL, *pszCookieData = NULL;
		if (pData->dwSizeUrl > 0)
			pszUrl = reinterpret_cast<wchar_t*>(pData->pStrData);
		if (pData->dwSizeCookieName > 0)
			pszCookieName = reinterpret_cast<wchar_t*>((pData->pStrData + pData->dwSizeUrl));
		if (pData->dwSizeCookieData > 0)
			pszCookieData = reinterpret_cast<wchar_t*>((pData->pStrData + pData->dwSizeUrl + pData->dwSizeCookieName));
		InternetSetCookieExW(pszUrl, pszCookieName, pszCookieData, pData->dwFlags, pData->dwReserved);

		CCookieUserView * pView = dynamic_cast<CCookieUserView*>(GetActiveView());
		// �յ���������Cookie�󣬽�������Cookie,��ʹ��Cookie��¼
		//pView->Refresh();

	}
	return CFrameWnd::OnCopyData(pWnd, pCopyDataStruct);
}


void CMainFrame::OnDestroy()
{
	CFrameWnd::OnDestroy();

	// TODO: �ڴ˴������Ϣ����������
	RemoveProp(GetSafeHwnd(),"use_hook_cookie");
	RemoveProp(GetSafeHwnd(),"hook_cookie");
}
extern vector<CookiePair> m_HostCookieHistoryList;
LRESULT CMainFrame::OnMsgSendCookie(WPARAM,LPARAM)
{
	// ����ǰ���̵�Cookie����������
	EnterCriticalSection(&g_CookieListCS);
	for (vector<CookiePair>::const_iterator iter = m_HostCookieHistoryList.begin();iter!=m_HostCookieHistoryList.end();iter++)
	{
		SendCookieToShare(iter->m_strHost,iter->m_strValue);
	}
	LeaveCriticalSection(&g_CookieListCS);
	return S_OK;
}