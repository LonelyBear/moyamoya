function Volume_out = open3D(volume_input,se_option)
%OPEN3D �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%%%%%volume_inputΪ��ֵ��άͼ��%%%%%
%%%%%�趨strel%%%%% 1Ϊ����  ��������Ϊone��3��
%%%%  ������ �ȸ�ʴ������
if se_option == 1
    volume_erode = erode3D(volume_input,1);
    volume_open = dilate3D(volume_erode,1);
else
    volume_erode = erode3D(volume_input,0);
    volume_open = dilate3D(volume_erode,0);
end

Volume_out = volume_open;
