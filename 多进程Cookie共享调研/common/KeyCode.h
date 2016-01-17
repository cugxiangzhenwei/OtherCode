//�ؼ�ʵ�ִ���
#pragma once

#include "wininet.h"

//VS2008�е�wininet.hû�������˱�־��ʵ���ǿ��õ�
#ifndef INTERNET_COOKIE_HTTPONLY
#define INTERNET_COOKIE_HTTPONLY        0x00002000
#endif

//�ýṹ�����ڴ�A���̷���InternetSetCookieExW��Ҫ�����в������ݵ�B����
struct CookieData
{
	DWORD dwSizeUrl;
	DWORD dwSizeCookieName;
	DWORD dwSizeCookieData;		//�����ַ������Ե��ڴ�ռ�ô�С������ĩβ��0x0000�����ֽ�Ϊ��λ
	DWORD  dwProcessId;
	DWORD dwFlags;
	DWORD_PTR dwReserved;
	char pStrData[1];			//�������飬�����ַ��������ݰ�˳�������ڸ��ֽں�
};

typedef struct 
{
	CStringW strHost;
	CStringW strHeaders;
	bool bSaveToList;
}ThreadDataSendCookie;

typedef BOOL (__stdcall *Proc_HttpQueryInfoW)(HINTERNET hRequest, DWORD dwInfoLevel,
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex);

typedef BOOL (__stdcall *Proc_HttpQueryInfoA)(HINTERNET hRequest, DWORD dwInfoLevel,
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex);

//��HttpQueryInfoW���API����Hook�������Լ���������Hook_HttpQueryInfoW������
//��ΪIE��ͨ��HttpQueryInfoW����ȡHTTP��Ӧͷ�ģ��Ӷ���ȡ��Ӧͷ�е�Cookie
//�������ش�API�󣬿��԰ѻ�õ�����Cookie����B���̽�������
//�������Ч�����⣬����ֻ�ѻỰ��Cookie����B���̽������ã��־û�Cookie���ڱ����Ѿ����Կ���̹������÷���B����
//����ֻ��һ���򵥵�Demo������һ���Եİ�����Cookie����B���̽�������
BOOL __stdcall Hook_HttpQueryInfoW(HINTERNET hRequest, DWORD dwInfoLevel, 
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex);

BOOL __stdcall Hook_HttpQueryInfoA(HINTERNET hRequest, DWORD dwInfoLevel, 
	LPVOID lpBuffer, LPDWORD lpdwBufferLength, LPDWORD lpdwIndex);

//��һ����Ӧͷ�е�����Cookie����B���̣�����1����ͷ��Ӧ����վHOST������2��������Ӧͷ������
bool SendCookieToShare(const CStringW &strHost, const CStringW &strHeaders,bool bSaveToList = false);


//����SendCookieToShare�ڲ��ĸ�����������һ��Cookie�����CookieData�ṹ�岢���͵�B����
//����1����Cookie��Ӧ����վURL������2��Cookie�����ݣ�����3������Cookie�Ƿ���HttpOnly��
void PackCookieDataToSend(LPCWSTR pwszUrl, LPCWSTR pwszCookieData, bool IsHttpOnly);