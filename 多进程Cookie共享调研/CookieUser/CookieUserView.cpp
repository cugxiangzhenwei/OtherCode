
// CookieUserView.cpp : CCookieUserView ���ʵ��
//

#include "stdafx.h"
// SHARED_HANDLERS ������ʵ��Ԥ��������ͼ������ɸѡ�������
// ATL ��Ŀ�н��ж��壬�����������Ŀ�����ĵ����롣
#ifndef SHARED_HANDLERS
#include "CookieUser.h"
#endif

#include "CookieUserDoc.h"
#include "CookieUserView.h"

#include "MainFrm.h"
#ifdef _DEBUG
#define new DEBUG_NEW
#endif
#include <vector>
using namespace std;

extern BOOL DownloadHtml(CString & strDestHtml,CString strUrl,BOOL bIsFile,DWORD &dwHttpCode);
// CCookieUserView

IMPLEMENT_DYNCREATE(CCookieUserView, CHtmlView)

BEGIN_MESSAGE_MAP(CCookieUserView, CHtmlView)
	// ��׼��ӡ����
	ON_COMMAND(ID_FILE_PRINT, &CHtmlView::OnFilePrint)
	ON_COMMAND(ID_REFRESH, &CCookieUserView::OnRefresh)
	ON_COMMAND(ID_GET_VIDEO_URL, &CCookieUserView::OnGetVideoUrl)
	ON_MESSAGE(WM_NEW_URL,&CCookieUserView::OnNewUrl)
	ON_COMMAND(ID_MENU_GO_BACK, &CCookieUserView::OnMenuGoBack)
	ON_COMMAND(ID_MENU_GO_FORWARD, &CCookieUserView::OnMenuGoForward)
	ON_COMMAND(ID_GET_NEW_ADD_VIDEOS, &CCookieUserView::OnGetNewAddVideos)
END_MESSAGE_MAP()

// CCookieUserView ����/����

CCookieUserView::CCookieUserView()
{
	// TODO: �ڴ˴���ӹ������

}

CCookieUserView::~CCookieUserView()
{
}

BOOL CCookieUserView::PreCreateWindow(CREATESTRUCT& cs)
{
	// TODO: �ڴ˴�ͨ���޸�
	//  CREATESTRUCT cs ���޸Ĵ��������ʽ

	return CHtmlView::PreCreateWindow(cs);
}

void CCookieUserView::OnInitialUpdate()
{
	CHtmlView::OnInitialUpdate();
	SetSilent(TRUE);
	Navigate2(_T("http://i.youku.com/u/home?type=favorite&sub=video"),NULL,NULL);
}


// CCookieUserView ��ӡ



// CCookieUserView ���

#ifdef _DEBUG
void CCookieUserView::AssertValid() const
{
	CHtmlView::AssertValid();
}

void CCookieUserView::Dump(CDumpContext& dc) const
{
	CHtmlView::Dump(dc);
}

CCookieUserDoc* CCookieUserView::GetDocument() const // �ǵ��԰汾��������
{
	ASSERT(m_pDocument->IsKindOf(RUNTIME_CLASS(CCookieUserDoc)));
	return (CCookieUserDoc*)m_pDocument;
}
#endif //_DEBUG


// CCookieUserView ��Ϣ�������


void CCookieUserView::OnRefresh()
{
	// TODO: �ڴ���������������
	Refresh();
}


void CCookieUserView::OnNavigateComplete2(LPCTSTR strURL)
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
void CCookieUserView::OnNewWindow2(LPDISPATCH* ppDisp, BOOL* Cancel)
{
	*Cancel = TRUE;
	PostMessage(WM_NEW_URL,0,(LPARAM)ppDisp);
}
LRESULT CCookieUserView::OnNewUrl(WPARAM ap,LPARAM lp)
{
	LPDISPATCH* ppDisp  = (LPDISPATCH*)lp;
	CComPtr<IHTMLDocument2> pHTMLDocument2;

	m_pBrowserApp->get_Document((IDispatch **)&pHTMLDocument2);
	if (pHTMLDocument2!=NULL)
	{
		CComPtr<IHTMLElement> pIHTMLElement;
		pHTMLDocument2->get_activeElement(&pIHTMLElement);

		if (pIHTMLElement!=NULL)
		{
			variant_t url;
			HRESULT hr=pIHTMLElement->getAttribute(L"href", 0, &url);
			if (SUCCEEDED(hr))
			{
				hr=m_pBrowserApp->Navigate2(&url, NULL, NULL, NULL, NULL);
				url.Clear();
			}
		}
	}	
	//Navigate2(m_strNewUrl,0,NULL,m_strHeaders,NULL,0);
	return S_OK;
}

void CCookieUserView::OnBeforeNavigate2(LPCTSTR lpszURL, DWORD nFlags,
	LPCTSTR lpszTargetFrameName, CByteArray& baPostedData,
	LPCTSTR lpszHeaders, BOOL* pbCancel)
{
	m_strNewUrl = lpszURL;
	m_strHeaders = lpszHeaders!=NULL ? lpszHeaders:"";
}
#define  FindHeader "http://v.youku.com/v_show/"
#define  FindEnd "\" target=\"video"
void CCookieUserView::OnGetVideoUrl()
{
	// TODO: �ڴ���������������
	CString strUrl = GetLocationURL();
	vector<CString> mAllVideoUrls;
	DWORD dwStatusCode;
	BOOL bFailedLast = FALSE;
	BOOL bLastPage = FALSE;
	for (int i=0;i<99999;i++)
	{
		if (bLastPage)
			break;

		CString strUrl = "http://i.youku.com/u/home?page=1&type=favorite&sub=video";
		strUrl.Format("%s%d%s","http://i.youku.com/u/home?page=",i+1,"&type=favorite&sub=video");
		CString strHtml;
		BOOL bOk = DownloadHtml(strHtml,strUrl,FALSE,dwStatusCode);
		int iStartPos = 0;
		while (iStartPos >=0)
		{
			int iTempStart = iStartPos;
			iStartPos = strHtml.Find(FindHeader,iStartPos);
			if (iTempStart == 0 && iStartPos <0)
			{
				if (bFailedLast == FALSE)
				{
					bFailedLast = TRUE;// ����һ�γ�����
					continue;
				}
				else
				{
					bLastPage = TRUE;
					break; // ��������ҳ����û�к��ʵ����ӣ���������
				}
			}

			if (iStartPos >0)
			{
				int iEnd = strHtml.Find(FindEnd,iStartPos);
				int iS = iStartPos;
				CString strVideoUrl = strHtml.Mid(iS,iEnd - iS);
				iStartPos = iEnd + sizeof(FindEnd) + 1100;
				mAllVideoUrls.push_back(strVideoUrl);
				bFailedLast = FALSE;
				printf("%s\n",(LPCTSTR)strVideoUrl);
			}
		}
	}
	int iCount = mAllVideoUrls.size();
	CString strFileName;
	GetModuleFileName(NULL,strFileName.GetBuffer(500),500);
	strFileName.ReleaseBuffer();
	strFileName = strFileName.Left(strFileName.ReverseFind('.')) + ".ini";
	WritePrivateProfileStruct("Config","LastAllCount",&iCount,sizeof(iCount),strFileName);
	CString strMsg;
	strMsg.Format("���ҵ���������%d��",mAllVideoUrls.size());
	MessageBox((LPCTSTR)strMsg,"��ʾ",MB_OK);
}


void CCookieUserView::OnMenuGoBack()
{
	// TODO: �ڴ���������������
	GoBack();
}


void CCookieUserView::OnMenuGoForward()
{
	// TODO: �ڴ���������������
	GoForward();
}


void CCookieUserView::OnGetNewAddVideos()
{
	// TODO: �ڴ���������������
	int  iCountLastAll = 0;
	CString strFileName;
	DWORD dwStatusCode;

	GetModuleFileName(NULL,strFileName.GetBuffer(500),500);
	strFileName.ReleaseBuffer();
	strFileName = strFileName.Left(strFileName.ReverseFind('.')) + ".ini";
	GetPrivateProfileStruct("Config","LastAllCount",&iCountLastAll,sizeof(iCountLastAll),strFileName);
	if (iCountLastAll <0) iCountLastAll = 0;

	CString strHtml;
	CString strUrl = "http://i.youku.com/u/home?type=favorite&sub=video";
	BOOL bOk = DownloadHtml(strHtml,strUrl,FALSE,dwStatusCode);
	int iPosStart = strHtml.Find("class=\"qPager\"");

	iPosStart = strHtml.Find("/",iPosStart)+1;
	int iEnd = strHtml.Find("��",iPosStart);
	CString strCount = strHtml.Mid(iPosStart,iEnd - iPosStart);
	int iNowCount;
	sscanf_s((LPCTSTR)strCount,"%d",&iNowCount);
	int iNewCount = iNowCount - iCountLastAll;
	WritePrivateProfileStruct("Config","LastAllCount",&iNowCount,sizeof(iNowCount),strFileName);
	int iNewPageCount = (iNewCount + 19)/20;

	vector<CString> mAllVideoUrls;
	BOOL bFailedLast = FALSE;
	BOOL bLastPage = FALSE;
	for (int i=0;i<iNewPageCount;i++)
	{
		if (bLastPage)
			break;

		CString strUrl = "http://i.youku.com/u/home?page=1&type=favorite&sub=video";
		strUrl.Format("%s%d%s","http://i.youku.com/u/home?page=",i+1,"&type=favorite&sub=video");
		CString strHtml;
		BOOL bOk = DownloadHtml(strHtml,strUrl,FALSE,dwStatusCode);
		int iStartPos = 0;
		while (iStartPos >=0)
		{
			int iTempStart = iStartPos;
			iStartPos = strHtml.Find(FindHeader,iStartPos);
			if (iTempStart == 0 && iStartPos <0)
			{
				if (bFailedLast == FALSE)
				{
					bFailedLast = TRUE;// ����һ�γ�����
					continue;
				}
				else
				{
					bLastPage = TRUE;
					break; // ��������ҳ����û�к��ʵ����ӣ���������
				}
			}

			if (iStartPos >0)
			{
				int iEnd = strHtml.Find(FindEnd,iStartPos);
				int iS = iStartPos;
				CString strVideoUrl = strHtml.Mid(iS,iEnd - iS);
				iStartPos = iEnd + sizeof(FindEnd) + 1100;
				mAllVideoUrls.push_back(strVideoUrl);
				bFailedLast = FALSE;
				printf("%s\n",(LPCTSTR)strVideoUrl);
				if (mAllVideoUrls.size()== iNewCount)
				{
					bLastPage = TRUE;
					break; // �Ѿ��ҵ����еĸ�����
				}
			}
		}
	}
	CString strMsg;
	strMsg.Format("���ҵ�������������%d��",mAllVideoUrls.size());
	MessageBox((LPCTSTR)strMsg,"��ʾ",MB_OK);
}
