function Volume_out = remove3D(volume_input,se_option)
%REMOVE3D �˴���ʾ�йش˺�����ժҪ
%%%%%volume_inputΪ��ֵ��άͼ��%%%%%
%%%�趨strel%%%%% 1Ϊ����  ��������Ϊone��3��

volume_temp = erode3D(volume_input,se_option);
Volume_out = volume_input - volume_temp;
end

