import vtk

#####
dataStringArray = vtk.vtkStringArray()
for num in range(1,211):
    filename = "F:\\yangtao\\moyamoya\\vessel filter\\PU\\MRA_VESSEL\\pu_0.3_2_0.4_filter\\"+str(num)+".tif"
    dataStringArray.InsertNextValue(filename)
tifviewer = vtk.vtkTIFFReader()
tifviewer.SetFileNames(dataStringArray)

cast = vtk.vtkImageCast()
cast.SetInputConnection(tifviewer.GetOutputPort())
cast.SetOutputScalarTypeToUnsignedShort()
cast.Update()

#Function
rayCastFun = vtk.vtkVolumeRayCastCompositeFunction()

#Mapper
volumeMapper = vtk.vtkVolumeRayCastMapper()
volumeMapper.SetVolumeRayCastFunction(rayCastFun)
volumeMapper.SetInputConnection(cast.GetOutputPort())

#Property
pVolumeProperty = vtk.vtkVolumeProperty()
pVolumeProperty.SetInterpolationTypeToLinear()
pVolumeProperty.ShadeOn()
pVolumeProperty.SetAmbient(1.0)
pVolumeProperty.SetDiffuse(1.0)
pVolumeProperty.SetSpecular(1.0)

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

