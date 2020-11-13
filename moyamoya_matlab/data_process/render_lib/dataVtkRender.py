import vtk

arender = vtk.vtkRenderer();

renwin = vtk.vtkRenderWindow();
renwin.AddRenderer(arender);

iren = vtk.vtkRenderWindowInteractor();
iren.SetRenderWindow(renwin);

dataStringArray = vtk.vtkStringArray();

for num in range(1,210):
    #filename1 = "D:\\Desktop\\time\\code\\matlab\\tumor\\moyamoya\\lIANG\\MRA_NONE\\"+str(num)+".tif"
    filename = "D:\\Desktop\\time\\code\\matlab\\tumor\\moyamoya\\PU\\vessel_tif\\"+str(num)+".tif"
    dataStringArray.InsertNextValue(filename);

tifviewer = vtk.vtkTIFFReader();
tifviewer.SetFileNames(dataStringArray)


skinExtractor = vtk.vtkContourFilter();
skinExtractor.SetInputConnection(tifviewer.GetOutputPort());
skinExtractor.SetValue(0, 50);

skinNormals = vtk.vtkPolyDataNormals();
skinNormals.SetInputConnection(skinExtractor.GetOutputPort());
skinNormals.SetFeatureAngle(60.0);

skinMapper = vtk.vtkPolyDataMapper();
skinMapper.SetInputConnection(skinNormals.GetOutputPort());
skinMapper.ScalarVisibilityOff();

skin = vtk.vtkActor();
skin.SetMapper(skinMapper);

#产生一个围绕着数据的框架
outlineData = vtk.vtkOutlineFilter();
outlineData.SetInputConnection(tifviewer.GetOutputPort());
mapOutline = vtk.vtkPolyDataMapper();
mapOutline.SetInputConnection(outlineData.GetOutputPort());
outline = vtk.vtkActor();
outline.SetMapper(mapOutline);
outline.GetProperty().SetColor(0, 0, 0);

#新建相机实例
aCamera = vtk.vtkCamera();
arender.AddActor(outline);
arender.AddActor(skin);
arender.SetActiveCamera(aCamera);
arender.ResetCamera();
aCamera.Dolly(1.5); #将相机靠近焦点，以放大图像

arender.SetBackground(1, 1, 1); #设置背景为白色
renwin.SetSize(1000, 1000);

#由于Dolly()方法移动了相机，所以要重设相机的剪切范围
arender.ResetCameraClippingRange();

iren.Initialize();
iren.Start();




