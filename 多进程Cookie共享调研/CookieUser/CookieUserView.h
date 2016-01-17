
// CookieUserView.h : CCookieUserView ��Ľӿ�
//

#pragma once

#define  WM_NEW_URL WM_USER + 899
class CCookieUserView : public CHtmlView
{
protected: // �������л�����
	CCookieUserView();
	DECLARE_DYNCREATE(CCookieUserView)

// ����
public:
	CCookieUserDoc* GetDocument() const;

// ����
public:

// ��д
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual void OnInitialUpdate(); // ������һ�ε���

// ʵ��
public:
	virtual ~CCookieUserView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// ���ɵ���Ϣӳ�亯��
protected:
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnRefresh();
	virtual void OnNavigateComplete2(LPCTSTR strURL);
	virtual void OnNewWindow2(LPDISPATCH* ppDisp, BOOL* Cancel);
	virtual void OnBeforeNavigate2(LPCTSTR lpszURL, DWORD nFlags,
		LPCTSTR lpszTargetFrameName, CByteArray& baPostedData,
		LPCTSTR lpszHeaders, BOOL* pbCancel);
	afx_msg void OnGetVideoUrl();
	LRESULT OnNewUrl(WPARAM ap,LPARAM lp);
private:
	CString m_strNewUrl;
	CString m_strHeaders;
public:
	afx_msg void OnMenuGoBack();
	afx_msg void OnMenuGoForward();
	afx_msg void OnGetNewAddVideos();
};

#ifndef _DEBUG  // CookieUserView.cpp �еĵ��԰汾
inline CCookieUserDoc* CCookieUserView::GetDocument() const
   { return reinterpret_cast<CCookieUserDoc*>(m_pDocument); }
#endif

