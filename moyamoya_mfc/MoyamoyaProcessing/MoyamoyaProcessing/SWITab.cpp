// SWITab.cpp : 实现文件
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "SWITab.h"
#include "afxdialogex.h"


// CSWITab 对话框

IMPLEMENT_DYNAMIC(CSWITab, CDialogEx)

CSWITab::CSWITab(CWnd* pParent /*=NULL*/)
	: CDialogEx(CSWITab::IDD, pParent)
{

}

CSWITab::~CSWITab()
{
}

void CSWITab::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CSWITab, CDialogEx)
END_MESSAGE_MAP()


// CSWITab 消息处理程序
