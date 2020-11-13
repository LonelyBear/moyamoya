/*
Document：
	ClassName:		CMRATab
	Head File:		MRATab.h
	Cpp File:		MRATab.cpp
	Description：	MRA数据处理Tab标签页
	Time:			20180202	10:32
	Author:			yang
*/
#pragma once


// CMRATab 对话框

class CMRATab : public CDialogEx
{
	DECLARE_DYNAMIC(CMRATab)

public:
	CMRATab(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CMRATab();

// 对话框数据
	enum { IDD = IDD_TAB_MRA };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
};
