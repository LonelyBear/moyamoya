
// MoyamoyaProcessingDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "MoyamoyaProcessingDlg.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// ����Ӧ�ó��򡰹��ڡ��˵���� CAboutDlg �Ի���

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


// CMoyamoyaProcessingDlg �Ի���



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


// CMoyamoyaProcessingDlg ��Ϣ�������

BOOL CMoyamoyaProcessingDlg::OnInitDialog()
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

	// ���ô˶Ի����ͼ�ꡣ  ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	ShowWindow(SW_MAXIMIZE);

	// TODO:  �ڴ���Ӷ���ĳ�ʼ������

	// tab�ؼ���ʼ��
	m_tab.ShowWindow(SW_SHOWMAXIMIZED);
	m_tab.InsertItem(0, _T("SWI Processing"));
	m_tab.InsertItem(1, _T("MRA Processing"));
	m_tab.InsertItem(2, _T("Registration"));
	m_tab.InsertItem(3, _T("Render"));
	//���TAB�ؼ�������
	CRect rc;
	m_tab.GetClientRect(rc);
	//��λѡ�ҳ��λ�ã�������Ը�������Լ�����ƫ����
	rc.top += 0;
	rc.bottom -= 50;
	rc.left += 0;
	rc.right -= 0;
	//TABҳ��
	m_tab_swi.Create(IDD_TAB_SWI, &m_tab);
	m_tab_mra.Create(IDD_TAB_MRA, &m_tab);
	m_tab_registration.Create(IDD_TAB_REGISTRATION, &m_tab);
	m_tab_render.Create(IDD_TAB_RENDER, &m_tab);
	//����ҳ���ƶ���ָ����λ��
	m_tab_swi.MoveWindow(&rc);
	m_tab_mra.MoveWindow(&rc);
	m_tab_registration.MoveWindow(&rc);
	m_tab_render.MoveWindow(&rc);
	//��ʾ��ҳ��
	//��ʾ��ʼҳ��
	m_tab_swi.ShowWindow(SW_SHOW);
	m_tab_mra.ShowWindow(SW_HIDE);
	m_tab_registration.ShowWindow(SW_HIDE);
	m_tab_render.ShowWindow(SW_HIDE);
	//���浱ǰѡ��
	m_CurSelTab = 0;
	m_tab.SetCurSel(m_CurSelTab);
	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
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

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ  ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CMoyamoyaProcessingDlg::OnPaint()
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
HCURSOR CMoyamoyaProcessingDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}



void CMoyamoyaProcessingDlg::OnSelchangeTabMain(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO:  �ڴ���ӿؼ�֪ͨ����������	
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
