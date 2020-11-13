function [output_volume,scale_matrix] = mraVesselEnhance(input_volume)
%MRAVESSELENHANCE 此处显示有关此函数的摘要
%   此处显示详细说明
pro_volume = round(input_volume);

%%%计算自适应阈值
disp('自适应阈值');
Hu = adaptIterativeThreshold(pro_volume);
options.FrangiHu = Hu;
options.FrangiScaleRange = [0.1,0.3];
options.FrangiScaleRatio = 0.4;
options.BlackWhite=false;
options.FrangiAlpha = 0.5;
options.FrangiBeta = 0.5;
options.FrangiC = 20;

mex .\vessel_segmentation\hessian_enhance\eig3volume.c
% mex .\vessel_segmentation\hessian_enhance\imgaussian.c
% vc10 和 vc 12  中对imgaussian.c  的编译不通过
[enhanced_volume,scale_matrix] = FrangiFilter3D(pro_volume,options);
output_volume = round(enhanced_volume/max(enhanced_volume(:))*65536);
end

