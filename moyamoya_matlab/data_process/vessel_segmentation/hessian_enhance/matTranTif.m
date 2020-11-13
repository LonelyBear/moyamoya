%%用于将matlab中的mat数据转换成序列图像数据tif格式
clc;
clear;
close all;
load 'D:\Desktop\time\code\matlab\tumor\moyamoya\PU\0.3_2_0.4.mat'
load 'D:\Desktop\time\code\matlab\tumor\moyamoya\PU\0.3_2_0.4_scale.mat'
load 'D:\Desktop\time\code\matlab\tumor\moyamoya\PU\pu_mra_brain.mat'
vessel = pu_mra_brain;
%vessel = round(Vfiltered/max(Vfiltered(:))*65536);
a = vessel(:,:,102);
%image_a = pu_mra_brain(:,:,102);
%image_a(a == 0) = 0;
imshow(a,[]);
volume_size = size(vessel)
for num = 1:volume_size(3)
    
    tifName = strcat('D:\Desktop\time\code\matlab\tumor\moyamoya\PU\MRA_brain\',int2str(num),'.','tif');
    imwrite(uint16(vessel(:,:,num)),tifName);
end
