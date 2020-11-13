clc;clear;close all;
addpath(genpath(pwd));
[filename_swi,pathname_swi]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'Select the image sequence' );
if (pathname_swi == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_swi = [pathname_swi,filename_swi];

%%%SPM的函数
% niiInfo = spm_vol_nifti(fpath);
% niiData = spm_read_vols(niiInfo);

%%%NIfTI的函数
niiInfo_swi = load_untouch_nii(fpath_swi);
niiData_swi = niiInfo_swi.img;
niiData_hdr_swi = niiInfo_swi.hdr;

%setappdata(handles.figure_swi,'niiData_hdr' ,niiInfo.hdr);
%%%通过spm的函数都进来的nii的数据文件就会发生坐标颠倒，接下来的操作是调整数据方向
%%%原因不明，先进行强制转换
[L,M,N] = size(niiData_swi);
% tranNiiData_swi = zeros(M,L,N);
% for slice = 1:N
%    for i = 1:L
%         for k = 1:M
%             tranNiiData_swi(M+1-k,i,slice) = niiData_swi(i,k,slice);
%         end
%    end    
% end

[filename_mra,pathname_mra]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'Select the image sequence' );
if (pathname_mra == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_mra = [pathname_mra,filename_mra];

%%%SPM的函数
% niiInfo = spm_vol_nifti(fpath);
% niiData = spm_read_vols(niiInfo);

%%%NIfTI的函数
niiInfo_mra = load_untouch_nii(fpath_mra);
niiData_mra = niiInfo_mra.img;
niiData_hdr_mra = niiInfo_mra.hdr;

%setappdata(handles.figure_swi,'niiData_hdr' ,niiInfo.hdr);
%%%通过spm的函数都进来的nii的数据文件就会发生坐标颠倒，接下来的操作是调整数据方向
%%%原因不明，先进行强制转换
[L1,M1,N1] = size(niiData_mra);
for i = 1:L
    for j = 1:M
        for k = 1:N
            if niiData_swi(i,j,k) ~= 0
                niiData_mra(i,j,k) = 200;
            end
        end
    end
end
[filename,pathname]=uiputfile({'*.nii', 'NIfTI file'},'保存为NIfTI格式文件');
if(filename == 0)
    return;
end
fpath = [pathname,filename];
Niidata = struct( 'hdr',niiData_hdr_mra,...
                  'filetype',2,...
                  'fileprefix','',...
                  'machine','',...
                  'ext',[],...
                  'img',niiData_mra,...
                  'untouch',1);
              
save_untouch_nii(Niidata,fpath);
% tranNiiData_mra = zeros(M,L,N);
% for slice = 1:N
%    for i = 1:L
%         for k = 1:M
%             tranNiiData_mra(M+1-k,i,slice) = niiData_mra(i,k,slice);
%         end
%    end    
% end


% clear niiData;
% 
% setappdata(handles.figure_swi,'swi_volume_height',M);
% setappdata(handles.figure_swi,'swi_volume_width',L);
% setappdata(handles.figure_swi,'swi_volume_slice',N);
% swi_volume_voxel_size(1:3) = niiInfo.hdr.dime.pixdim(2:4);
% setappdata(handles.figure_swi,'swi_volume_voxel_size',swi_volume_voxel_size);
% setappdata(handles.figure_swi,'swi_volume',tranNiiData);
% setappdata(handles.figure_swi,'b_swi_volume' ,true); 
% set(handles.slider_axes_input,'Enable' , 'on' );
% set(handles.edit_axes_input_slice,'Enable' , 'on' );
% set(handles.text_axes_input_slice,'Enable' , 'on' );
% 
% axes(handles.axes_input);
% axes_slice = getappdata(handles.figure_swi,'axe_input_slice');
% imshow(tranNiiData(:,:,axes_slice),[]);
% set(handles.m_image,'Enable' , 'on' );