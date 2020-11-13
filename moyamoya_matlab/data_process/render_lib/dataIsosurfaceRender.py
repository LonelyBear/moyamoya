import vtk

#####
dataStringArray = vtk.vtkStringArray()
for num in range(1,211):
    filename = "D:\\Desktop\\time\\code\\matlab\\tumor\\moyamoya\\PU\\vessel_tif\\"+str(num)+".tif"
    dataStringArray.InsertNextValue(filename)
tifviewer = vtk.vtkTIFFReader()
tifviewer.SetFileNames(dataStringArray)

cast = vtk.vtkImageCast()
cast.SetInputConnection(tifviewer.GetOutputPort())
cast.SetOutputScalarTypeToUnsignedShort()
cast.Update()

#绘制方式函数设定
rayCastFun = vtk.vtkVolumeRayCastIsosurfaceFunction()
rayCastFun.SetIsoValue(100)

#Mapper
volumeMapper = vtk.vtkVolumeRayCastMapper()
volumeMapper.SetVolumeRayCastFunction(rayCastFun)
volumeMapper.SetInputConnection(cast.GetOutputPort())

#Property
pVolumeProperty = vtk.vtkVolumeProperty()
pVolumeProperty.SetInterpolationTypeToLinear()
pVolumeProperty.ShadeOn()
pVolumeProperty.SetAmbient(0.4)
pVolumeProperty.SetDiffuse(0.6)
pVolumeProperty.SetSpecular(0.2)

#Property_Color
pVolumePropertyColor = vtk.vtkColorTransferFunction()
pVolumePropertyColor.AddRGBPoint(0.000,0.00,0.00,0.00)
pVolumePropertyColor.AddRGBPoint(64.00,1.00,0.52,0.30)
pVolumePropertyColor.AddRGBPoint(190.0,1.00,1.00,1.00)
pVolumePropertyColor.AddRGBPoint(220.0,0.20,0.20,0.20)
pVolumeProperty.SetColor(pVolumePropertyColor)

#Property_CompositeOpacity
pVolumePropertyCompositeOpacity = vtk.vtkPiecewiseFunction();
pVolumePropertyCompositeOpacity.AddPoint(70,0.00)
pVolumePropertyCompositeOpacity.AddPoint(90,0.40)
pVolumePropertyCompositeOpacity.AddPoint(180,0.60)
pVolumeProperty.SetScalarOpacity(pVolumePropertyCompositeOpacity)

#Volume
pVolume = vtk.vtkVolume()
pVolume.SetMapper(volumeMapper)
pVolume.SetProperty(pVolumeProperty)

#Render
pRender = vtk.vtkRenderer();
pRender.AddActor(pVolume)

#RenderWindow
pRenderWindow = vtk.vtkRenderWindow();
pRenderWindow.AddRenderer(pRender)

#RenderWindowInteractor
pRenderWindowInteractor = vtk.vtkRenderWindowInteractor()
pRenderWindowInteractor.SetRenderWindow(pRenderWindow)

#Run
pRenderWindowInteractor.Initialize()
pRenderWindowInteractor.Start()

