function output_volume = vesselPostFilter(input_volume)
%VESSELPOSTFILETER �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   ����ǿ���Ѫ��ͼ����д���
%   ��ֵ�����رȽ�
%   �˲�  ��̬ѧ����  �Ż�Ч��
%   ȥ����ɢѪ�ܽṹ
%   ������ʾ���в�����

[L,M,N] = size(input_volume);
pro_volume = input_volume;

%% ��������-�ҶȵĶ�Ӧ����
volume_min = min(min(min(pro_volume)));
volume_max = max(max(max(pro_volume)));
gray_step = (volume_max - volume_min)/255;% �涨�̶��Ĳ��� gray_step
fid = fopen('volume-gray.txt','w');
current_gray = volume_min;
volume_count = 0;
plot_count = 1; 
while(current_gray <= volume_max)
    for i = 1 : numel(pro_volume)
        if(pro_volume(i) >= current_gray)
            volume_count = volume_count + 1;
        end
    end
    fprintf(fid,'%d\t',plot_count);
    fprintf(fid,'%d\t',current_gray);
    fprintf(fid,'%d\t',volume_count);
    fprintf(fid,'\r\n');
    volume_count = 0;
    plot_count = plot_count + 1;
    current_gray = current_gray + gray_step;
end

%% ͨ��������ģ��ȡ���Ż���ֵ
volume_threhold = pro_volume;
option_gray = volume_min + 11 * gray_step;%�������ֵ
for i = 1 :numel(volume_threhold)
    if(volume_threhold(i) < option_gray)
        volume_threhold(i) = 0;
    end
end


%% ��̬ѧ����
volume_morph = volume_threhold;
clear volume_threhold;
for i = 1 :numel(volume_morph)
    if(volume_morph(i) ~= 0)
        volume_morph(i) = volume_morph(i)/volume_morph(i);
    end
end

% ��ά�Ŀ�����
volume_open = open3D(volume_morph,1);

% �ʵ��Ŀ׶����
volume_morph_holes = volume_open;
for i = 1:N
    volume_morph_holes(i) = imfill(volume_open(i),'holes');
end

%output_volume = volume_morph_holes;
result_volume = zeros(L,M,N);
for i = 1:numel(result_volume)
    if volume_morph_holes(i) == 1
        result_volume(i) = pro_volume(i);
    end
end
output_volume = result_volume;
end

