function [show_volume,position_volume] = RegionGrow3D(input_volume,seed_point,options)
%REGIONGROW3D 此处显示有关此函数的摘要
%   此处显示详细说明
%   SWI体素的三维区域生长分割函数
%   input_volume  为输入的图像体素
%   seed_point 为人工选的种子点坐标

% 初始参数设置
addpath(genpath(pwd));%添加子文件夹的函数
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

% 26连通
connect = [ -1 -1 -1; -1 -1 0; -1 -1 1;
            -1  0 -1; -1  0 0; -1  0 1;
            -1  1 -1; -1  1 0; -1  1 1;
             0 -1 -1;  0 -1 0;  0 -1 1;
             0  0 -1;  0  0 1;
             0  1 -1;  0  1 0;  0  1 1;
             1 -1 -1;  1 -1 0;  1 -1 1;             
             1  0 -1;  1  0 0;  1  0 1;
             1  1 -1;  1  1 0;  1  1 1;];
I = double(input_volume); %用于处理的图像数据
[L,M,N] = size(I);

%%滤波
%disp('三维中值滤波');
%I = medfilt3(I);
% disp('三维各向异性滤波');
% voxel_spacing = ones(3,1);
% I = anisodiff3D(I,1,3/44,70,2,voxel_spacing);
I = round(I);

[gx,gy,gz] = gradient(I);
I_gradient = sqrt(gx.^2 + gy.^2 + gz.^2);
J = zeros(L,M,N); %用于记录像素位置的三维数组
maxgray = max(max(max(I)));%最大灰度

x = seed_point(1);
y = seed_point(2);
z = seed_point(3);
reg_size = 1; % 区域的像素点个数
reg_mean = I(x,y,z); % 区域的灰度均值

%%%用于区域生长的存放点的矩阵
reg_temp = zeros(numel(I),4); % 三维坐标 + 灰度值
reg_temp_count = 0; % 临时点的个数
pixdist = 0;  % 生长半径，与阈值比较进行判断是否继续生长

%%%初始阈值计算
if(options.ininital_matrix_option == 1)
    %%%初始5*5*%5矩阵的初始化参数计算
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
    %%%初始3*3*%3矩阵的初始化参数计算  (特别小的出血灶)
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

%%%开始初始迭代生长过程
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
    J(x,y,z) = 2;%种子点标记
    x = reg_temp(index,1);
    y = reg_temp(index,2);
    z = reg_temp(index,3);
    reg_temp(index,:) = reg_temp(reg_temp_count,:);  
    reg_temp_count = reg_temp_count -1;
end
grow_iteration = 1;
disp(['生长次数: ' num2str(grow_iteration)]);
disp(['区域像素点: ' num2str(reg_size-1)]);

ite_h0 = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size-1,connect,[L,M,N]);%reg_size-1 
ite_h1 = ite_h0;

%通过计算函数值H继续进行生长
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
        J(x,y,z) = 2;%种子点标记
        x = reg_temp(index,1);
        y = reg_temp(index,2);
        z = reg_temp(index,3);
        reg_temp(index,:) = reg_temp(reg_temp_count,:);  
        reg_temp_count = reg_temp_count -1;
    end
    disp(['生长次数: ' num2str(grow_iteration)]);
    disp(['区域像素点: ' num2str(reg_size-1)]);
    ite_h1 = Region_grow_calcH(I,I_gradient,J,maxgray,reg_size-1,connect,[L,M,N]);%reg_size-1
end

%形态学处理
J = (J==2);%我们之前将分割好的像素点标记为2
J = dilate3D(J,1);%膨胀
J = dilate3D(J,1);%膨胀2次
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

