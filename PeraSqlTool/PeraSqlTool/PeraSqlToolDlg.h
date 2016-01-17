
// PeraSqlToolDlg.h : ͷ�ļ�
//

#pragma once
#include "MineListBox.h"
#include <vector>
#include "afxcmn.h"
using namespace std;

// CPeraSqlToolDlg �Ի���
class CPeraSqlToolDlg : public CDialogEx
{
// ����
public:
	CPeraSqlToolDlg(CWnd* pParent = NULL);	// ��׼���캯��
	~CPeraSqlToolDlg();

// �Ի�������
	enum { IDD = IDD_PERASQLTOOL_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��
	bool IsItemOk(const CString & strItemDir);
	BOOL CheckFolder();
	void ShowProgressMsg(CString strMsg);
	BOOL CopyDir(const char * pSrc,const char *pDes,int iLevelFolder);
	BOOL RemoveDir(const CString & strDir);
	BOOL UpdateSqlBatFile(const CString & strBatFile);
	BOOL UpateSqlFile(const CString &strSqlFile);
	void ExcuteBatImport();
	void ExcuteOneItem(const CString & strItemDir);
	void UpdateUI(BOOL bEnable);
	static DWORD WINAPI ThreadImportPro(LPVOID); 
// ʵ��
protected:
	HICON m_hIcon;
	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnBnClickedButtonExcute();
	afx_msg void OnBnClickedButtonSelSql();
	afx_msg LRESULT OnNewCmdMsg(WPARAM,LPARAM);
	DECLARE_MESSAGE_MAP()
public:
	// �û���
	CString m_StrUser;
	// �û�����
	CString m_StrPassWd;
	// ʵ����
	CString m_strCaseName;
	// SQLĿ¼
	CString m_StrSqlDir;

	FILE  *m_pCmdOutFile;
	vector<CString> m_vStrDirItem;
	CString m_strRunDir;
	BOOL  m_bImportFinished;
	CMineListBox m_List;
	CProgressCtrl m_ProgressCtrl;
};
