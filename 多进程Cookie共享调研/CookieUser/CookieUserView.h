
// CookieUserView.h : CCookieUserView 类的接口
//

#pragma once

#define  WM_NEW_URL WM_USER + 899
class CCookieUserView : public CHtmlView
{
protected: // 仅从序列化创建
	CCookieUserView();
	DECLARE_DYNCREATE(CCookieUserView)

// 特性
public:
	CCookieUserDoc* GetDocument() const;

// 操作
public:

// 重写
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual void OnInitialUpdate(); // 构造后第一次调用

// 实现
public:
	virtual ~CCookieUserView();
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:

// 生成的消息映射函数
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

#ifndef _DEBUG  // CookieUserView.cpp 中的调试版本
inline CCookieUserDoc* CCookieUserView::GetDocument() const
   { return reinterpret_cast<CCookieUserDoc*>(m_pDocument); }
#endif

