/*
Document��
	ClassName:		CMoyamoyaProcessingDlg
	Head File:		MoyamoyaProcessingDlg.h
	Cpp File:		MoyamoyaProcessingDlg.cpp
	Description��	ʵ������Ի���	
	Time:			20180202	10:32
	Author:			yang
*/ 


// MoyamoyaProcessingDlg.h : ͷ�ļ�


#pragma once
#include"SWITab.h"
#include"MRATab.h"
#include"RenderTab.h"
#include"RegistrationTab.h"

// CMoyamoyaProcessingDlg �Ի���
class CMoyamoyaProcessingDlg : public CDialogEx
{
// ����
public:
	CMoyamoyaProcessingDlg(CWnd* pParent = NULL);	// ��׼���캯��

// �Ի�������
	enum { IDD = IDD_MOYAMOYAPROCESSING_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV ֧��




// ʵ��
protected:
	HICON m_hIcon;

	//tab�ؼ��Ի����ʼ��
	CTabCtrl m_tab;
	int m_CurSelTab;
	CSWITab m_tab_swi;
	CMRATab m_tab_mra;
	CRegistrationTab m_tab_registration;
	CRenderTab m_tab_render;


	// ���ɵ���Ϣӳ�亯��
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	//�Ի����л�
	afx_msg void OnSelchangeTabMain(NMHDR *pNMHDR, LRESULT *pResult);
};
