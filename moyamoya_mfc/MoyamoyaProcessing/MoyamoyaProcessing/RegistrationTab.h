/*
Document��
	ClassName:		CRegistrationTab
	Head File:		RegistrationTab.h
	Cpp File:		RegistrationTab.cpp
	Description��	ͼ��������׼Tab��ǩҳ
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once


// CRegistrationTab �Ի���

class CRegistrationTab : public CDialogEx
{
	DECLARE_DYNAMIC(CRegistrationTab)

public:
	CRegistrationTab(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CRegistrationTab();

// �Ի�������
	enum { IDD = IDD_TAB_REGISTRATION };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
};
