#include "stdafx.h"
#include "KeyCode.h"
#include "APIHook.h"
#include "UsrDefine.h"
#include "StlHeader.h"

vector<CookiePair> m_HostCookieHistoryList;
CRITICAL_SECTION   g_CookieListCS;

//ʹ��CAPIHook��Hook  HttpQueryInfoW��Hook_HttpQueryInfoW
//CAPIHook����APIhook.h���ǡ�Windows���ı�̡����и����Ĵ��룬����Hook API
//��ʵ����Ŀ�п��Ը�����Ҫ�����вü�CAPIHook
CAPIHook sm_InternetSetCookieExW("WININET.DLL", "HttpQueryInfoW", reinterpret_cast<PROC>(Hook_HttpQueryInfoW));

CAPIHook sm_InternetSetCookieExA("WININET.DLL", "HttpQueryInfoA", reinterpret_cast<PROC>(Hook_HttpQueryInfoA));


BOOL __stdcall Hook_HttpQueryInfoW(HINTERNET hRequest, DWORD dwInfoLevel, 
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex)
{
	//��ȡHttpQueryInfoW����ʵ��ַ
	static const Proc_HttpQueryInfoW RealAddr_HttpQueryInfoW = 
		reinterpret_cast<Proc_HttpQueryInfoW>(::GetProcAddress(GetModuleHandle("WININET.DLL"), "HttpQueryInfoW"));
	//������ʵ��HttpQueryInfoW
	BOOL bRet = RealAddr_HttpQueryInfoW(hRequest, dwInfoLevel, lpBuffer, lpdwBufferLength, lpdwIndex);
	//�����Ӧͷ������
	if (dwInfoLevel == HTTP_QUERY_RAW_HEADERS_CRLF)	//IE����ͨ���˱�־ȡ��������Ӧͷ���Ӷ���ȡ��Set-Cookie:������
	{
		CStringW strHeaders(static_cast<wchar_t*>(lpBuffer));
		//�����Set-Cookie:�Ŵ���û�еĻ�˵�������Ӧͷ������Cookie��ֱ�Ӻ���
		if (strHeaders.Find(L"Set-Cookie:") != -1)
		{
			//������Ӧͷ�����ˣ����������Ӧͷ���Cookie���ĸ���վ�ģ�
			//��������Ҫ��hRequest���������ٴε���HttpQueryInfoW��ѯ�����Ӧͷ��Ӧ������ͷ�����HOST���ݣ���֪�����ĸ���վ��
			//֪����HOST������ΪB���̵���InternetSetCookieExW�������Cookieʱ�ṩ��һ������LPCWSTR lpszUrl
			wchar_t *pwszHost = new wchar_t[500];
			DWORD dwBuffSize = sizeof(wchar_t) * 500;
			memset(pwszHost, 0 , dwBuffSize);
			if (RealAddr_HttpQueryInfoW(hRequest, HTTP_QUERY_FLAG_REQUEST_HEADERS | HTTP_QUERY_HOST, pwszHost, &dwBuffSize, NULL))
				SendCookieToShare(pwszHost, strHeaders,true);		//�����ͷ���Cookie����B����
			delete [] pwszHost;
			pwszHost = NULL;
		}
	}
	return bRet;
}
BOOL __stdcall Hook_HttpQueryInfoA(HINTERNET hRequest, DWORD dwInfoLevel, 
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex)
{
	//��ȡHttpQueryInfoW����ʵ��ַ
	static const Proc_HttpQueryInfoA RealAddr_HttpQueryInfoA = 
		reinterpret_cast<Proc_HttpQueryInfoA>(::GetProcAddress(GetModuleHandle("WININET.DLL"), "HttpQueryInfoA"));
	//������ʵ��HttpQueryInfoW
	BOOL bRet = RealAddr_HttpQueryInfoA(hRequest, dwInfoLevel, lpBuffer, lpdwBufferLength, lpdwIndex);
	//�����Ӧͷ������
	if (dwInfoLevel == HTTP_QUERY_RAW_HEADERS_CRLF)	//IE����ͨ���˱�־ȡ��������Ӧͷ���Ӷ���ȡ��Set-Cookie:������
	{
		CString strHeaders(static_cast<char*>(lpBuffer));
		//�����Set-Cookie:�Ŵ���û�еĻ�˵�������Ӧͷ������Cookie��ֱ�Ӻ���
		if (strHeaders.Find("Set-Cookie:") != -1)
		{
			//������Ӧͷ�����ˣ����������Ӧͷ���Cookie���ĸ���վ�ģ�
			//��������Ҫ��hRequest���������ٴε���HttpQueryInfoW��ѯ�����Ӧͷ��Ӧ������ͷ�����HOST���ݣ���֪�����ĸ���վ��
			//֪����HOST������ΪB���̵���InternetSetCookieExW�������Cookieʱ�ṩ��һ������LPCWSTR lpszUrl
			char *pwszHost = new char[500];
			DWORD dwBuffSize = sizeof(char) * 500;
			memset(pwszHost, 0 , dwBuffSize);
			if (RealAddr_HttpQueryInfoA(hRequest, HTTP_QUERY_FLAG_REQUEST_HEADERS | HTTP_QUERY_HOST, pwszHost, &dwBuffSize, NULL))
			{
				CStringW strHost = (wchar_t*)_bstr_t(pwszHost);
				CStringW strHeadersW = (wchar_t*)_bstr_t(strHeaders);
				SendCookieToShare(strHost, strHeadersW,true);		//�����ͷ���Cookie����B����
			}
			delete [] pwszHost;
			pwszHost = NULL;
		}
	}
	return bRet;
}
DWORD WINAPI ThreadFunSendCookie(LPVOID pData)
{
	ThreadDataSendCookie *pSendData = (ThreadDataSendCookie*)(pData);
	CStringW strHost = pSendData->strHost;
	CStringW strHeaders = pSendData->strHeaders;
	bool bSaveToList = pSendData->bSaveToList;
	delete pSendData;

	const CStringW strUrl = L"http://" + strHost + L"/";

	int nPosL = 0, nPosR = 0;
	CStringW strTempW;		//����ÿһ��Cookie������
	bool IsHttpOnly;		//����Cookie�Ƿ���HttpOnly��
	//��һ��ѭ����ȡ�������Ӧͷ�е�����Set-Cookie:�е�Cookie����
	while (nPosL != -1)
	{
		nPosL = strHeaders.Find(L"Set-Cookie: ", nPosR);
		if (nPosL == -1)
			break;
		nPosL += wcslen(L"Set-Cookie: ");
		nPosR = strHeaders.Find(L"\r\n", nPosL);
		if (nPosR == -1)
			break;
		strTempW = strHeaders.Mid(nPosL, nPosR - nPosL);
		//����Ƿ���HttpOnly��Cookie������ǵĻ���B�����е���InternetSetCookieExW����Cookieʱ
		//���ĸ�����DWORD dwFlagsӦΪINTERNET_COOKIE_HTTPONLY
		if (strTempW.Find(L"HttpOnly") != -1)
			IsHttpOnly = true;
		else
			IsHttpOnly = false;
		//��������Cookie������B
		PackCookieDataToSend(strUrl, strTempW, IsHttpOnly);
	}

	if(bSaveToList)
	{
		CookiePair cp;
		cp.m_strHost = strHost;
		cp.m_strValue = strHeaders;
		EnterCriticalSection(&g_CookieListCS);
		if (m_HostCookieHistoryList.size() > MAX_COOKIE_SETS_COUNT)
			m_HostCookieHistoryList.erase(m_HostCookieHistoryList.begin());

		m_HostCookieHistoryList.push_back(cp);
		LeaveCriticalSection(&g_CookieListCS);
	}
	return 0;
}
bool SendCookieToShare(const CStringW &strHost, const CStringW &strHeaders,bool bSaveToList)
{
	//���Cookie��Ӧ����վURL������B������InternetSetCookieExW�ĵ�һ������LPCWSTR lpszUrl

	ThreadDataSendCookie * pThreadParam = new ThreadDataSendCookie;
	pThreadParam->strHost = strHost;
	pThreadParam->strHeaders = strHeaders;
	pThreadParam->bSaveToList = bSaveToList;
	CreateThread(NULL,0,ThreadFunSendCookie,pThreadParam,0,NULL);
	return true;

}

void PackCookieDataToSend(LPCWSTR pwszUrl, LPCWSTR pwszCookieData, bool IsHttpOnly)
{
	//���pwszUrl��pwszCookieData�����ַ�����ռ�ڴ��С
	DWORD dwSizeUrl = (wcslen(pwszUrl) + 1) * 2;
	DWORD dwSizeCookieData = (wcslen(pwszCookieData) + 1) * 2;
	DWORD dwTotalSize = sizeof(CookieData) + dwSizeUrl + dwSizeCookieData ;	//Ҫ���͵������ܴ�С

	void *pBuffer = malloc(dwTotalSize);
	memset(pBuffer, 0, dwTotalSize);

	CookieData *pData = static_cast<CookieData*>(pBuffer);
	pData->dwSizeUrl = dwSizeUrl;
	pData->dwSizeCookieName = 0;		//CookieNameΪ�գ����������InternetSetCookieExW��һ�㲻�ã�ֱ����CookieData�ṩCookie��
	pData->dwSizeCookieData = dwSizeCookieData;
	pData->dwProcessId = GetCurrentProcessId();
	//�����HttpOnly��Cookie����Ҫ���ϸñ�־
	if (IsHttpOnly)
		pData->dwFlags = INTERNET_COOKIE_HTTPONLY;
	else
		pData->dwFlags = NULL;
	pData->dwReserved = NULL;
	//���������ַ��������ݵ��ṹ��β������������
	char *pTempChar = pData->pStrData;
	memcpy(pTempChar, pwszUrl, dwSizeUrl);
	pTempChar += dwSizeUrl;
	memcpy(pTempChar, pwszCookieData,dwSizeCookieData);
	pTempChar = NULL;
	pData = NULL;

	COPYDATASTRUCT stCopyData = {0};
	stCopyData.cbData = dwTotalSize;
	stCopyData.lpData = pBuffer;
	stCopyData.dwData = WM_CD_SETCOOKIE;

	CWnd * pDeskTopWnd = CWnd::GetDesktopWindow();
	CWnd *pFind = pDeskTopWnd->GetWindow(GW_CHILD);
	while(pFind)
	{
		if (::GetProp(pFind->GetSafeHwnd(),"use_hook_cookie"))
		{
				//ͨ��WM_COPYDATA�����ݷ�����һ������
			::SendMessage(pFind->GetSafeHwnd(), WM_COPYDATA, 
				reinterpret_cast<WPARAM>(AfxGetMainWnd()->GetSafeHwnd()),
				reinterpret_cast<LPARAM>(&stCopyData));
		}

		pFind = pFind->GetWindow(GW_HWNDNEXT);
	}
	
	free(pBuffer);
	pBuffer = NULL;
}