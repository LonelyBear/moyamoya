/*
Document：
	ClassName:		CMoyamoyaProcessingDlg
	Head File:		MoyamoyaProcessingDlg.h
	Cpp File:		MoyamoyaProcessingDlg.cpp
	Description：	实现整体对话框	
	Time:			20180202	10:32
	Author:			yang
*/ 


// MoyamoyaProcessingDlg.h : 头文件


#pragma once
#include"SWITab.h"
#include"MRATab.h"
#include"RenderTab.h"
#include"RegistrationTab.h"

// CMoyamoyaProcessingDlg 对话框
class CMoyamoyaProcessingDlg : public CDialogEx
{
// 构造
public:
	CMoyamoyaProcessingDlg(CWnd* pParent = NULL);	// 标准构造函数

// 对话框数据
	enum { IDD = IDD_MOYAMOYAPROCESSING_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV 支持




// 实现
protected:
	HICON m_hIcon;

	//tab控件对话框初始化
	CTabCtrl m_tab;
	int m_CurSelTab;
	CSWITab m_tab_swi;
	CMRATab m_tab_mra;
	CRegistrationTab m_tab_registration;
	CRenderTab m_tab_render;


	// 生成的消息映射函数
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	//对话框切换
	afx_msg void OnSelchangeTabMain(NMHDR *pNMHDR, LRESULT *pResult);
};
