clc;clear;close all;
addpath(genpath(pwd));
%swi_Cerebral hemorrhage
[filename_swi,pathname_swi]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'选择出血区域NII' );
if (pathname_swi == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_swi = [pathname_swi,filename_swi];
niiInfo_swi = load_untouch_nii(fpath_swi);
niiData_swi = niiInfo_swi.img;
niiData_hdr_swi = niiInfo_swi.hdr;
[L,M,N] = size(niiData_swi);
%mra_vessel
[filename_mra,pathname_mra]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'选择血管模型NII' );
if (pathname_mra == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_mra = [pathname_mra,filename_mra];
niiInfo_mra = load_untouch_nii(fpath_mra);
niiData_mra = niiInfo_mra.img;
niiData_hdr_mra = niiInfo_mra.hdr;
[L1,M1,N1] = size(niiData_mra);
%mra_lv
[filename_mra_lv,pathname_mra_lv]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'选择lv模型NII' );
if (pathname_mra_lv == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_mra_lv = [pathname_mra_lv,filename_mra_lv];
niiInfo_mra_lv = load_untouch_nii(fpath_mra_lv);
niiData_mra_lv = niiInfo_mra_lv.img;
niiData_hdr_mra_lv = niiInfo_mra_lv.hdr;
[L2,M2,N2] = size(niiData_mra_lv);
%mra_ini
[filename_mra_ini,pathname_mra_ini]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'选择mra最初的模型NII' );
if (pathname_mra_ini == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath_mra_ini = [pathname_mra_ini,filename_mra_ini];
niiInfo_mra_ini = load_untouch_nii(fpath_mra_ini);
niiData_mra_ini = niiInfo_mra_ini.img;
niiData_hdr_mra_ini = niiInfo_mra_ini.hdr;
[L3,M3,N3] = size(niiData_mra_ini);
%processing
volume_res = niiData_mra;
for i = 1:L
    for j = 1:M
        for k = 1:N
            if niiData_swi(i,j,k) ~=0
                volume_res(i,j,k) = 3000;
            end
            if niiData_mra_lv(i,j,k) ~=0 
                volume_res(i,j,k) = volume_res(i,j,k) + niiData_mra_ini(i,j,k);
            end
        end
    end
end

[filename,pathname]=uiputfile({'*.nii', 'NIfTI file'},'最终结果保存为NIfTI格式文件');
if(filename == 0)
    return;
end
fpath = [pathname,filename];
Niidata = struct( 'hdr',niiData_hdr_mra,...
                  'filetype',2,...
                  'fileprefix','',...
                  'machine','',...
                  'ext',[],...
                  'img',volume_res,...
                  'untouch',1);
              
save_untouch_nii(Niidata,fpath);



