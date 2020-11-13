// RegistrationTab.cpp : 实现文件
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "RegistrationTab.h"
#include "afxdialogex.h"


// CRegistrationTab 对话框

IMPLEMENT_DYNAMIC(CRegistrationTab, CDialogEx)

CRegistrationTab::CRegistrationTab(CWnd* pParent /*=NULL*/)
	: CDialogEx(CRegistrationTab::IDD, pParent)
{

}

CRegistrationTab::~CRegistrationTab()
{
}

void CRegistrationTab::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CRegistrationTab, CDialogEx)
END_MESSAGE_MAP()


// CRegistrationTab 消息处理程序
