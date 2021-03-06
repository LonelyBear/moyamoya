
// MoyamoyaProcessingDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "MoyamoyaProcessingDlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialogEx
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
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


// CMoyamoyaProcessingDlg 对话框



CMoyamoyaProcessingDlg::CMoyamoyaProcessingDlg(CWnd* pParent /*=NULL*/)
	: CDialogEx(CMoyamoyaProcessingDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CMoyamoyaProcessingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_TAB_MAIN, m_tab);
}

BEGIN_MESSAGE_MAP(CMoyamoyaProcessingDlg, CDialogEx)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_NOTIFY(TCN_SELCHANGE, IDC_TAB_MAIN, &CMoyamoyaProcessingDlg::OnSelchangeTabMain)
END_MESSAGE_MAP()


// CMoyamoyaProcessingDlg 消息处理程序

BOOL CMoyamoyaProcessingDlg::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// 将“关于...”菜单项添加到系统菜单中。

	// IDM_ABOUTBOX 必须在系统命令范围内。
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

	// 设置此对话框的图标。  当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	ShowWindow(SW_MAXIMIZE);

	// TODO:  在此添加额外的初始化代码

	// tab控件初始化
	m_tab.ShowWindow(SW_SHOWMAXIMIZED);
	m_tab.InsertItem(0, _T("SWI Processing"));
	m_tab.InsertItem(1, _T("MRA Processing"));
	m_tab.InsertItem(2, _T("Registration"));
	m_tab.InsertItem(3, _T("Render"));
	//获得TAB控件的坐标
	CRect rc;
	m_tab.GetClientRect(rc);
	//定位选项卡页的位置，这里可以根据情况自己调节偏移量
	rc.top += 0;
	rc.bottom -= 50;
	rc.left += 0;
	rc.right -= 0;
	//TAB页面
	m_tab_swi.Create(IDD_TAB_SWI, &m_tab);
	m_tab_mra.Create(IDD_TAB_MRA, &m_tab);
	m_tab_registration.Create(IDD_TAB_REGISTRATION, &m_tab);
	m_tab_render.Create(IDD_TAB_RENDER, &m_tab);
	//将子页面移动到指定的位置
	m_tab_swi.MoveWindow(&rc);
	m_tab_mra.MoveWindow(&rc);
	m_tab_registration.MoveWindow(&rc);
	m_tab_render.MoveWindow(&rc);
	//显示子页面
	//显示初始页面
	m_tab_swi.ShowWindow(SW_SHOW);
	m_tab_mra.ShowWindow(SW_HIDE);
	m_tab_registration.ShowWindow(SW_HIDE);
	m_tab_render.ShowWindow(SW_HIDE);
	//保存当前选择
	m_CurSelTab = 0;
	m_tab.SetCurSel(m_CurSelTab);
	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

void CMoyamoyaProcessingDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。  对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CMoyamoyaProcessingDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialogEx::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CMoyamoyaProcessingDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMoyamoyaProcessingDlg::OnSelchangeTabMain(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO:  在此添加控件通知处理程序代码	
	m_CurSelTab = m_tab.GetCurSel();
	switch (m_CurSelTab)
	{
	case 0:
		m_tab_swi.ShowWindow(SW_SHOW);
		m_tab_mra.ShowWindow(SW_HIDE);
		m_tab_registration.ShowWindow(SW_HIDE);
		m_tab_render.ShowWindow(SW_HIDE);
		break;
	case 1:
		m_tab_swi.ShowWindow(SW_HIDE);
		m_tab_mra.ShowWindow(SW_SHOW);
		m_tab_registration.ShowWindow(SW_HIDE);
		m_tab_render.ShowWindow(SW_HIDE);
		break;
	case 2:
		m_tab_swi.ShowWindow(SW_HIDE);
		m_tab_mra.ShowWindow(SW_HIDE);
		m_tab_registration.ShowWindow(SW_SHOW);
		m_tab_render.ShowWindow(SW_HIDE);
		break;
	case 3:
		m_tab_swi.ShowWindow(SW_HIDE);
		m_tab_mra.ShowWindow(SW_HIDE);
		m_tab_registration.ShowWindow(SW_HIDE);
		m_tab_render.ShowWindow(SW_SHOW);
		break;
	default:
		;
	}
	*pResult = 0;
}
