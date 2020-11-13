function Volume_out = close3D(volume_input,se_option)
%CLOSE3D 此处显示有关此函数的摘要
%   此处显示详细说明
%%%%%volume_input为二值三维图像%%%%%
%%%%%设定strel%%%%% 1为菱形  其他数字为one（3）
%%%%  闭操作 先膨胀后腐蚀
if se_option == 1
    volume_dilate = dilate3D(volume_input,1);
    volume_close = erode3D(volume_dilate,1);
else
    volume_dilate = dilate3D(volume_input,0);
    volume_close = erode3D(volume_dilate,0);
end

Volume_out = volume_close;

