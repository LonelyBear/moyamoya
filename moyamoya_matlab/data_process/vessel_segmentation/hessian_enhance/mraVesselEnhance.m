function [output_volume,scale_matrix] = mraVesselEnhance(input_volume)
%MRAVESSELENHANCE �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
pro_volume = round(input_volume);

%%%��������Ӧ��ֵ
disp('����Ӧ��ֵ');
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
% vc10 �� vc 12  �ж�imgaussian.c  �ı��벻ͨ��
[enhanced_volume,scale_matrix] = FrangiFilter3D(pro_volume,options);
output_volume = round(enhanced_volume/max(enhanced_volume(:))*65536);
end

