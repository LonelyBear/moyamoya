/*
Document��
	ClassName:		CRenderTab
	Head File:		RenderTab.h
	Cpp File:		RenderTab.cpp
	Description��	������Ⱦ��ʾTab��ǩҳ
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once
#include "FileOperation.h"
#include "DataVisualization.h"
#include "MedData.h"
#define vtkRenderingCore_AUTOINIT 3(vtkInteractionStyle,vtkRenderingFreeType,vtkRenderingOpenGL2)
#define vtkRenderingVolume_AUTOINIT 1(vtkRenderingVolumeOpenGL2)
#include "vtkSmartPointer.h"
#include "vtkRenderer.h"
#include "vtkWin32OpenGLRenderWindow.h"
#include "vtkRenderWindowInteractor.h"
#include "vtkWin32RenderWindowInteractor.h"
#include "vtkMFCWindow.h"
#include "vtkInteractorStyleTrackballCamera.h"

// CRenderTab �Ի���

class CRenderTab : public CDialogEx
{
	DECLARE_DYNAMIC(CRenderTab)

public:
	CRenderTab(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CRenderTab();

// �Ի�������
	enum { IDD = IDD_TAB_RENDER };

public:
	//�����Ա
	CFileOperation *m_FileOperation;
	CDataVisualization *m_DataVisualization;
	CMedData *m_medData;
	CMedData *m_swiData;
	CMedData *m_mraData;
	//vtkSmartPointer<vtkRenderer> m_renderer;
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> m_renWin;
	vtkSmartPointer<vtkWin32RenderWindowInteractor> m_renWinInt;
	vtkSmartPointer<vtkInteractorStyleTrackballCamera> m_irenStyle;
	vtkMFCWindow *m_MFCwin;
	

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnClickedButtonLoadnifti();
	afx_msg void OnClickedButtonLoaddicom();
	afx_msg void OnClickedButtonDoublerender();
	virtual BOOL OnInitDialog();
private:
	// ��������vtk����Ⱦ����
	void renderWindowSet();

};
