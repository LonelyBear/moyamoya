function output_volume = vesselSegment(input_volume)
addpath(genpath(pwd));
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
%   MRA序列图像血管组织的提取分割
volume_pro = double(input_volume);

%% 体素中值滤波
volume_medfilt = medfilt3(volume_pro);
clear volume_pro;

%% 各向异性滤波
disp('medfilt3');
voxel_spacing = ones(3,1);
volume_anisodiff = anisodiff3D(volume_medfilt,2,3/44,70,2,voxel_spacing);% 各向异性一次


%% 
disp('anisodiff3D');
volume_filter = volume_anisodiff;
clear volume_medfilt;
clear volume_anisodiff;

output_volume = mraVesselEnhance(volume_filter);
end

