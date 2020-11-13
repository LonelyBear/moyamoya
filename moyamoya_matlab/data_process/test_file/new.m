clear;clc;close all;

% [filename,pathname]=uigetfile(...
% {'*.*', 'All Files (*.*)'},'Select' );
% if (pathname == 0)
%     msgbox('No choice');  
%     return; %exit    
% end
% fileInfo = dir(pathname);
% fid = fopen('vtk.txt','w');
% for i = 3 :125
%     fileName = fileInfo(i,1).name;
%     fprintf(fid,'%s\t',fileName);
% end
% fclose(fid);

I = imread('lena.jpg');
figure(1),imshow(I),title('Original Image');

BW = imbinarize(I);
figure,imshow(BW),title('Original Image Converted to Binary Image');



BW2 = imfill(BW,'holes');
figure,imshow(BW2),title('Filled Image');

