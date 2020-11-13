function Volume_out = open3D(volume_input,se_option)
%OPEN3D 此处显示有关此函数的摘要
%   此处显示详细说明
%%%%%volume_input为二值三维图像%%%%%
%%%%%设定strel%%%%% 1为菱形  其他数字为one（3）
%%%%  开操作 先腐蚀后膨胀
if se_option == 1
    volume_erode = erode3D(volume_input,1);
    volume_open = dilate3D(volume_erode,1);
else
    volume_erode = erode3D(volume_input,0);
    volume_open = dilate3D(volume_erode,0);
end

Volume_out = volume_open;
