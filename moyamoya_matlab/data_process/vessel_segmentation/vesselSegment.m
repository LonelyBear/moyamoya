function output_volume = vesselSegment(input_volume)
addpath(genpath(pwd));
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   MRA����ͼ��Ѫ����֯����ȡ�ָ�
volume_pro = double(input_volume);

%% ������ֵ�˲�
volume_medfilt = medfilt3(volume_pro);
clear volume_pro;

%% ���������˲�
disp('medfilt3');
voxel_spacing = ones(3,1);
volume_anisodiff = anisodiff3D(volume_medfilt,2,3/44,70,2,voxel_spacing);% ��������һ��


%% 
disp('anisodiff3D');
volume_filter = volume_anisodiff;
clear volume_medfilt;
clear volume_anisodiff;

output_volume = mraVesselEnhance(volume_filter);
end

