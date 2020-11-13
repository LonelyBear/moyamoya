#include "stdafx.h"
#include "DataVisualization.h"


CDataVisualization::CDataVisualization()
{
	m_medData = NULL;
	//m_renderer = NULL;
	m_renWin = NULL;
}


CDataVisualization::~CDataVisualization()
{
}

vtkSmartPointer<vtkWin32OpenGLRenderWindow> CDataVisualization::volumeMIPRender(CMedData *m_medData)
{
	//Image Data type Casting Filter.
	vtkSmartPointer<vtkImageCast> m_imageCast = vtkSmartPointer<vtkImageCast>::New();
	m_imageCast->SetInputData(m_medData->GetVtkVolumeData());
	m_imageCast->SetOutputScalarTypeToUnsignedChar();
	m_imageCast->Update();

	// Create transfer mapping scalar value to opacity 线性插值不透明度传输函数
	vtkSmartPointer<vtkPiecewiseFunction> m_opacityTransferFunction = vtkSmartPointer<vtkPiecewiseFunction>::New();
	m_opacityTransferFunction->AddPoint(70, 0.0);
	m_opacityTransferFunction->AddPoint(90, 0.2);
	m_opacityTransferFunction->AddPoint(180,0.6);

	//Create transfer mapping scalar value to color
	vtkSmartPointer<vtkColorTransferFunction> m_VolumePropertyColor = vtkSmartPointer<vtkColorTransferFunction>::New();
	
	m_VolumePropertyColor->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(190.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(220.0, 0.0, 0.0, 1.0);
	/*
	m_VolumePropertyColor->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(128.0, 0.0, 0.0, 1.0);
	m_VolumePropertyColor->AddRGBPoint(192.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(255.0, 1.0, 0.2, 0.0);
	*/ 
	//define  Volume Property  The property describes how the data will look
	vtkSmartPointer<vtkVolumeProperty> m_VolumeProperty = vtkSmartPointer<vtkVolumeProperty>::New();
	m_VolumeProperty->SetInterpolationTypeToLinear();
	m_VolumeProperty->ShadeOn();
	m_VolumeProperty->SetAmbient(1.0);
	m_VolumeProperty->SetDiffuse(1.0);
	m_VolumeProperty->SetSpecular(1.0);
//	m_VolumeProperty->SetScalarOpacity(m_opacityTransferFunction);
	m_VolumeProperty->SetColor(m_VolumePropertyColor);

	//#The mapper / ray cast function know how to render the data
	//vtkVolumeRayCastMapper 是8版本之前的api 但是在8.1后被vtkGPUVolumeRayCastMapper  vtkFixedPointVolumeRayCastMapper 两个函数代替了，不暴露了
	vtkSmartPointer<vtkGPUVolumeRayCastMapper> m_volumeMapper = vtkSmartPointer<vtkGPUVolumeRayCastMapper>::New();
	m_volumeMapper->SetInputConnection(m_imageCast->GetOutputPort());
	m_volumeMapper->SetBlendModeToMaximumIntensity();//定义渲染方式SetBlendModeTo xxx 进行切换 vtkGPUVolumeRayCastMapper提供给用户的接口

	//volume  与actor 类似
	vtkSmartPointer<vtkVolume> m_volume = vtkSmartPointer<vtkVolume>::New();
	m_volume->SetMapper(m_volumeMapper);
	m_volume->SetProperty(m_VolumeProperty);

	//Render
	vtkSmartPointer<vtkRenderer> m_renderer = vtkSmartPointer<vtkRenderer>::New();
	m_renderer->AddVolume(m_volume);
	//m_renderer->SetBackground(0.1, 0.2, 0.4);
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWin->AddRenderer(m_renderer);
	return m_renWin;

}
vtkSmartPointer<vtkWin32OpenGLRenderWindow> CDataVisualization::sliceImageShow(CMedData *m_medData)
{
	vtkSmartPointer<vtkImageActor> m_imageActor = vtkSmartPointer<vtkImageActor>::New();
	//vtkImageActor *m_imageActor = vtkImageActor::New();
	m_imageActor->SetInputData(m_medData->GetVtkVolumeData());
	m_imageActor->SetScale(10);
	vtkSmartPointer<vtkRenderer> m_renderer = vtkSmartPointer<vtkRenderer>::New();
	m_renderer->AddActor(m_imageActor);
	m_renderer->SetBackground(0.1,0.2,0.4);
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWin->AddRenderer(m_renderer);
	return m_renWin;
}

vtkSmartPointer<vtkWin32OpenGLRenderWindow> CDataVisualization::doubleVolumeRender(CMedData *m_swiData, CMedData *m_mraData)
{
	
	//定义swi体素数据属性 属性名后面加_1
	//Image Data type Casting Filter
	vtkSmartPointer<vtkImageCast> m_imageCast_1 = vtkSmartPointer<vtkImageCast>::New();
	m_imageCast_1->SetInputData(m_swiData->GetVtkVolumeData());
	m_imageCast_1->SetOutputScalarTypeToUnsignedChar();
	m_imageCast_1->Update();

	// Create transfer mapping scalar value to opacity 线性插值不透明度传输函数
	vtkSmartPointer<vtkPiecewiseFunction> m_opacityTransferFunction_1 = vtkSmartPointer<vtkPiecewiseFunction>::New();
	m_opacityTransferFunction_1->AddPoint(70, 0.0);
	m_opacityTransferFunction_1->AddPoint(90, 0.4);
	m_opacityTransferFunction_1->AddPoint(180, 0.6);

	//Create transfer mapping scalar value to color
	vtkSmartPointer<vtkColorTransferFunction> m_VolumePropertyColor_1 = vtkSmartPointer<vtkColorTransferFunction>::New();
	m_VolumePropertyColor_1->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor_1->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor_1->AddRGBPoint(190.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor_1->AddRGBPoint(220.0, 0.0, 0.0, 1.0);

	//define  Volume Property  The property describes how the data will look
	vtkSmartPointer<vtkVolumeProperty> m_VolumeProperty_1 = vtkSmartPointer<vtkVolumeProperty>::New();
	m_VolumeProperty_1->SetInterpolationTypeToLinear();
	m_VolumeProperty_1->ShadeOn();
	m_VolumeProperty_1->SetAmbient(1.0);
	m_VolumeProperty_1->SetDiffuse(1.0);
	m_VolumeProperty_1->SetSpecular(1.0);
//	m_VolumeProperty_1->SetScalarOpacity(m_opacityTransferFunction_1);
	m_VolumeProperty_1->SetColor(m_VolumePropertyColor_1);

	//#The mapper / ray cast function know how to render the data
	//vtkVolumeRayCastMapper 是8版本之前的api 但是在8.1后被vtkGPUVolumeRayCastMapper  vtkFixedPointVolumeRayCastMapper 两个函数代替了，不暴露了
	vtkSmartPointer<vtkGPUVolumeRayCastMapper> m_volumeMapper_1 = vtkSmartPointer<vtkGPUVolumeRayCastMapper>::New();
	m_volumeMapper_1->SetInputConnection(m_imageCast_1->GetOutputPort());
	m_volumeMapper_1->SetBlendModeToMaximumIntensity();//定义渲染方式SetBlendModeTo xxx 进行切换 vtkGPUVolumeRayCastMapper提供给用户的接口
//	m_volumeMapper_1->SetBlendModeToComposite();
	//volume  与actor 类似
	vtkSmartPointer<vtkVolume> m_volume_1 = vtkSmartPointer<vtkVolume>::New();
	m_volume_1->SetMapper(m_volumeMapper_1);
	m_volume_1->SetProperty(m_VolumeProperty_1);

	//定义mra体素数据属性 属性名后面加_2
	//Image Data type Casting Filter
	vtkSmartPointer<vtkImageCast> m_imageCast_2 = vtkSmartPointer<vtkImageCast>::New();
	m_imageCast_2->SetInputData(m_mraData->GetVtkVolumeData());
	m_imageCast_2->SetOutputScalarTypeToUnsignedChar();
	m_imageCast_2->Update();

	// Create transfer mapping scalar value to opacity 线性插值不透明度传输函数
	vtkSmartPointer<vtkPiecewiseFunction> m_opacityTransferFunction_2 = vtkSmartPointer<vtkPiecewiseFunction>::New();
	m_opacityTransferFunction_2->AddPoint(70, 0.0);
	m_opacityTransferFunction_2->AddPoint(90, 0.4);
	m_opacityTransferFunction_2->AddPoint(180, 0.6);

	//Create transfer mapping scalar value to color
	vtkSmartPointer<vtkColorTransferFunction> m_VolumePropertyColor_2 = vtkSmartPointer<vtkColorTransferFunction>::New();
	m_VolumePropertyColor_2->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor_2->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor_2->AddRGBPoint(190.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor_2->AddRGBPoint(220.0, 0.0, 0.0, 1.0);

	//define  Volume Property  The property describes how the data will look
	vtkSmartPointer<vtkVolumeProperty> m_VolumeProperty_2 = vtkSmartPointer<vtkVolumeProperty>::New();
	m_VolumeProperty_2->SetInterpolationTypeToLinear();
	m_VolumeProperty_2->ShadeOn();
	m_VolumeProperty_2->SetAmbient(1.0);
	m_VolumeProperty_2->SetDiffuse(1.0);
	m_VolumeProperty_2->SetSpecular(1.0);
//  m_VolumeProperty_2->SetScalarOpacity(m_opacityTransferFunction_2);
	m_VolumeProperty_2->SetColor(m_VolumePropertyColor_2);

	//#The mapper / ray cast function know how to render the data
	//vtkVolumeRayCastMapper 是8版本之前的api 但是在8.1后被vtkGPUVolumeRayCastMapper  vtkFixedPointVolumeRayCastMapper 两个函数代替了，不暴露了
	vtkSmartPointer<vtkGPUVolumeRayCastMapper> m_volumeMapper_2 = vtkSmartPointer<vtkGPUVolumeRayCastMapper>::New();
	m_volumeMapper_2->SetInputConnection(m_imageCast_2->GetOutputPort());
	m_volumeMapper_2->SetBlendModeToMaximumIntensity();//定义渲染方式SetBlendModeTo xxx 进行切换 vtkGPUVolumeRayCastMapper提供给用户的接口

	//volume  与actor 类似
	vtkSmartPointer<vtkVolume> m_volume_2 = vtkSmartPointer<vtkVolume>::New();
	m_volume_2->SetMapper(m_volumeMapper_2);
	m_volume_2->SetProperty(m_VolumeProperty_2);

	//定义两个体素的render
	vtkSmartPointer<vtkRenderer> m_renderer_1 = vtkSmartPointer<vtkRenderer>::New();
	m_renderer_1->AddVolume(m_volume_1);
	vtkSmartPointer<vtkRenderer> m_renderer_2 = vtkSmartPointer<vtkRenderer>::New();
	m_renderer_2->AddVolume(m_volume_2);
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWin->AddRenderer(m_renderer_1);
	m_renWin->AddRenderer(m_renderer_2);
//	m_renderer->SetBackground(0.1, 0.2, 0.4);
	return m_renWin;
}

vtkSmartPointer<vtkWin32OpenGLRenderWindow> CDataVisualization::volumeComRender(CMedData *m_medData)
{
	//Image Data type Casting Filter.
	vtkSmartPointer<vtkImageCast> m_imageCast = vtkSmartPointer<vtkImageCast>::New();
	m_imageCast->SetInputData(m_medData->GetVtkVolumeData());
	m_imageCast->SetOutputScalarTypeToUnsignedChar();
	m_imageCast->Update();

	// Create transfer mapping scalar value to opacity 线性插值不透明度传输函数
	vtkSmartPointer<vtkPiecewiseFunction> m_opacityTransferFunction = vtkSmartPointer<vtkPiecewiseFunction>::New();
	m_opacityTransferFunction->AddPoint(70, 0.0);
	m_opacityTransferFunction->AddPoint(90, 0.2);
	m_opacityTransferFunction->AddPoint(180, 0.6);

	//Create transfer mapping scalar value to color
	vtkSmartPointer<vtkColorTransferFunction> m_VolumePropertyColor = vtkSmartPointer<vtkColorTransferFunction>::New();
	m_VolumePropertyColor->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(256.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(512.0, 0.0, 0.0, 1.0);

	//define  Volume Property  The property describes how the data will look
	vtkSmartPointer<vtkVolumeProperty> m_VolumeProperty = vtkSmartPointer<vtkVolumeProperty>::New();
	m_VolumeProperty->SetInterpolationTypeToLinear();
	m_VolumeProperty->ShadeOn();
	m_VolumeProperty->SetAmbient(1.0);
	m_VolumeProperty->SetDiffuse(1.0);
	m_VolumeProperty->SetSpecular(1.0);
	//	m_VolumeProperty->SetScalarOpacity(m_opacityTransferFunction);
	m_VolumeProperty->SetColor(m_VolumePropertyColor);

	//#The mapper / ray cast function know how to render the data
	//vtkVolumeRayCastMapper 是8版本之前的api 但是在8.1后被vtkGPUVolumeRayCastMapper  vtkFixedPointVolumeRayCastMapper 两个函数代替了，不暴露了
	vtkSmartPointer<vtkGPUVolumeRayCastMapper> m_volumeMapper = vtkSmartPointer<vtkGPUVolumeRayCastMapper>::New();
	m_volumeMapper->SetInputConnection(m_imageCast->GetOutputPort());
	m_volumeMapper->SetBlendModeToComposite();//定义渲染方式SetBlendModeTo xxx 进行切换 vtkGPUVolumeRayCastMapper提供给用户的接口

	//volume  与actor 类似
	vtkSmartPointer<vtkVolume> m_volume = vtkSmartPointer<vtkVolume>::New();
	m_volume->SetMapper(m_volumeMapper);
	m_volume->SetProperty(m_VolumeProperty);

	//Render
	vtkSmartPointer<vtkRenderer> m_renderer = vtkSmartPointer<vtkRenderer>::New();
	m_renderer->AddVolume(m_volume);
	//m_renderer->SetBackground(0.1, 0.2, 0.4);
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWin->AddRenderer(m_renderer);
	return m_renWin;
}
vtkSmartPointer<vtkWin32OpenGLRenderWindow>CDataVisualization::volumeFixedPointRender(CMedData *m_medData){
	//Image Data type Casting Filter.
	vtkSmartPointer<vtkImageCast> m_imageCast = vtkSmartPointer<vtkImageCast>::New();
	m_imageCast->SetInputData(m_medData->GetVtkVolumeData());
	m_imageCast->SetOutputScalarTypeToUnsignedChar();
	m_imageCast->Update();

	// Create transfer mapping scalar value to opacity 线性插值不透明度传输函数
	vtkSmartPointer<vtkPiecewiseFunction> m_opacityTransferFunction = vtkSmartPointer<vtkPiecewiseFunction>::New();
	m_opacityTransferFunction->AddPoint(70, 0.00);
	m_opacityTransferFunction->AddPoint(90, 0.40);
	m_opacityTransferFunction->AddPoint(180, 0.60);

	//Create transfer mapping scalar value to color
	vtkSmartPointer<vtkColorTransferFunction> m_VolumePropertyColor = vtkSmartPointer<vtkColorTransferFunction>::New();
	/*
	m_VolumePropertyColor->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(190.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(220.0, 0.0, 0.0, 1.0);
	*/
	m_VolumePropertyColor->AddRGBPoint(0.0, 0.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(64.0, 1.0, 0.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(128.0, 0.0, 0.0, 1.0);
	m_VolumePropertyColor->AddRGBPoint(192.0, 0.0, 1.0, 0.0);
	m_VolumePropertyColor->AddRGBPoint(255.0, 1.0, 0.2, 0.0);
	//define  Volume Property  The property describes how the data will look
	vtkSmartPointer<vtkVolumeProperty> m_VolumeProperty = vtkSmartPointer<vtkVolumeProperty>::New();
	m_VolumeProperty->SetInterpolationTypeToLinear();
	m_VolumeProperty->ShadeOn();
	m_VolumeProperty->SetAmbient(0.4);
	m_VolumeProperty->SetDiffuse(0.6);
	m_VolumeProperty->SetSpecular(0.2);
	//	m_VolumeProperty->SetScalarOpacity(m_opacityTransferFunction);
	m_VolumeProperty->SetColor(m_VolumePropertyColor);

	//#The mapper / ray cast function know how to render the data
	//vtkVolumeRayCastMapper 是8版本之前的api 但是在8.1后被vtkGPUVolumeRayCastMapper  vtkFixedPointVolumeRayCastMapper 两个函数代替了，不暴露了
	vtkSmartPointer<vtkFixedPointVolumeRayCastMapper> m_volumeMapper = vtkSmartPointer<vtkFixedPointVolumeRayCastMapper>::New();
	m_volumeMapper->SetInputConnection(m_imageCast->GetOutputPort());
	m_volumeMapper->SetBlendModeToMaximumIntensity();//定义渲染方式SetBlendModeTo xxx 进行切换 vtkGPUVolumeRayCastMapper提供给用户的接口

	//设置光线采样距离
	m_volumeMapper->SetSampleDistance(m_volumeMapper->GetSampleDistance() * 4);
	//设置图像采样步长
	m_volumeMapper->SetAutoAdjustSampleDistances(0);
	m_volumeMapper->SetImageSampleDistance(1);

	//volume  与actor 类似
	vtkSmartPointer<vtkVolume> m_volume = vtkSmartPointer<vtkVolume>::New();
	m_volume->SetMapper(m_volumeMapper);
	m_volume->SetProperty(m_VolumeProperty);

	//Render
	vtkSmartPointer<vtkRenderer> m_renderer = vtkSmartPointer<vtkRenderer>::New();
	m_renderer->AddVolume(m_volume);
	//m_renderer->SetBackground(0.1, 0.2, 0.4);
	m_renWin = vtkSmartPointer<vtkWin32OpenGLRenderWindow>::New();
	m_renWin->AddRenderer(m_renderer);
	return m_renWin;
}