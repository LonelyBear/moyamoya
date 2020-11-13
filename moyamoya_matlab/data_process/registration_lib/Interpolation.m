clc;clear;
slice = zeros(336,336,176);
tran_slice = zeros(336,336,210);
big_tran_slice = zeros(672,672,210);
[fileName,pathName] = uigetfile('*.*','选择烟雾病数据文件夹');
if(fileName)  
    fileName = strcat(pathName,fileName);  
else  
    msgbox('请选择文件');  
    return; %退出程序  
end   
%fileName(end-8:end)= [];
%fileName(end-14:end)= [];
A = dir(pathName);
for i = 3:length(A)
    fileName = strcat(A(i,1).folder,'\',A(i,1).name);
    temp = dicomread(fileName);
    slice(:,:,i-2) = temp;
    %imshow(slice(:,:,i-2),[]);
end
%% 

% test = zeros(176,1);
% result = zeros(210,1);
% result1 = zeros(210,1);
% for i = 1:176
%     test(i) = slice(100,100,i);
% end
% result(1) = test(1);
% result(210) = test(176);
% for i = 2:209
%     num = (i-1) * 0.833 + 1;    
%     result(i) = (test(floor(num)+1)-test(floor(num)))*(num-floor(num))+test(floor(num));    
%     result1(i) = round((test(floor(num)+1)-test(floor(num)))*(num-floor(num))+test(floor(num))); 
% end
% %plot(test,'r');
% plot(result1,'b');
%%将原有的176层数图像通过层间插值成210层序列图像
tran_slice(:,:,1) = slice(:,:,1);
big_tran_slice(:,:,1) = transImageSize(tran_slice(:,:,1));
tran_slice(:,:,210) = slice(:,:,176);
big_tran_slice(:,:,210) = transImageSize(tran_slice(:,:,210));
%imwrite(uint16(big_tran_slice(:,:,1)),'1.tif');
%imwrite(uint16(big_tran_slice(:,:,210)),'210.tif');%保存为tif格式
coef = 0.833;
for i = 2:209   
    slice_num = (i-1)*coef+1;   
    for j = 1:336       
        for k = 1:336
            tran_slice(j,k,i) = round((slice(j,k,(floor(slice_num)+1))-slice(j,k,(floor(slice_num))))*(slice_num-floor(slice_num))+slice(j,k,(floor(slice_num)))); 
        end        
    end
    big_tran_slice(:,:,i) = transImageSize(tran_slice(:,:,i));
    %imshow(big_tran_slice(:,:,i),[]);
    %saveName = strcat(int2str(i),'.','tif');
    %imwrite(uint16(big_tran_slice(:,:,i)),saveName);%保存为tif格式
    
end
pu_trans_swi = uint16(big_tran_slice);
