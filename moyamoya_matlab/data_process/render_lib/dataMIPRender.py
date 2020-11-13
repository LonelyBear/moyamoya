import vtk
from tkinter import *
import tkinter.filedialog


#####
# dataStringArray = vtk.vtkStringArray()
# # for num in range(1,211):
# #     #filename = "F:\\yangtao\\moyamoya\\HessianPlus\\pu_0.5_1_5_filter_imF\\"+str(num)+".tif"
# #     filename = ("D:\\Space\\moyamoya-1\\moyamoya_gui\\Moyamoya Processing\\experiment_data\\pu_jing_ming\\TIF\\vessel_1_5_1\\"+str(num)+".tif")
# #     dataStringArray.InsertNextValue(filename)
# # tifviewer = vtk.vtkTIFFReader()
# # tifviewer.SetFileNames(dataStringArray)

# niifilename = "D:\\Space\\moyamoya-1\\moyamoya_gui\\Moyamoya Processing\\experiment_data\\pu_jing_ming\\NIfTI\\vessel_1_5_5\\vessel_1_5_5.nii"
# niiReader = vtk.vtkNIFTIImageReader()
# niiHeader = vtk.vtkNIFTIImageHeader()
# niiReader.SetFileName(niifilename)

# cast = vtk.vtkImageCast()
# cast.SetInputConnection(niiReader.GetOutputPort())
# cast.SetOutputScalarTypeToUnsignedShort()
# cast.Update()

#Function
#rayCastFun = vtk.vtkFixedPointVolumeRayCastMapper()
mipCastFun = vtk.vtkVolumeRayCastMIPFunction()  ##vtk 8.1 似乎是 把这个module禁掉了

#Mapper
volumeMapper = vtk.vtkVolumeRayCastMapper()
volumeMapper.SetVolumeRayCastFunction(mipCastFun)
# volumeMapper.SetInputConnection(cast.GetOutputPort())

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
#pVolumeProperty.SetColor(pVolumePropertyColor)

#Property_CompositeOpacity
pVolumePropertyCompositeOpacity = vtk.vtkPiecewiseFunction();
pVolumePropertyCompositeOpacity.AddPoint(70,0.00)
pVolumePropertyCompositeOpacity.AddPoint(90,0.40)
pVolumePropertyCompositeOpacity.AddPoint(180,0.60)
#pVolumeProperty.SetScalarOpacity(pVolumePropertyCompositeOpacity)

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

