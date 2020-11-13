function Volume_out = remove3D(volume_input,se_option)
%REMOVE3D 此处显示有关此函数的摘要
%%%%%volume_input为二值三维图像%%%%%
%%%设定strel%%%%% 1为菱形  其他数字为one（3）

volume_temp = erode3D(volume_input,se_option);
Volume_out = volume_input - volume_temp;
end

