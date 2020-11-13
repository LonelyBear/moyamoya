function [show_volume,position_volume] = RegionGrow3D(input_volume,seed_point,options)
%REGIONGROW3D �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%   SWI���ص���ά���������ָ��
%   input_volume  Ϊ�����ͼ������
%   seed_point Ϊ�˹�ѡ�����ӵ�����

% ��ʼ��������
addpath(genpath(pwd));%������ļ��еĺ���
defaultoptions = struct('ininital_matrix_option', 1);

% Process inputs
if(~exist('options','var')) 
    options=defaultoptions; 
else
    tags = fieldnames(defaultoptions);
    for i=1:length(tags)
         if(~isfield(options,tags{i})),  options.(tags{i})=defaultoptions.(tags{i}); end
    end
    if(length(tags)~=length(fieldnames(options))) 
        warning('RegionGrow3D:unknownoption','unknown options found');
    end
end

% 26��ͨ
connect = [ -1 -1 -1; -1 -1 0; -1 -1 1;
            -1  0 -1; -1  0 0; -1  0 1;
            -1  1 -1; -1  1 0; -1  1 1;
             0 -1 -1;  0 -1 0;  0 -1 1;
             0  0 -1;  0  0 1;
             0  1 -1;  0  1 0;  0  1 1;
             1 -1 -1;  1 -1 0;  1 -1 1;             
             1  0 -1;  1  0 0;  1  0 1;
             1  1 -1;  1  1 0;  1  1 1;];
I = double(input_volume); %���ڴ����ͼ������
[L,M,N] = size(I);

%%�˲�
%disp('��ά��ֵ�˲�');
%I = medfilt3(I);
% disp('��ά���������˲�');
% voxel_spacing = ones(3,1);
% I = anisodiff3D(I,1,3/44,70,2,voxel_spacing);
I = round(I);

[gx,gy,gz] = gradient(I);
I_gradient = sqrt(gx.^2 + gy.^2 + gz.^2);
J = zeros(L,M,N); %���ڼ�¼����λ�õ���ά����
maxgray = max(max(max(I)));%���Ҷ�

x = seed_point(1);
y = seed_point(2);
z = seed_point(3);
reg_size = 1; % ��������ص����
reg_mean = I(x,y,z); % ����ĻҶȾ�ֵ

%%%�������������Ĵ�ŵ�ľ���
reg_temp = zeros(numel(I),4); % ��ά���� + �Ҷ�ֵ
reg_temp_count = 0; % ��ʱ��ĸ���
pixdist = 0;  % �����뾶������ֵ�ȽϽ����ж��Ƿ��������

%%%��ʼ��ֵ����
if(options.ininital_matrix_option == 1)
    %%%��ʼ5*5*%5����ĳ�ʼ����������
	initial_threhold = 0;
	for i = -2:2
        for j = -2:2
            for k = -2:2
                initial_threhold = initial_threhold + I(x+i,y+j,z+k);
            end
        end
    end
    reg_threshold = abs(initial_threhold/125 - reg_mean);    
else
    %%%��ʼ3*3*%3����ĳ�ʼ����������  (�ر�С�ĳ�Ѫ��)
    initial_threhold = 0;
    for i = -1:1
        for j = -1:1
            for k = -1:1
                initial_threhold = initial_threhold + I(x+i,y+j,z+k);
            end
        end
    end
    reg_threshold = abs(initial_threhold/27 - reg_mean);
end

%%%��ʼ��ʼ������������
while(pixdist <= reg_threshold && reg_size < numel(I))
    for j=1:26
        xn = x + connect(j,1);  
        yn = y + connect(j,2); 
        zn = z + connect(j,3);
        if( xn >= 1 && yn >=1 && zn >=1 && xn <= L && yn <= M && zn <= N &&J(xn,yn,zn) == 0)
            reg_temp_count = reg_temp_count+1;
            reg_temp(reg_temp_count,:) = [xn,yn,zn,I(xn,yn,zn)];
            J(xn,yn,zn) = 1;
        end
    end
    dist = abs(reg_temp(1:reg_temp_count,4)-reg_mean);  
    [pixdist,index] = min(dist); 
    reg_mean = (reg_mean * reg_size +reg_temp(index,4))/(reg_size + 1);  
    reg_size = reg_size + 1;  
    J(x,y,z) = 2;%���ӵ���
    x = reg_temp(index,1);
    y = reg_temp(index,2);
    z = reg_temp(index,3);
    reg_temp(index,:) = reg_temp(reg_temp_count,:);  
    reg_temp_count = reg_temp_count -1;
end
grow_iteration = 1;
disp(['��������: ' num2str(grow_iteration)]);
disp(['�������ص�: ' num2str(reg_size-1)]);

ite_h0 = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size-1,connect,[L,M,N]);%reg_size-1 
ite_h1 = ite_h0;

%ͨ�����㺯��ֵH������������
while (ite_h1 <= ite_h0)
    ite_h0 = ite_h1;
    grow_iteration = grow_iteration + 1;
    reg_threshold = reg_threshold + 1;
    while(pixdist <= reg_threshold && reg_size < numel(I))
        for j=1:26
            xn = x + connect(j,1);  
            yn = y + connect(j,2); 
            zn = z + connect(j,3);
            if( xn >= 1 && yn >=1 && zn >=1 && xn <= L && yn <= M && zn <= N &&J(xn,yn,zn) == 0)
                reg_temp_count = reg_temp_count+1;
                reg_temp(reg_temp_count,:) = [xn,yn,zn,I(xn,yn,zn)];
                J(xn,yn,zn) = 1;
            end
        end
        dist = abs(reg_temp(1:reg_temp_count,4)-reg_mean);  
        [pixdist,index] = min(dist); 
        reg_mean = (reg_mean * reg_size +reg_temp(index,4))/(reg_size + 1);  
        reg_size = reg_size + 1;  
        J(x,y,z) = 2;%���ӵ���
        x = reg_temp(index,1);
        y = reg_temp(index,2);
        z = reg_temp(index,3);
        reg_temp(index,:) = reg_temp(reg_temp_count,:);  
        reg_temp_count = reg_temp_count -1;
    end
    disp(['��������: ' num2str(grow_iteration)]);
    disp(['�������ص�: ' num2str(reg_size-1)]);
    ite_h1 = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size-1,connect,[L,M,N]);%reg_size-1
end

%��̬ѧ����
J = (J==2);%����֮ǰ���ָ�õ����ص���Ϊ2
J = dilate3D(J,1);%����
J = dilate3D(J,1);%����2��
%J = remove3D(J,1);
resultImage = zeros(L,M,N);
    for i = 1:numel(J)
        if J(i) ~= 1
            resultImage(i) = input_volume(i);
        else
            resultImage(i) = input_volume(i)+200;
        end
    end
position_volume = J;    
show_volume = resultImage;
end

