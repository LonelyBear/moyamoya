    %% 
clear;clc;
close all;

%% ��ȡ�ļ�
[fileName,pathName] = uigetfile('*.*','��ȡͼ���ļ�');
if(fileName)  
    fileName = strcat(pathName,fileName);  
else  
    msgbox('Please select an image');  
    return; %�˳�����  
end   
I = imread(fileName);

if( ~( size(I,3)-3 ))  
    I = rgb2gray(I);%ת��Ϊ��ͨ���Ҷ�ͼ  
end 

%% ���ѡ�����ӵ�
I=double(I);
maxgray = max(max(I));%���Ҷ�
%I = anisodiff2D(I,15,1/7,30,2);I = anisodiff2D(I,15,1/7,30,2);
figure,imshow(I,[]),title('Ininital Image') 
[M,N]=size(I);
[y,x] = getpts;%���ȡ��  �س�ȷ��  
x = round(x);%ѡ�����ӵ�  
y = round(y);

%% ��ʼ��������
%����ͨ
connect = [ -1 -1;  
            -1  0;  
            -1  1;  
             0 -1;
             0  1;
             1 -1;
             1  0;
             1  1];  
J = zeros(M,N);
J(x,y) = 2;
% reg_temp_pix = zeros(M,N);
% reg_temp_gra = zeros(M,N);
reg_size = 1;
reg_mean = I(x,y);
reg_temp = zeros(numel(I),3);
reg_temp_count = 0;
pixdist = 0;

%% ��ʼ��ֵ��Ŀ�꺯��ֵ����
I_gradient = gradient(I);
pix = zeros(25,1);
pix_gradient = zeros(25,1);
k=1;
for i = -2:2
    for j = -2:2
        pix(k) = I(x+i,y+j);
        pix_gradient(k) = I_gradient(x+i,y+j);
        k = k+1;
    end
end
[minh,reg_threshold] = calculateH(pix,pix_gradient,maxgray);
currenth = minh;
iteration = 0;
%% ������������
while(minh <= currenth )
    currenth = minh;
    iteration = iteration + 1;
    cccc =0;
    while(pixdist < reg_threshold && reg_size < numel(I))
        for j=1:8
            xn = x + connect(j,1);  
            yn = y + connect(j,2); 
            if( xn >= 1 && yn >=1 && xn <= M && yn <= N && J(xn,yn)==0)
                reg_temp_count = reg_temp_count+1;
                reg_temp(reg_temp_count,:) = [xn,yn,I(xn,yn)];
                J(xn,yn) = 1;
            end
        end
        dist = abs(reg_temp(1:reg_temp_count,3)-reg_mean);  
        [pixdist,index] = min(dist); 
        reg_mean = (reg_mean * reg_size +reg_temp(index,3))/(reg_size + 1);  
        reg_size = reg_size + 1;  
        J(x,y)=2;%���ӵ���
        x = reg_temp(index,1);
        y = reg_temp(index,2);
        reg_temp(index,:) = reg_temp(reg_temp_count,:);  
        reg_temp_count = reg_temp_count -1;
        cccc = cccc+1;
    end
    k = 0;
    reg_temp_pix = [];
    reg_temp_gra = [];
    for i = 1:numel(I)
        if (J(i) == 2)
            reg_temp_pix = [reg_temp_pix,I(i)];
            reg_temp_gra = [reg_temp_gra,I_gradient(i)]; 
            k = k + 1;
        end
    end
    minh = calculateH(reg_temp_pix,reg_temp_gra,maxgray);
    reg_threshold = reg_threshold + 5;
    meiyong = 5;
    %figure,imshow(reg_temp_pix,[]);
end

J = (J==2);%����֮ǰ���ָ�õ����ص���Ϊ2
%J = bwmorph(J,'dilate',2);%�� �ýṹԪ��ones��3������������
%J = bwmorph(J,'remove');
%J = imfill(J,'holes');
 resultImage = zeros(M,N);
 for i = 1:numel(J)
     if J(i) == 0
         resultImage(i) = 0;
     else
         resultImage(i) = I(i)+200;
     end
 end
 
 figure,imshow(resultImage+I,[]),title('Segmentation Image')
 
 %% 
 
 
 %testImage  = imread('D:\Desktop\time\code\matlab\tumor\moyamoya\lIANG\MRA\126.tif');
testImage  = imread('D:\Desktop\time\code\matlab\tumor\moyamoya\PU\MRA_TOF_3D\PU JIN MINGU0000102MRA_TOF_3D.tif');
%testImage  = imread('D:\Desktop\time\code\matlab\tumor\moyamoya\SHE\MRA\132.tif');
 testImage = double(testImage);
 [M1,N1] = size(testImage);
 %%���һ�����λ�þ���
 position = zeros(M1,N1);
 position = testImage;
%  for pos_i = 1:M-1
%      for pos_k = 1:N
%          if resultImage(pos_k+pos_i*M) ~= 0
%              trans_k = pos_k-N/2+N1/2;
%              trans_i = pos_i-M/2+M1/2;            
%              position(trans_k+trans_i*M1) = 500;
%          end
%      end
%  end
 for pos_i = 1:M
     for pos_k = 1:N
         if resultImage(pos_i,pos_k) ~= 0
             trans_k = pos_k-N/2+N1/2;
             trans_i = pos_i-M/2+M1/2;            
             position(trans_i,trans_k) = max(max(position));
         end
     end
 end
 figure,imshow(position,[]),title('position Image') 
 
 
    







