// MRATab.cpp : 实现文件
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "MRATab.h"
#include "afxdialogex.h"


// CMRATab 对话框

IMPLEMENT_DYNAMIC(CMRATab, CDialogEx)

CMRATab::CMRATab(CWnd* pParent /*=NULL*/)
	: CDialogEx(CMRATab::IDD, pParent)
{

}

CMRATab::~CMRATab()
{
}

void CMRATab::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CMRATab, CDialogEx)
END_MESSAGE_MAP()


// CMRATab 消息处理程序
