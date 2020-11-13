clc;clear;
mex D:\Space\moyamoya-1\moyamoya_gui\Moyamoya Processing\vessel_segmentation\hessian_enhance\eig3volume.c
mex D:\Space\moyamoya-1\moyamoya_gui\Moyamoya Processing\vessel_segmentation\hessian_enhance\imgaussian.c
load('D:\Space\moyamoya\experiment_data\pu_mra_brain_filter.mat');
Volume_data =round(pu_mra_brain_filter);  
[L,M,N] = size(Volume_data);
% vessel.mat;
% save (vessel.mat,Volume_data);
% Frangi Filter the stent volume
options.FrangiScaleRange = [0.1,1];
options.FrangiScaleRatio = 1;
options.BlackWhite=false;
options.FrangiAlpha = 0.5;
options.FrangiBeta = 0.5;
option.FrangiC = 20;
Hu = adaptIterativeThreshold(Volume_data);
option.FrangiHu = Hu;
[Vfiltered,whatScale] = FrangiFilter3D(Volume_data,options);

vessel = round(Vfiltered/max(Vfiltered(:))*65536);
a = vessel(:,:,102);
imshow(a,[]);
for num = 1:N    
    tifName = strcat('D:\Desktop\time\code\matlab\tumor\moyamoya\PU\MRA_brain\',int2str(num),'.','tif');
    imwrite(uint16(vessel(:,:,num)),tifName);
end



%   I=double(imread ('vessel.png'));
%   Ivessel=FrangiFilter2D(I);
%   figure,
%   subplot(1,2,1), imshow(I,[]);
%   subplot(1,2,2), imshow(Ivessel,[0 0.25]);