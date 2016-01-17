#include "stdafx.h"
#include "afxinet.h"
#include "imagehlp.h"
#include <vector>
using namespace std;
#pragma comment(lib,"imagehlp.lib")

CString GetHtmlChCode(CString strHtmlComment)
{
	int iMetaPos = strHtmlComment.Find("<meta ");
	iMetaPos = strHtmlComment.Find("charset=",iMetaPos) + strlen("charset=");
	int iEnd = strHtmlComment.Find("\"",iMetaPos);
	CString strCode = strHtmlComment.Mid(iMetaPos,iEnd-iMetaPos);
	strCode.MakeLower();
	return strCode;
}
//UTF8����תΪ���ֽڱ��� 
CString UTF8ToMB(const char* pu8 )
{
	// convert an UTF8 string to widechar   
	int nLen = MultiByteToWideChar(CP_UTF8, 0, pu8, -1, NULL, 0);  

	WCHAR* lpszW = NULL;  
	try  
	{  
		lpszW = new WCHAR[nLen];  
	}  
	catch(std::bad_alloc &/*memExp*/)  
	{  
		return "";  
	}  

	int nRtn = MultiByteToWideChar(CP_UTF8, 0, pu8, -1, lpszW, nLen);  

	if(nRtn != nLen)  
	{  
		delete[] lpszW;  
		return "";  
	}  

	// convert an widechar string to Multibyte   
	int MBLen = WideCharToMultiByte(CP_ACP, 0, lpszW, nLen, NULL, 0, NULL, NULL);  
	if (MBLen <=0)  
	{  
		return "";  
	}	
	char *pmb = new char[MBLen+1];
	nRtn = WideCharToMultiByte(CP_ACP, 0, lpszW, nLen, pmb, MBLen, NULL, NULL);
	delete[] lpszW;  

	if(nRtn != MBLen)  
	{		
		delete pmb;
		return "";  
	}  

	CString str = pmb;
	delete pmb;
	return str;  
}

CString GetDownloadFileName(CHttpFile *pHttpFile )
{
	if (NULL==pHttpFile)
		return "";

	CString sContentDisposition;
	DWORD dwIndex = 0;
	BOOL bSuccess = pHttpFile->QueryInfo(HTTP_QUERY_CONTENT_DISPOSITION, sContentDisposition, &dwIndex);
	int iPosName = sContentDisposition.Find("filename=\"") + strlen("filename=\"");
	CString strName = sContentDisposition.Mid(iPosName); 
	int iPosEnd = strName.Find("\"");
	strName = strName.Left(iPosEnd);
	if (!strName.IsEmpty())
		printf("��ȡ�����ļ����ɹ�:%s\n",strName);
	return strName;
}


BOOL DownloadFile(CString strLocalDir,CString strUrl)
{
	CInternetSession session;  
	CHttpFile *pHttpFile = (CHttpFile *)session.OpenURL(strUrl);  

	DWORD dwStatusCode;  
	pHttpFile->QueryInfoStatusCode(dwStatusCode);  

	if(dwStatusCode != HTTP_STATUS_OK)
	{
		pHttpFile->Close();  
		session.Close(); 
		printf("��%s����ַ��Ч...\n",strUrl);
		return FALSE;
	}
	printf("���ص�ַ��%s\n",strUrl);
	
	 CString strFileLen;
	 pHttpFile->QueryInfo(HTTP_QUERY_CONTENT_LENGTH, strFileLen);
	 ULONGLONG iFileLen = _ttol(strFileLen);
	 printf("�����ļ���СΪ:%s\n",strFileLen);

	 CString strFileName = GetDownloadFileName(pHttpFile);
	 if (strFileName.IsEmpty())
	 {
		 strUrl.Replace("\\","/");
		 strFileName = strUrl.Mid(strUrl.ReverseFind('/')+1);
	 }
	 strLocalDir.Replace("/","\\");
	 if (strLocalDir.Right(1)!="\\")
	 {
		 strLocalDir.AppendChar('\\');
	 }
	 CString strDest = strLocalDir + strFileName;
	 printf("Ŀ���ļ��洢Ϊ:%s\n",strDest);

	 MakeSureDirectoryPathExists(strDest);
	CStdioFile imgFile;  
	imgFile.Open(strDest, CFile::modeCreate | CFile::modeWrite | CFile::typeBinary);

	int nReadBlockSize = 50*1024;
	char* pBuffer = new char[nReadBlockSize];

	ULONGLONG iSizeGet = 0;
	int size=0;  
	do {  
			size = pHttpFile->Read(pBuffer,nReadBlockSize);    // ��ȡͼƬ 
			imgFile.Write(pBuffer,size);  
			iSizeGet +=size;
			printf("���ؽ���Ϊ%2d%%\r",iSizeGet*100/iFileLen);
	}while(iSizeGet < iFileLen);  

	delete pBuffer;
	pHttpFile->Close();  
	session.Close();
	printf("\n�������\n");
	return TRUE;
}
BOOL DownloadHtml(CString & strDestHtml,CString strUrl,BOOL bIsFile,DWORD &dwHttpCode)
{
	CInternetSession session;  
	CHttpFile *pHttpFile = (CHttpFile *)session.OpenURL(strUrl);  

	DWORD dwStatusCode;  
	pHttpFile->QueryInfoStatusCode(dwStatusCode);  
	dwHttpCode = dwStatusCode;
	if(dwStatusCode != HTTP_STATUS_OK)
	{
		pHttpFile->Close();  
		session.Close();   
		return FALSE;
	}
	CString strHtmlConment;
	CString strLine;  
		while(pHttpFile->ReadString(strLine) != NULL)
			strHtmlConment += strLine;

	session.Close();  
	pHttpFile->Close();

	if (GetHtmlChCode(strHtmlConment)=="utf-8")
	{
		if(bIsFile)
		{
			MakeSureDirectoryPathExists(strDestHtml);
			CStdioFile fileHtml;
			fileHtml.Open(strDestHtml, CFile::modeCreate | CFile::modeWrite | CFile::typeText);
			fileHtml.WriteString(strHtmlConment);
			fileHtml.Close();
		}
		strHtmlConment = UTF8ToMB(strHtmlConment);
	}

	//printf("��ҳԴ��Ϊ��\n%s\n",strHtmlConment);
	//printf("�������ӡ�%s�����...\n",strUrl);
	if (!bIsFile)
		strDestHtml = strHtmlConment;

	return TRUE;
}