
// PeraSqlToolDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "PeraSqlTool.h"
#include "PeraSqlToolDlg.h"
#include "afxdialogex.h"
#include "Tools.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

#define  WM_CMD_OUT_NEW WM_USER + 1
// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

bool SortFolder(const CString &Dir1,CString &Dir2)
{
	int iPosMid1  = Dir1.ReverseFind('\\')+1;
	int iPosMid2 = Dir2.ReverseFind('\\')+1;
	if (iPosMid1 <=0 || iPosMid2 <=0)
		return false;

	CString strSub1 = Dir1.Mid(iPosMid1);
	CString strSub2 = Dir2.Mid(iPosMid2);

	if (strSub1.Compare(strSub2) >0)
		return false;

	return true;
}
class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// �Ի�������
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

// ʵ��
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialogEx(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialogEx)
END_MESSAGE_MAP()


// CPeraSqlToolDlg �Ի���




CPeraSqlToolDlg::CPeraSqlToolDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CPeraSqlToolDlg::IDD, pParent)
	, m_StrUser(_T(""))
	, m_StrPassWd(_T(""))
	, m_strCaseName(_T(""))
	, m_StrSqlDir(_T(""))
	,m_strRunDir(_T(""))
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_pCmdOutFile = NULL;
}
CPeraSqlToolDlg::~CPeraSqlToolDlg()
{
	/*if (!m_strRunDir.IsEmpty())
	{
	RemoveDir(m_strRunDir);
	}*/
}
void CPeraSqlToolDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT_USER, m_StrUser);
	DDV_MaxChars(pDX, m_StrUser, 50);
	DDX_Text(pDX, IDC_EDIT_PSWD, m_StrPassWd);
	DDV_MaxChars(pDX, m_StrPassWd, 50);
	DDX_Text(pDX, IDC_EDIT_CASE_NAME, m_strCaseName);
	DDX_Text(pDX, IDC_EDIT_SQL_DIR, m_StrSqlDir);
	DDX_Control(pDX, IDC_LIST1, m_List);
	DDX_Control(pDX, IDC_PROGRESS1, m_ProgressCtrl);
}

BEGIN_MESSAGE_MAP(CPeraSqlToolDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON_SEL_SQL, &CPeraSqlToolDlg::OnBnClickedButtonSelSql)
	ON_BN_CLICKED(IDC_BUTTON_EXCUTE, &CPeraSqlToolDlg::OnBnClickedButtonExcute)
	ON_MESSAGE(WM_CMD_OUT_NEW,&CPeraSqlToolDlg::OnNewCmdMsg)
END_MESSAGE_MAP()


// CPeraSqlToolDlg ��Ϣ�������

BOOL CPeraSqlToolDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// ��������...���˵�����ӵ�ϵͳ�˵��С�

	// IDM_ABOUTBOX ������ϵͳ���Χ�ڡ�
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		BOOL bNameValid;
		CString strAboutMenu;
		bNameValid = strAboutMenu.LoadString(IDS_ABOUTBOX);
		ASSERT(bNameValid);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������
	ShowProgressMsg("�������");
	m_ProgressCtrl.SendMessage (PBM_SETBARCOLOR, 0, RGB(0,200,0));
	m_ProgressCtrl.SendMessage (PBM_SETBKCOLOR, 0, RGB(200,200,200));

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

void CPeraSqlToolDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialogEx::OnSysCommand(nID, lParam);
	}
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CPeraSqlToolDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CPeraSqlToolDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


int CALLBACK BrowseCallbackProc(HWND hwnd,UINT uMsg,LPARAM lParam,LPARAM lpData)
{
	switch(uMsg)
	{
	case BFFM_INITIALIZED:
		::SendMessage(hwnd,BFFM_SETSELECTION,TRUE,lpData);
		HWND hFind = ::GetWindow(hwnd,GW_CHILD);
		while(hFind)
		{
			char szName[256] ={0};
			GetClassName(hFind,szName,256);
			if (_stricmp(szName,"Edit")==0)
			{
				CEdit *pEdit = (CEdit*)CWnd::FromHandle(hFind);
				//pEdit->EnableWindow(FALSE);
				pEdit->SetReadOnly(TRUE); //���ؼ�����Ϊֻ�������㸴�ƣ����������޸�
				break;
			}
			hFind = ::GetWindow(hFind,GW_HWNDNEXT);
		}

		break;
	}
	return 0;
}
void CPeraSqlToolDlg::OnBnClickedButtonSelSql()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	UpdateData(TRUE); // �����û������������
	BROWSEINFO bi;  
	ZeroMemory(&bi,sizeof(BROWSEINFO)); 
	bi.hwndOwner = m_hWnd;   
	bi.lpszTitle = "��ѡ��SQLĿ¼��";  

	char strLastDir[1000] = {0};
	GetPrivateProfileString("PeraSqlTool","SQL_DIR_LAST","",strLastDir,1000,"PeraSqlTool.ini");
	bi.ulFlags = BIF_USENEWUI | BIF_RETURNONLYFSDIRS;
	bi.lpfn = BrowseCallbackProc;
	bi.lParam = (LPARAM)(LPCTSTR)strLastDir;

	LPITEMIDLIST pidl = SHBrowseForFolder(&bi);  

	if(NULL == pidl )
		return;

	CString strFolderOut = "";

	LPMALLOC pMalloc;
	SHGetPathFromIDList(pidl,strFolderOut.GetBuffer(1000));  
	if(SUCCEEDED(SHGetMalloc(&pMalloc))) 
	{  
		pMalloc->Free(pidl);  
		pMalloc->Release();  
	}
	m_StrSqlDir = strFolderOut;
	strFolderOut.ReleaseBuffer();
	UpdateData(FALSE);
	if (!m_StrSqlDir.IsEmpty())
	{
		WritePrivateProfileString("PeraSqlTool","SQL_DIR_LAST",m_StrSqlDir,"PeraSqlTool.ini");
	}
}
bool CPeraSqlToolDlg::IsItemOk(const CString & strItemDir)
{
	CString strSQlBat = strItemDir + "\\sql.bat";
	if(!PathFileExists(strSQlBat))
	{
		CString strErrMsg;
		strErrMsg.Format("��Ŀ¼��%s����δ�ҵ�sql.bat�ļ�",strItemDir);
		MessageBox(strErrMsg,"��ʾ",MB_OK|MB_ICONINFORMATION);
		return false;
	}

	if (!PathFileExists(strItemDir + "\\sql"))
	{
		CString strErrMsg;
		strErrMsg.Format("��Ŀ¼��%s����δ�ҵ�sqlĿ¼",strItemDir);
		MessageBox(strErrMsg,"��ʾ",MB_OK|MB_ICONINFORMATION);
		return false;
	}
	CString strPeraSQl = strItemDir + "\\sql\\pera.sql";
	if( !PathFileExists(strPeraSQl))
	{
		CString strErrMsg;
		strErrMsg.Format("��Ŀ¼��%s\\sql����δ�ҵ�pera.sql�ļ�",strItemDir);
		MessageBox(strErrMsg,"��ʾ",MB_OK|MB_ICONINFORMATION);
		return false;
	}
	return true;
}
BOOL CPeraSqlToolDlg::CheckFolder()
{
	ShowProgressMsg("����У����������...");
	CString strWildCard  = m_StrSqlDir;
	strWildCard +="\\*.*";
	CFileFind finder;
	BOOL bFind = FALSE;
	// �����ļ�
	BOOL bErrOccured = FALSE;
	bFind = finder.FindFile(strWildCard);
	while(bFind)
	{
		// ������һ���ļ�
		bFind = finder.FindNextFile();
		if (finder.IsDots())
			continue;

		//�ҵ��ļ���·��
		CString strPathName = finder.GetFilePath();
		if (!finder.IsDirectory())
			continue;
		
		if (!IsItemOk(strPathName))
		{
			bErrOccured = TRUE;
			break;
		}
	}
	finder.Close();
	if (bErrOccured)
	{
		m_vStrDirItem.clear();
		return FALSE;
	}
	ShowProgressMsg("����У�����...");
	return TRUE;
}
void CPeraSqlToolDlg::ShowProgressMsg(CString strMsg)
{
	SetDlgItemText(IDC_STATIC_PRO,strMsg);
}
BOOL CPeraSqlToolDlg::CopyDir(const char * pSrc,const char *pDes,int iLevelFolder)
{
	if (NULL == pSrc || NULL == pDes)	return -1;
	if (!PathFileExists(pDes))
	{
		if (CreateDirectory(pDes,NULL)==0)
		{
			ZTools::WriteZToolsFormatLog("����Ŀ¼[%s]ʧ��",pDes);
			return FALSE;
		}
	}

	CString strWildCard  = pSrc;
	strWildCard +="\\*.*";
	CFileFind finder;
	BOOL bFind = FALSE;
	// �����ļ�
	BOOL bErrOccured = FALSE;
	bFind = finder.FindFile(strWildCard);
	while(bFind)
	{
		// ������һ���ļ�
		bFind = finder.FindNextFile();
		if (finder.IsDots())
			continue;

		//�ҵ��ļ���·��
		CString strPathName = finder.GetFilePath();
		CString strDest = pDes;
		strDest += "\\";
		strDest += finder.GetFileName();

		if (finder.IsDirectory())
		{
			int iLevel = iLevelFolder + 1;
			if (!CopyDir(strPathName,strDest,iLevel))
			{
				ZTools::WriteZToolsFormatLog("����Ŀ¼[%s]��[%s]ʧ��",strPathName,strDest);
				finder.Close();
				return FALSE;
			}
			if (iLevelFolder ==1)
				m_vStrDirItem.push_back(strDest);
		}
		else
		{
			CString strMsg;
			strMsg.Format("�����ļ�[%s]��[%s]",strPathName,strDest);
			ShowProgressMsg(strMsg);
			if (!::CopyFile(strPathName,strDest,FALSE))
			{
				ZTools::WriteZToolsFormatLog("�����ļ�[%s]��[%s]ʧ��",strPathName,strDest);
				finder.Close();
				return FALSE;
			}
		}
	}
	finder.Close();
	return TRUE;
}
BOOL CPeraSqlToolDlg::RemoveDir(const CString & strDir)
{
	CString strWildCard  = strDir;
	strWildCard +="\\*.*";
	CFileFind finder;
	BOOL bFind = FALSE;
	// �����ļ�
	BOOL bErrOccured = FALSE;
	bFind = finder.FindFile(strWildCard);
	while(bFind)
	{
		// ������һ���ļ�
		bFind = finder.FindNextFile();
		if (finder.IsDots())
			continue;
		//�ҵ��ļ���·��
		CString strPathName = finder.GetFilePath();
		if (finder.IsDirectory())
			RemoveDir(strPathName);
		else
		{
			if (!::DeleteFile(strPathName))
			{
				ZTools::WriteZToolsFormatLog("ɾ���ļ�%sʧ��",strPathName);
				finder.Close();
				return FALSE;
			}
		}
	}
	finder.Close();
	if (!::RemoveDirectory(strDir))
	{
		ZTools::WriteZToolsFormatLog("ɾ���ļ�%sʧ��",strDir);
		return FALSE;
	}

	return TRUE;
}
void CPeraSqlToolDlg::OnBnClickedButtonExcute()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	UpdateData(TRUE);
	if (m_StrUser.IsEmpty())
	{
		MessageBox("�û�������Ϊ��","��ʾ",MB_OK|MB_ICONINFORMATION);
		return;
	}

	if (m_StrPassWd.IsEmpty())
	{
		MessageBox("���벻��Ϊ��","��ʾ",MB_OK|MB_ICONINFORMATION);
		return;
	}

	if (m_strCaseName.IsEmpty())
	{
		MessageBox("ʵ��������Ϊ��","��ʾ",MB_OK|MB_ICONINFORMATION);
		return;
	}
	if (m_StrSqlDir.IsEmpty())
	{
		MessageBox("SQLĿ¼����Ϊ��","��ʾ",MB_OK|MB_ICONINFORMATION);
		return;
	}
	if (!PathFileExists(m_StrSqlDir))
	{
		CString strErrMsg;
		strErrMsg.Format("Ŀ¼��%s��������",m_StrSqlDir);
		MessageBox(strErrMsg,"��ʾ",MB_OK|MB_ICONERROR);
		return;
	}

	m_StrSqlDir.Replace("/","\\");
	m_StrSqlDir.Replace("\\\\","\\");
	ZTools::WriteZToolsFormatLog("���������\n�û�����%s\n���룺%s\nʵ������:%s\nSQLĿ¼��%s",
		m_StrUser,m_StrPassWd,m_strCaseName,m_StrSqlDir);

	HANDLE h = CreateThread(NULL,0,ThreadImportPro,this,0,NULL);
	CloseHandle(h); // ���ں˶�������ü�������һ��
}
BOOL CPeraSqlToolDlg::UpdateSqlBatFile(const CString & strBatFile)
{
	ZTools::WriteZToolsFormatLog("��ʼ�޸��ļ�%s",strBatFile);
	FILE *pFile = NULL;
	fopen_s(&pFile,strBatFile,"rb"); // ��ֻ����ʽ���ļ�

	if (pFile==NULL)
	{
		ZTools::WriteZToolsFormatLog("���ļ�[%s]ʧ��...\n",strBatFile);
		return FALSE;
	}

	fseek(pFile,0,SEEK_END);
	int iFileSize = ftell(pFile);
	char * pBuf = new char[iFileSize+1];
	memset(pBuf,0,sizeof(char)*(iFileSize+1));
	fseek(pFile,0,SEEK_SET);
	size_t iRead = fread_s(pBuf,iFileSize,sizeof(char),iFileSize,pFile);
	fclose(pFile); // ����֮��ر��ļ�
	pFile = NULL;
	if (iRead != iFileSize)
	{
		delete pBuf;
		ZTools::WriteZToolsFormatLog("��ȡ�ļ�[%s]���ݳ���...\n",strBatFile);
		return FALSE;
	}

	pBuf[iFileSize] = 0;
	CString strSourceContent = pBuf;
	delete pBuf;
	strSourceContent.Replace("pause .....","");
	fopen_s(&pFile,strBatFile,"wb"); // ��д��ʽ���ļ�
	if (pFile==NULL)
	{
		ZTools::WriteZToolsFormatLog("д�ļ�[%s]ʧ��...\n",strBatFile);
		return FALSE;
	}

	fseek(pFile,0,SEEK_SET);
	size_t iLength = strSourceContent.GetLength();
	size_t iWritten = fwrite(strSourceContent,1,iLength,pFile);
	if (iLength!=iWritten)
	{
		ZTools::WriteZToolsFormatLog("д���ļ�[%s]���ݳ���...\n",strBatFile);
		return false;
	}

	fclose(pFile);
	pFile = NULL;
	ZTools::WriteZToolsFormatLog("�޸��ļ�%s���",strBatFile);
	return TRUE;
}
BOOL CPeraSqlToolDlg::UpateSqlFile(const CString &strSqlFile)
{
	ZTools::WriteZToolsFormatLog("��ʼ�޸��ļ�%s",strSqlFile);
	FILE *pFile = NULL;
	fopen_s(&pFile,strSqlFile,"rb"); // ��ֻ����ʽ���ļ�

	if (pFile==NULL)
	{
		ZTools::WriteZToolsFormatLog("���ļ�[%s]ʧ��...\n",strSqlFile);
		return FALSE;
	}

	fseek(pFile,0,SEEK_END);
	int iFileSize = ftell(pFile);
	char * pBuf = new char[iFileSize+1];
	memset(pBuf,0,sizeof(char)*(iFileSize+1));
	fseek(pFile,0,SEEK_SET);
	size_t iRead = fread_s(pBuf,iFileSize,sizeof(char),iFileSize,pFile);
	fclose(pFile); // ����֮��ر��ļ�
	pFile = NULL;
	if (iRead != iFileSize)
	{
		delete pBuf;
		ZTools::WriteZToolsFormatLog("��ȡ�ļ�[%s]���ݳ���...\n",strSqlFile);
		return FALSE;
	}

	pBuf[iFileSize] = 0;
	CString strSourceContent = pBuf;
	delete pBuf;
	int iPosConn = strSourceContent.Find("conn ");
	int iLineEnd = strSourceContent.Find("\n",iPosConn);
	CString strOld = strSourceContent.Mid(iPosConn,iLineEnd - iPosConn + 1);
	CString strConnNew;
	strConnNew.Format("conn %s/%s@%s\r\n",m_StrUser,m_StrPassWd,m_strCaseName);
	strSourceContent.Replace(strOld,strConnNew);
	fopen_s(&pFile,strSqlFile,"wb"); // ��д��ʽ���ļ�

	fseek(pFile,0,SEEK_SET);
	size_t iLength = strSourceContent.GetLength();
	size_t iWritten = fwrite(strSourceContent,1,iLength,pFile);
	if (iLength!=iWritten)
	{
		ZTools::WriteZToolsFormatLog("д���ļ�[%s]���ݳ���...\n",strSqlFile);
		return false;
	}

	fclose(pFile);
	pFile = NULL;
	ZTools::WriteZToolsFormatLog("�޸��ļ�%s���",strSqlFile);
	return TRUE;
}
void CPeraSqlToolDlg::ExcuteBatImport()
{
	CString strMsg;
	CString strOldWordDir;
	ShowProgressMsg("����ִ����������...");
	GetCurrentDirectory(1000,strOldWordDir.GetBuffer(1000));
	CString strCmdOutFile = m_strRunDir + "_cmd.log";
	fopen_s(&m_pCmdOutFile,strCmdOutFile,"w+");
	m_List.ResetContent();
	m_ProgressCtrl.SetRange32(0,m_vStrDirItem.size());
	m_ProgressCtrl.ShowWindow(SW_SHOW);
	for (size_t i=0;i<m_vStrDirItem.size();i++)
	{
		CString strBatFile = m_vStrDirItem[i] + "\\sql.bat";
		CString strSqlFile =  m_vStrDirItem[i] + "\\sql\\pera.sql";
		strMsg.Format("����%s",strSqlFile);
		ShowProgressMsg(strMsg);
		UpdateSqlBatFile(strBatFile);
		UpateSqlFile(strSqlFile);
		SetCurrentDirectory(m_vStrDirItem[i]); //�л�����Ŀ¼��sql.bat����Ŀ¼
		ExcuteOneItem(m_vStrDirItem[i]);
		m_ProgressCtrl.SetPos(i+1); //���½�����
	}
	if (m_pCmdOutFile)
	{
		fclose(m_pCmdOutFile);
		m_pCmdOutFile = NULL;
	}
	SetCurrentDirectory(strOldWordDir); // ��ԭ����Ŀ¼
	strOldWordDir.ReleaseBuffer();
	ShowProgressMsg("�����ʱĿ¼...");
	m_bImportFinished = TRUE;
	/*BOOL bOK = RemoveDir(m_strRunDir);*/
	ShowProgressMsg("��������SQL���!");
}
void CPeraSqlToolDlg::ExcuteOneItem(const CString & strItemDir)
{
	CString strMsg;
	strMsg.Format("ִ��%s\\sql.bat",strItemDir);
	ZTools::WriteZToolsFormatLog(strMsg);
	fprintf(m_pCmdOutFile,"%s\n",strMsg);
	m_List.AddString(strMsg);
	SECURITY_ATTRIBUTES sa;
	HANDLE hRead,hWrite;
	sa.nLength = sizeof(SECURITY_ATTRIBUTES);
	sa.lpSecurityDescriptor = NULL;
	sa.bInheritHandle = TRUE;
	//���������ܵ�
	if (!CreatePipe(&hRead,&hWrite,&sa,0)) 
	{
		ZTools::WriteZToolsFormatLog("���������ܵ�ʧ��");
		return;
	}
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	si.cb = sizeof(STARTUPINFO);
	GetStartupInfo(&si);
	si.hStdError = hWrite;//��������õ��ļ����
	si.hStdOutput = hWrite;//��������õ��ļ����
	si.wShowWindow = SW_HIDE;
	si.dwFlags = STARTF_USESHOWWINDOW | STARTF_USESTDHANDLES;

	//ִ��cmd����,���������йܵ���д��cmd����صĴ�
	if (!CreateProcess(NULL,"sql.bat",NULL,NULL,TRUE,NULL,NULL,NULL,&si,&pi))
	{
		ZTools::WriteZToolsLog("CreateProcess����cmd����ʧ��!");
		return;
	}
	CloseHandle(hWrite);

	char buffer[4096] ={0} ;
	DWORD bytesRead;
	int iSKipCharCount = 0;

	CString strTmp; //���ڱ����������
	while(1)
	{
		memset(buffer,0,4096);
		if(ReadFile(hRead,buffer,4096,&bytesRead,NULL) != NULL)//�������ܵ��ж�ȡ����
		{
			iSKipCharCount = 0;
			CString str = buffer;
			if (str.GetLength()>=2)
			{
				if (buffer[0]=='\n' || buffer[0]=='\r')
				{
					iSKipCharCount++;
					if (buffer[1]=='\n' || buffer[2]=='\r')
						iSKipCharCount++;
				}
			}
			str = buffer + iSKipCharCount;
			if (str.IsEmpty())
				continue;

			strTmp +=str;
			if (strTmp.Right(1)=="\n")
			{
				fprintf(m_pCmdOutFile,"%s",strTmp);
				CString *pMsg = new CString;
				*pMsg = strTmp;
				PostMessage(WM_CMD_OUT_NEW,0,(LPARAM)pMsg);
				strTmp.Empty(); //�����ʱ����ķ�������
			}
			else
				continue;
		}
		else
		{
			break;
		}
	}
	CloseHandle(hRead);
	fflush(m_pCmdOutFile);
	//ShellExecute(NULL,"open","sql.bat","",strItemDir,SW_HIDE);
}
void CPeraSqlToolDlg::UpdateUI(BOOL bEnable)
{
	GetDlgItem(IDC_BUTTON_SEL_SQL)->EnableWindow(bEnable);
	GetDlgItem(IDC_BUTTON_EXCUTE)->EnableWindow(bEnable);
	GetDlgItem(IDCANCEL)->EnableWindow(bEnable);
}
DWORD WINAPI CPeraSqlToolDlg::ThreadImportPro(LPVOID pThreadParam)
{
	CPeraSqlToolDlg *pThis = (CPeraSqlToolDlg*)pThreadParam;
	pThis->UpdateUI(FALSE);
	if (!pThis->CheckFolder())
	{
		pThis->UpdateUI(TRUE);
		return 0; // �˴�������������Ϣ����Ϊ����ᵯ
	}

	pThis->ShowProgressMsg("���ڿ������ݵ�����Ŀ¼...");
	char szDir[500] = {0};
	GetModuleFileName(NULL,szDir,500);
	CString strRunDir = szDir;
	strRunDir = strRunDir.Left(strRunDir.ReverseFind('\\') + 1) + "Run_";

	CString strTime = ZTools::GetNowTimeStr().c_str();
	strTime.Replace(":","-");
	strRunDir +=strTime;
	pThis->m_strRunDir = strRunDir;
	/*if (PathFileExists(pThis->m_strRunDir))
		pThis->RemoveDir(pThis->m_strRunDir);*/

	pThis->m_vStrDirItem.clear();
	ZTools::WriteZToolsFormatLog("����%sĿ¼��%s",pThis->m_StrSqlDir,pThis->m_strRunDir);
	pThis->CopyDir(pThis->m_StrSqlDir,strRunDir,1);
	if (pThis->m_vStrDirItem.empty())
	{
		pThis->UpdateUI(TRUE);
		pThis->MessageBox("δ�ҵ�SQL�����ļ�,��ָ����ȷ��SQLĿ¼��","��ʾ",MB_OK|MB_ICONINFORMATION);
		return 0;
	}
	ZTools::WriteZToolsFormatLog("���ҵ�sql.batĿ¼%d��",pThis->m_vStrDirItem.size());
	std::sort(pThis->m_vStrDirItem.begin(),pThis->m_vStrDirItem.end(),SortFolder);

	{ //��������д����־
		CString strLogText;
		for (size_t i=0;i< pThis->m_vStrDirItem.size();i++)
		{
			strLogText += pThis->m_vStrDirItem[i];
			strLogText +="\n";
		}
		ZTools::WriteZToolsFormatLog("�ļ���������Ϊ:\n%s",strLogText);
	}
	pThis->m_bImportFinished = FALSE;
	pThis->ExcuteBatImport();
	pThis->UpdateUI(TRUE);
	return 0;
}
LRESULT CPeraSqlToolDlg::OnNewCmdMsg(WPARAM wParam,LPARAM lParam)
{
	CString *pMsg = (CString*)lParam;
	m_List.AddString(*pMsg);
	delete pMsg;
	m_List.SetCurSel(m_List.GetCount()-1);
	return NULL;
}