// RenderTab.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "MoyamoyaProcessing.h"
#include "RenderTab.h"
#include "afxdialogex.h"


// CRenderTab �Ի���

IMPLEMENT_DYNAMIC(CRenderTab, CDialogEx)

CRenderTab::CRenderTab(CWnd* pParent /*=NULL*/)
	: CDialogEx(CRenderTab::IDD, pParent)
{
	m_FileOperation = NULL;
	m_DataVisualization = NULL;
	m_medData = NULL;
	m_swiData = NULL;
	m_mraData = NULL;
	//m_renderer = NULL;
	m_renWin = NULL;
	m_renWinInt = NULL;
	m_MFCwin = NULL;
}

CRenderTab::~CRenderTab()
{
	delete m_MFCwin;
}

void CRenderTab::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CRenderTab, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON_LOADNIFTI, &CRenderTab::OnClickedButtonLoadnifti)
	ON_BN_CLICKED(IDC_BUTTON_LOADDICOM, &CRenderTab::OnClickedButtonLoaddicom)
	ON_BN_CLICKED(IDC_BUTTON_DOUBLERENDER, &CRenderTab::OnClickedButtonDoublerender)
END_MESSAGE_MAP()


// CRenderTab ��Ϣ�������
void CRenderTab::OnClickedButtonLoadnifti()
{
	// TODO:  �ڴ���ӿؼ�֪ͨ����������
	CString filename;
	CFileDialog dlg(TRUE, NULL, NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,
		(LPCTSTR)_TEXT("NIfTI Files (*.nii)|*.nii|All Files (*.*)|*.*||"),
		NULL);
	if (dlg.DoModal() == IDOK)
	{
		filename = dlg.GetPathName();
	}
	AfxMessageBox("NIfTI�ļ�·��\t" + filename);
	if (filename == "")
	{
		return;
	}
	if (m_FileOperation != NULL)
	{
		delete m_FileOperation;
		m_FileOperation = NULL;
	}
	if (m_DataVisualization != NULL)
	{
		delete m_DataVisualization;
		m_DataVisualization = NULL;
	}
	if (m_medData != NULL)
	{
		delete m_medData;
		m_medData = NULL;
	}
	m_medData = new CMedData;
	m_FileOperation = new CFileOperation;
	m_medData = m_FileOperation->openNIfTI(filename);
	m_DataVisualization = new CDataVisualization;
	m_DataVisualization->m_renWin = m_DataVisualization->volumeMIPRender(m_medData);
//	m_DataVisualization->m_renWin = m_DataVisualization->volumeComRender(m_medData);
	renderWindowSet();
}


void CRenderTab::OnClickedButtonLoaddicom()
{
	// TODO:  �ڴ���ӿؼ�֪ͨ����������

	// ���ļ��жԻ��򲢶�ȡ·��
	TCHAR           szFolderPath[MAX_PATH] = { 0 };
	CString         strFolderPath = TEXT("");
	BROWSEINFO      sInfo;
	::ZeroMemory(&sInfo, sizeof(BROWSEINFO));
	sInfo.pidlRoot = 0;
	sInfo.lpszTitle = _T("��ѡ��DICOM�ļ���·��");
	sInfo.ulFlags = BIF_RETURNONLYFSDIRS | BIF_EDITBOX | BIF_DONTGOBELOWDOMAIN;
	sInfo.lpfn = NULL;
	// ��ʾ�ļ���ѡ��Ի���  
	LPITEMIDLIST lpidlBrowse = ::SHBrowseForFolder(&sInfo);
	if (lpidlBrowse != NULL)
	{
		if (::SHGetPathFromIDList(lpidlBrowse, szFolderPath))
		{
			strFolderPath = szFolderPath;
		}
	}
	if (lpidlBrowse != NULL)
	{
		::CoTaskMemFree(lpidlBrowse);
	}
	AfxMessageBox("DICOM�ļ���·��\t" + strFolderPath);
	if (strFolderPath == "")
	{
		return;
	}

	if (m_FileOperation != NULL)
	{
		delete m_FileOperation;
		m_FileOperation = NULL;
	}
	if (m_DataVisualization != NULL)
	{
		delete m_DataVisualization;
		m_DataVisualization = NULL;
	}
	if (m_medData != NULL)
	{
		delete m_medData;
		m_medData = NULL;
	}
	m_medData = new CMedData;
	m_FileOperation = new CFileOperation;
	m_medData = m_FileOperation->openDICOM(strFolderPath);
	m_DataVisualization = new CDataVisualization;
	m_DataVisualization->m_renWin = m_DataVisualization->sliceImageShow(m_medData);
	renderWindowSet();
}


BOOL CRenderTab::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// TODO:  �ڴ���Ӷ���ĳ�ʼ��
	// ���ó�ʼ��Ⱦ����
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWinInt = vtkSmartPointer<vtkWin32RenderWindowInteractor>::New();
	m_irenStyle = vtkSmartPointer<vtkInteractorStyleTrackballCamera>::New();
	m_MFCwin = new vtkMFCWindow(this->GetDlgItem(IDC_WINDOW_RENDER));
	/*
	CWnd *render_window;
	render_window = this->GetDlgItem(IDC_WINDOW_RENDER);
	HWND hWnd = (HWND)render_window->m_hWnd;
	HWND hParent = ::GetParent(hWnd);
	m_renWin->SetParentId(this->m_hWnd);
	*/
	m_renWinInt->SetRenderWindow(m_renWin);
	m_renWinInt->SetInteractorStyle(m_irenStyle);
	m_MFCwin->SetRenderWindow(m_renWin);
	
	return TRUE;  // return TRUE unless you set the focus to a control
	// �쳣:  OCX ����ҳӦ���� FALSE
}


// ��������vtk����Ⱦ����
void CRenderTab::renderWindowSet()
{

	m_renWin = m_DataVisualization->m_renWin;
	m_renWinInt->SetRenderWindow(m_renWin);
	m_renWinInt->SetInteractorStyle(m_irenStyle);
	m_MFCwin->SetRenderWindow(m_renWin);
	m_MFCwin->RedrawWindow();

}





void CRenderTab::OnClickedButtonDoublerender()
{
	// TODO:  �ڴ���ӿؼ�֪ͨ����������
	AfxMessageBox("��ѡ�����Ѫ������������\n��ѡ����Ѫ����������");
	//ѡ���һ����������
	CString swiFileName;
	CString mraFileName;
	CFileDialog dlg_1(TRUE, NULL, "����SWI��������nii", OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,
		(LPCTSTR)_TEXT("NIfTI Files (*.nii)|*.nii|All Files (*.*)|*.*||"),
		NULL);
	if (dlg_1.DoModal() == IDOK)
	{
		swiFileName = dlg_1.GetPathName();
	}
	AfxMessageBox("��Ѫ����NIfTI�ļ�·��\t" + swiFileName);
	if (swiFileName == "")
	{
		return;
	}

	//ѡ��ڶ�����������
	CFileDialog dlg_2(TRUE, NULL, "����MRA��������nii", OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,
		(LPCTSTR)_TEXT("NIfTI Files (*.nii)|*.nii|All Files (*.*)|*.*||"),
		NULL);
	if (dlg_2.DoModal() == IDOK)
	{
		mraFileName = dlg_2.GetPathName();
	}
	AfxMessageBox("Ѫ��ģ��NIfTI�ļ�·��\t" + mraFileName);
	if (mraFileName == "")
	{
		return;
	}

	if (m_FileOperation != NULL)
	{
		delete m_FileOperation;
		m_FileOperation = NULL;
	}
	if (m_DataVisualization != NULL)
	{
		delete m_DataVisualization;
		m_DataVisualization = NULL;
	}
	if (m_mraData != NULL)
	{
		delete m_mraData;
		m_mraData = NULL;
	}
	if (m_swiData != NULL)
	{
		delete m_swiData;
		m_swiData = NULL;
	}
	m_mraData = new CMedData;
	m_swiData = new CMedData;
	m_FileOperation = new CFileOperation;
	/*
	m_swiData = m_FileOperation->openNIfTI(swiFileName);
	m_mraData = m_FileOperation->openNIfTI(mraFileName);
	*/
	medDataList list = m_FileOperation->openDoubleNIfTI(swiFileName, mraFileName);
	m_swiData = list.m_medData_1;
	m_mraData = list.m_medData_2;
	m_DataVisualization = new CDataVisualization;
//	m_DataVisualization->m_renderer = m_DataVisualization->volumeMIPRender(m_mraData);
	m_DataVisualization->m_renWin = m_DataVisualization->doubleVolumeRender(m_swiData, m_mraData);
	renderWindowSet();
}
