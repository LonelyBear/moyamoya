
// MoyamoyaProcessing.h : PROJECT_NAME Ӧ�ó������ͷ�ļ�
//

#pragma once

#ifndef __AFXWIN_H__
	#error "�ڰ������ļ�֮ǰ������stdafx.h�������� PCH �ļ�"
#endif

#include "resource.h"		// ������


// CMoyamoyaProcessingApp: 
// �йش����ʵ�֣������ MoyamoyaProcessing.cpp
//

class CMoyamoyaProcessingApp : public CWinApp
{
public:
	CMoyamoyaProcessingApp();

// ��д
public:
	virtual BOOL InitInstance();

// ʵ��

	DECLARE_MESSAGE_MAP()
};

extern CMoyamoyaProcessingApp theApp;