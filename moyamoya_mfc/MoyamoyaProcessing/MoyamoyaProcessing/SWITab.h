/*
Document��
	ClassName:		CSWITab
	Head File:		SWITab.h
	Cpp File:		SWITab.cpp
	Description��	SWI���ݴ���Tab��ǩҳ
	Time:			20180202	10:32
	Author:			yang
*/
#pragma once


// CSWITab �Ի���

class CSWITab : public CDialogEx
{
	DECLARE_DYNAMIC(CSWITab)

public:
	CSWITab(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CSWITab();

// �Ի�������
	enum { IDD = IDD_TAB_SWI };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
};
