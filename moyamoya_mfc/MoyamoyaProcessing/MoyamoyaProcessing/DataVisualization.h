/*
Document：
	ClassName:		CDataVisualization
	Head File:		DataVisualization.h
	Cpp File:		DataVisualization.cpp
	Description：	图像数据渲染功能实现类
	Time:			20180202	10:32
	Author:			yang
*/

#pragma once
#include "MedData.h"
#define vtkRenderingCore_AUTOINIT 3(vtkInteractionStyle,vtkRenderingFreeType,vtkRenderingOpenGL2)
#define vtkRenderingVolume_AUTOINIT 1(vtkRenderingVolumeOpenGL2)
#include "vtkSmartPointer.h"
#include "vtkImageData.h"
#include "vtkActor.h"
#include "vtkRenderer.h"
#include "vtkRenderWindow.h"
#include "vtkRenderWindowInteractor.h"
#include "vtkWin32OpenGLRenderWindow.h"
#include "vtkMFCWindow.h"
#include "vtkImageCast.h"
#include "vtkVolumeProperty.h"
#include "vtkColorTransferFunction.h"
#include "vtkVolume.h"
#include "vtkRenderWindowInteractor.h"
#include "vtkImageViewer2.h"
#include "vtkImageActor.h"
#include "vtkPiecewiseFunction.h"
#include "vtkColorTransferFunction.h"
#include "vtkVolumeProperty.h"
#include "vtkGPUVolumeRayCastMapper.h"
#include "vtkFixedPointVolumeRayCastMapper.h"
class CDataVisualization
{
public:
	CDataVisualization();
	~CDataVisualization();

public:
	//成员变量
	//vtkSmartPointer<vtkRenderer> m_renderer;
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> m_renWin;
	CMedData *m_medData;
public:
	//MIP volume render
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> volumeMIPRender(CMedData *m_medData);
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> volumeComRender(CMedData *m_medData);
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> sliceImageShow(CMedData *m_medData);
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> doubleVolumeRender(CMedData *m_swiData, CMedData *m_mraData);
	vtkSmartPointer<vtkWin32OpenGLRenderWindow> volumeFixedPointRender(CMedData *m_medData);
};

