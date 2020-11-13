/*
Document��
	ClassName:		CMedData
	Head File:		MedData.h
	Cpp File:		MedData.cpp
	Description��	ͼ������ģ����
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once
#define vtkRenderingCore_AUTOINIT 3(vtkInteractionStyle,vtkRenderingFreeType,vtkRenderingOpenGL2)
#define vtkRenderingVolume_AUTOINIT 1(vtkRenderingVolumeOpenGL2)
#include "vtkSmartPointer.h"
#include "vtkImageData.h"

class CMedData
{
public:
	CMedData();
	~CMedData();

protected:
	//�����
	vtkSmartPointer<vtkImageData>	m_vtk_volumeData;

public:
	//���Ա����
	void SetVtkVolumeData(vtkSmartPointer<vtkImageData>	m_volumeData);
	vtkSmartPointer<vtkImageData>	GetVtkVolumeData();
};

