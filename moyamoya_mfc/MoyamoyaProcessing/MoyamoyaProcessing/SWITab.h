/*
Document：
	ClassName:		CSWITab
	Head File:		SWITab.h
	Cpp File:		SWITab.cpp
	Description：	SWI数据处理Tab标签页
	Time:			20180202	10:32
	Author:			yang
*/
#pragma once


// CSWITab 对话框

class CSWITab : public CDialogEx
{
	DECLARE_DYNAMIC(CSWITab)

public:
	CSWITab(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CSWITab();

// 对话框数据
	enum { IDD = IDD_TAB_SWI };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
};
