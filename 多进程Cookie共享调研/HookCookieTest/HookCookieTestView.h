
// HookCookieTestView.h : CHookCookieTestView ��Ľӿ�
//

#pragma once


class CHookCookieTestView : public CHtmlView
{
protected: // �������л�����
	CHookCookieTestView();
	DECLARE_DYNCREATE(CHookCookieTestView)

// ����
public:
	CHookCookieTestDoc* GetDocument() const;

// ����
public:

// ��д
public:
	virtual BOOL PreCreateWindow(CREATESTRUCT& cs);
protected:
	virtual void OnInitialUpdate(); // ������һ�ε���

// ʵ��
public:
	virtual ~CHookCookieTestView();
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
};

#ifndef _DEBUG  // HookCookieTestView.cpp �еĵ��԰汾
inline CHookCookieTestDoc* CHookCookieTestView::GetDocument() const
   { return reinterpret_cast<CHookCookieTestDoc*>(m_pDocument); }
#endif

