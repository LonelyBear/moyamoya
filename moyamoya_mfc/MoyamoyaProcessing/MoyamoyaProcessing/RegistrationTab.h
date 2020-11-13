/*
Document：
	ClassName:		CRegistrationTab
	Head File:		RegistrationTab.h
	Cpp File:		RegistrationTab.cpp
	Description：	图像数据配准Tab标签页
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once


// CRegistrationTab 对话框

class CRegistrationTab : public CDialogEx
{
	DECLARE_DYNAMIC(CRegistrationTab)

public:
	CRegistrationTab(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CRegistrationTab();

// 对话框数据
	enum { IDD = IDD_TAB_REGISTRATION };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
};
