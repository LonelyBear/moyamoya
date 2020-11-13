/*
Document：
	ClassName:		CFileOperation
	Head File:		FileOperation.h
	Cpp File:		FileOperation.cpp
	Description：	文件数据读写操作实现类
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once
#include "MedData.h"
#define vtkRenderingCore_AUTOINIT 3(vtkInteractionStyle,vtkRenderingFreeType,vtkRenderingOpenGL2)
#define vtkRenderingVolume_AUTOINIT 1(vtkRenderingVolumeOpenGL2)
#include "vtkSmartPointer.h"
#include "vtkNIFTIImageReader.h"
#include "vtkDICOMImageReader.h"
#include "vtkImageData.h"


struct medDataList
{
	CMedData *m_medData_1;
	CMedData *m_medData_2;
};

class CFileOperation
{
public:
	CFileOperation();
	~CFileOperation();

public:
	//类变量
	vtkSmartPointer<vtkNIFTIImageReader> m_niiReader;
	vtkSmartPointer<vtkDICOMImageReader> m_dicomReader;
	CMedData *m_medData;
	//融合显示
	vtkSmartPointer<vtkNIFTIImageReader> m_niiReader_2;
	CMedData *m_medData_2;


public:
	//读取体素数据
	CMedData* openNIfTI(CString filename);
	medDataList openDoubleNIfTI(CString filename_1, CString filename_2);
	CMedData* openDICOM(CString filename);
};

