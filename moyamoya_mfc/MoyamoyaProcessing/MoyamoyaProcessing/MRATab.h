/*
Document��
	ClassName:		CMRATab
	Head File:		MRATab.h
	Cpp File:		MRATab.cpp
	Description��	MRA���ݴ���Tab��ǩҳ
	Time:			20180202	10:32
	Author:			yang
*/
#pragma once


// CMRATab �Ի���

class CMRATab : public CDialogEx
{
	DECLARE_DYNAMIC(CMRATab)

public:
	CMRATab(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CMRATab();

// �Ի�������
	enum { IDD = IDD_TAB_MRA };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
};
