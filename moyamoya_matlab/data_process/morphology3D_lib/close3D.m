function Volume_out = close3D(volume_input,se_option)
%CLOSE3D �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%%%%%volume_inputΪ��ֵ��άͼ��%%%%%
%%%%%�趨strel%%%%% 1Ϊ����  ��������Ϊone��3��
%%%%  �ղ��� �����ͺ�ʴ
if se_option == 1
    volume_dilate = dilate3D(volume_input,1);
    volume_close = erode3D(volume_dilate,1);
else
    volume_dilate = dilate3D(volume_input,0);
    volume_close = erode3D(volume_dilate,0);
end

Volume_out = volume_close;

