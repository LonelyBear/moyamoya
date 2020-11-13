function varargout = mra_view(varargin)
addpath(genpath(pwd));
% MRA_VIEW MATLAB code for mra_view.fig
%      MRA_VIEW, by itself, creates a new MRA_VIEW or raises the existing
%      singleton*.
%
%      H = MRA_VIEW returns the handle to a new MRA_VIEW or the handle to
%      the existing singleton*.
%
%      MRA_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MRA_VIEW.M with the given input arguments.
%
%      MRA_VIEW('Property','Value',...) creates a new MRA_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mra_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mra_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mra_view

% Last Modified by GUIDE v2.5 22-Jan-2018 14:14:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mra_view_OpeningFcn, ...
                   'gui_OutputFcn',  @mra_view_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mra_view is made visible.
function mra_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mra_view (see VARARGIN)

% Choose default command line output for mra_view
handles.output = hObject;
set(hObject,'toolbar','figure') % 在菜单栏显示figure工具条的内容

%%%%%设置句柄初始值%%%%%
set(handles.m_image,'Enable' , 'off' );
set(handles.slider_axes_input,'Enable' , 'off' );
set(handles.slider_axes_output,'Enable' , 'off' );
set(handles.edit_axes_input_slice,'Enable' , 'off' );
set(handles.edit_axes_output_slice,'Enable' , 'off' );
set(handles.text_axes_input_slice,'Enable' , 'off' );
set(handles.text_axes_output_slice,'Enable' , 'off' );

%%%%%设置程序初始参数%%%%%
setappdata(handles.figure_mra,'bChanged' ,false);       %数据是否发生改变
setappdata(handles.figure_mra,'bSave' ,false);          %数据是否保存
setappdata(handles.figure_mra,'b_mra_volume' ,false);   %是否有原始数据
setappdata(handles.figure_mra,'b_mra_volume_processed' ,false);   %是否有处理数据

%%%NIfTI的头文件信息  默认为MRA目前没有进行坐标系变换，使用默认的头文件进行读写
niiData_hdr = struct('hk',struct(   'sizeof_hdr',348,...
                                    'data_type','',...
                                    'db_name','',...
                                    'extents',0,...
                                    'session_error',0,...
                                    'regular','r',...
                                    'dim_info',0),...
                     'dime',struct( 'dim',[0,0,0,0,0,0,0,0],...
                                    'intent_p1',0,...
                                    'intent_p2',0,...
                                    'intent_p3',0,...
                                    'intent_code',0,...
                                    'datatype',0,...
                                    'bitpix',0,...
                                    'slice_start',0,...
                                    'pixdim',[0,0,0,0,0,0,0,0],...
                                    'vox_offset',0,...
                                    'scl_slope',0,...
                                    'scl_inter',0,...
                                    'slice_end',0,...
                                    'slice_code',0,...
                                    'xyzt_units',0,...
                                    'cal_max',0,...
                                    'cal_min',0,...
                                    'slice_duration',0,...
                                    'toffset',0,...
                                    'glmax',0,...
                                    'glmin',0),...
                    'hist',struct(  'descrip','',...
                                    'aux_file','',...
                                    'qform_code',0,...
                                    'sform_code',0,...
                                    'quatern_b',0,...
                                    'quatern_c',0,...
                                    'quatern_d',0,...
                                    'qoffset_x',0,...
                                    'qoffset_y',0,...
                                    'qoffset_z',0,...
                                    'srow_x',[0,0,0,0],...
                                    'srow_y',[0,0,0,0],...
                                    'srow_z',[0,0,0,0],...
                                    'intent_name','',...
                                    'magic','',...
                                    'originator',[0,0,0,0,0]));
setappdata(handles.figure_mra,'niiData_hdr' ,niiData_hdr);   %是否有处理数据

%%%%%设置图像数据%%%%%
setappdata(handles.figure_mra,'mra_volume',0);  % 用于显示1
setappdata(handles.figure_mra,'mra_volume_height',0);
setappdata(handles.figure_mra,'mra_volume_width',0);
setappdata(handles.figure_mra,'mra_volume_slice',0);
setappdata(handles.figure_mra,'mra_volume_voxel_size',[0,0,0]);

setappdata(handles.figure_mra,'mra_volume_processed',0);%用于显示2
setappdata(handles.figure_mra,'mra_volume_processed_height',0);
setappdata(handles.figure_mra,'mra_volume_processed_width',0);
setappdata(handles.figure_mra,'mra_volume_processed_slice',0);
setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',[0,0,0]);

setappdata(handles.figure_mra,'mra_volume_position',0);%用于记录分割结果
setappdata(handles.figure_mra,'mra_volume_position_height',0);
setappdata(handles.figure_mra,'mra_volume_position_width',0);
setappdata(handles.figure_mra,'mra_volume_position_slice',0);
setappdata(handles.figure_mra,'mra_volume_position_voxel_size',[0,0,0]);

%%%设置坐标系显示层数
setappdata(handles.figure_mra,'axe_input_slice',1);
setappdata(handles.figure_mra,'axe_output_slice',1);
show_volume = getappdata(handles.figure_mra,'mra_volume');
axes(handles.axes_input);
imshow(show_volume);
show_volume = getappdata(handles.figure_mra,'mra_volume_processed');
axes(handles.axes_output);
imshow(show_volume);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mra_view wait for user response (see UIRESUME)
% uiwait(handles.figure_mra);


% --- Outputs from this function are returned to the command line.
function varargout = mra_view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_axes_input_Callback(hObject, eventdata, handles)
% hObject    handle to slider_axes_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'Value');
volume_slice = getappdata(handles.figure_mra,'mra_volume_slice');
slide_val = round(val*volume_slice);
if(slide_val == 0)
    slide_val = 1;
end
set(handles.text_axes_input_slice,'String' ,num2str(slide_val));
axes(handles.axes_input);
inshow_volume = getappdata(handles.figure_mra,'mra_volume');
setappdata(handles.figure_mra,'axe_input_slice',slide_val);
imshow(inshow_volume(:,:,slide_val),[]);

% --- Executes during object creation, after setting all properties.
function slider_axes_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_axes_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_axes_output_Callback(hObject, eventdata, handles)
% hObject    handle to slider_axes_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
val = get(hObject,'Value');
volume_slice = getappdata(handles.figure_mra,'mra_volume_processed_slice');
slide_val = round(val*volume_slice);
if(slide_val == 0)
    slide_val = 1;
end
set(handles.text_axes_output_slice,'String' ,num2str(slide_val));
axes(handles.axes_output);
outshow_volume = getappdata(handles.figure_mra,'mra_volume_processed');
setappdata(handles.figure_mra,'axe_output_slice',slide_val);
imshow(outshow_volume(:,:,slide_val),[]);

% --- Executes during object creation, after setting all properties.
function slider_axes_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_axes_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_axes_input_slice_Callback(hObject, eventdata, handles)
% hObject    handle to edit_axes_input_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_axes_input_slice as text
%        str2double(get(hObject,'String')) returns contents of edit_axes_input_slice as a double
edit_axes_input_slice_value = get(hObject,'String');
edit_axes_input_slice_value = str2double(edit_axes_input_slice_value);
volume_slice = getappdata(handles.figure_mra,'mra_volume_slice');
if(rem(edit_axes_input_slice_value,1))
    return
else
    if(edit_axes_input_slice_value >= 1 && edit_axes_input_slice_value <= volume_slice)
        setappdata(handles.figure_mra,'axe_input_slice',edit_axes_input_slice_value);
        axes(handles.axes_input);
        inshow_volume = getappdata(handles.figure_mra,'mra_volume');
        imshow(inshow_volume(:,:,edit_axes_input_slice_value),[]);
        set(handles.text_axes_input_slice,'String',num2str(edit_axes_input_slice_value));
        set(handles.slider_axes_input,'Value',edit_axes_input_slice_value/volume_slice);
    else
        return
    end
end

% --- Executes during object creation, after setting all properties.
function edit_axes_input_slice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axes_input_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_axes_output_slice_Callback(hObject, eventdata, handles)
% hObject    handle to edit_axes_output_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_axes_output_slice as text
%        str2double(get(hObject,'String')) returns contents of edit_axes_output_slice as a double
edit_axes_output_slice_value = get(hObject,'String');
edit_axes_output_slice_value = str2double(edit_axes_output_slice_value);
volume_slice = getappdata(handles.figure_mra,'mra_volume_processed_slice');
if(rem(edit_axes_output_slice_value,1))
    return
else
    if(edit_axes_output_slice_value >= 1 && edit_axes_output_slice_value <= volume_slice)
        setappdata(handles.figure_mra,'axe_output_slice',edit_axes_output_slice_value);
        axes(handles.axes_output);
        inshow_volume = getappdata(handles.figure_mra,'mra_volume_processed');
        imshow(inshow_volume(:,:,edit_axes_output_slice_value),[]);
        set(handles.text_axes_output_slice,'String',num2str(edit_axes_output_slice_value));
        set(handles.slider_axes_output,'Value',edit_axes_output_slice_value/volume_slice);
    else
        return
    end
end

% --- Executes during object creation, after setting all properties.
function edit_axes_output_slice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_axes_output_slice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function m_file_Callback(hObject, eventdata, handles)
% hObject    handle to m_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_image_Callback(hObject, eventdata, handles)
% hObject    handle to m_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function m_image_copy_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
volume_pro = getappdata(handles.figure_mra,'mra_volume');
mra_volume_voxel_size = getappdata(handles.figure_mra,'mra_volume_voxel_size');
mra_volume_processed_voxel_size = mra_volume_voxel_size;
volume_copy = volume_pro;
setappdata(handles.figure_mra,'bChanged' ,true);
[L,M,N] = size(volume_copy);

setappdata(handles.figure_mra,'mra_volume_processed_height',L);
setappdata(handles.figure_mra,'mra_volume_processed_width',M);
setappdata(handles.figure_mra,'mra_volume_processed_slice',N);
setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',mra_volume_processed_voxel_size);
setappdata(handles.figure_mra,'mra_volume_processed',volume_copy);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,true); 
set(handles.slider_axes_output,'Enable' , 'on' );
set(handles.edit_axes_output_slice,'Enable' , 'on' );
set(handles.text_axes_output_slice,'Enable' , 'on' );

axes(handles.axes_output);
axes_slice = getappdata(handles.figure_mra,'axe_output_slice');
imshow(volume_copy(:,:,axes_slice),[]);
clear volume_copy;

% --------------------------------------------------------------------
function m_image_filter_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function m_file_openTif_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_openTif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
{'*.tif', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'Select the image sequence' );
if (pathname == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath = [pathname,filename];
ini_image = imread(fpath);
[L,M] = size(ini_image);
clear ini_image;
fileInfo = dir(pathname);
folderName = fileInfo(1,1).folder;
volume_input = zeros(L,M,length(fileInfo)-2);
%%%
setappdata(handles.figure_mra,'mra_volume_height',L);
setappdata(handles.figure_mra,'mra_volume_width',M);
setappdata(handles.figure_mra,'mra_volume_slice',length(fileInfo)-2);
%%%
for i = 3:length(fileInfo)  
    fpath=[folderName,'\',fileInfo(i,1).name];
    img_num = fileInfo(i,1).name;
    img_num(end-3:end) = [];
    img_temp = imread(fpath);
    volume_slice = str2num(img_num);
    img_temp = double(img_temp);
    volume_input(:,:,volume_slice) = img_temp;
end

setappdata(handles.figure_mra,'mra_volume',volume_input);
setappdata(handles.figure_mra,'b_mra_volume' ,true); 
set(handles.slider_axes_input,'Enable' , 'on' );
set(handles.edit_axes_input_slice,'Enable' , 'on' );
set(handles.text_axes_input_slice,'Enable' , 'on' );

axes(handles.axes_input);
axes_slice = getappdata(handles.figure_mra,'axe_input_slice');
imshow(volume_input(:,:,axes_slice),[]);
set(handles.m_image,'Enable' , 'on' );

% --------------------------------------------------------------------
function m_file_openDicom_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_openDicom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
{ '*.*', 'All Files (*.*)'},'Select the image sequence' );
if (pathname == 0)
    msgbox('No choice');  
    return; %exit    
end

fpath = [pathname,filename];
ini_image = dicomread(fpath);
[L,M] = size(ini_image);
clear ini_image;
fileInfo = dir(pathname);
folderName = fileInfo(1,1).folder;
volume_input = zeros(L,M,length(fileInfo)-2);
%%%
setappdata(handles.figure_mra,'mra_volume_height',L);
setappdata(handles.figure_mra,'mra_volume_width',M);
setappdata(handles.figure_mra,'mra_volume_slice',length(fileInfo)-2);
%%%
for i = 3:length(fileInfo)  
    fpath=[folderName,'\',fileInfo(i,1).name];
    img_temp = dicomread(fpath);
    volume_slice = i-2;%
    img_temp = double(img_temp);
    volume_input(:,:,volume_slice) = img_temp;
end

setappdata(handles.figure_mra,'mra_volume',volume_input);
setappdata(handles.figure_mra,'b_mra_volume' ,true); 
set(handles.slider_axes_input,'Enable' , 'on' );
set(handles.edit_axes_input_slice,'Enable' , 'on' );
set(handles.text_axes_input_slice,'Enable' , 'on' );

axes(handles.axes_input);
axes_slice = getappdata(handles.figure_mra,'axe_input_slice');
imshow(volume_input(:,:,axes_slice),[]);
set(handles.m_image,'Enable' , 'on' );

% --------------------------------------------------------------------
function m_file_openNii_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_openNii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile(...
{'*.nii', 'Image Files (*.tif)'; '*.*', 'All Files (*.*)'},'Select the image sequence' );
if (pathname == 0)
    msgbox('No choice');  
    return; %exit    
end
fpath = [pathname,filename];

%%%SPM的函数
% niiInfo = spm_vol_nifti(fpath);
% niiData = spm_read_vols(niiInfo);

%%%NIfTI的函数
niiInfo = load_untouch_nii(fpath);
niiData = niiInfo.img;
setappdata(handles.figure_mra,'niiData_hdr' ,niiInfo.hdr);
%%%通过spm的函数都进来的nii的数据文件就会发生坐标颠倒，接下来的操作是调整数据方向
%%%原因不明，先进行强制转换
[L,M,N] = size(niiData);
tranNiiData = zeros(M,L,N);
for slice = 1:N
   for i = 1:L
        for k = 1:M
            tranNiiData(M+1-k,i,slice) = niiData(i,k,slice);
        end
   end    
end
clear niiData;

setappdata(handles.figure_mra,'mra_volume_height',M);
setappdata(handles.figure_mra,'mra_volume_width',L);
setappdata(handles.figure_mra,'mra_volume_slice',N);
mra_volume_voxel_size(1:3) = niiInfo.hdr.dime.pixdim(2:4);
setappdata(handles.figure_mra,'mra_volume_voxel_size',mra_volume_voxel_size);
setappdata(handles.figure_mra,'mra_volume',tranNiiData);
setappdata(handles.figure_mra,'b_mra_volume' ,true); 
set(handles.slider_axes_input,'Enable' , 'on' );
set(handles.edit_axes_input_slice,'Enable' , 'on' );
set(handles.text_axes_input_slice,'Enable' , 'on' );

axes(handles.axes_input);
axes_slice = getappdata(handles.figure_mra,'axe_input_slice');
imshow(tranNiiData(:,:,axes_slice),[]);
set(handles.m_image,'Enable' , 'on' );

% --------------------------------------------------------------------
function m_file_saveTif_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_saveTif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m_bChanged = getappdata(handles.figure_mra,'bChanged');
m_b_mra_volume_processed = getappdata(handles.figure_mra,'b_mra_volume_processed'); 
if(m_bChanged == false)
    msgbox('没有对数据进行操作，不需要保存');
    return;
end
if(m_b_mra_volume_processed == false)
    msgbox('没有处理过的数据，无法保存');
    return;
end
volume_slice = getappdata(handles.figure_mra,'mra_volume_processed_slice');
volume_toSave = getappdata(handles.figure_mra,'mra_volume_processed');
[filename,pathname]=uiputfile('default.tif','选择文件夹进行逐层图像保存,请提前新建一个文件夹');
if(filename == 0)
    return;
end
for i = 1:volume_slice
    tifName = strcat(pathname,int2str(i),'.tif');
    imwrite(uint16(volume_toSave(:,:,i)),tifName);
end
setappdata(handles.figure_mra,'bSave' ,true); 

% --------------------------------------------------------------------
function m_file_saveNii_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_saveNii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m_bChanged = getappdata(handles.figure_mra,'bChanged');
m_b_mra_volume_processed = getappdata(handles.figure_mra,'b_mra_volume_processed'); 
if(m_bChanged == false)
    msgbox('没有对数据进行操作，不需要保存');
    return;
end
if(m_b_mra_volume_processed == false)
    msgbox('没有处理过的数据，无法保存');
    return;
end
volume_slice = getappdata(handles.figure_mra,'mra_volume_processed_slice');
volume_toSave = getappdata(handles.figure_mra,'mra_volume_processed');
[filename,pathname]=uiputfile({'*.nii', 'NIfTI file'},'保存为NIfTI格式文件');
if(filename == 0)
    return;
end
fpath = [pathname,filename];
%%%%%因为spm函数读取的原因，偷懒不想认真读NIfTI工具包的函数说明了%%%%%
%%%%%以MRA-tof为例，原有的768*584的DICOM图像在SPM软件转换后变成了594*768，通过重新坐标读取进行纠正%%%%%
%%%%%目前也没想出更好的方法%%%%%
%%%%%转换后的数据又在ITK-SNAP里反了，不完善解决
M = getappdata(handles.figure_mra,'mra_volume_processed_height');
L = getappdata(handles.figure_mra,'mra_volume_processed_width');
volume_toNii = zeros(L,M,volume_slice);
for slice = 1 :volume_slice
    for j = 1:M
        for k =1:L
            volume_toNii(k,M+1-j,slice) = volume_toSave(j,k,slice);
        end
    end
end
%NiiData = make_nii(volume_toNii,[0.286326766014099,0.286326795816422,0.500000000000000],[-75.2182,115.9761,77.2495],512);
niiData_hdr = getappdata(handles.figure_mra,'niiData_hdr');
mra_volume_voxel_processed_size = getappdata(handles.figure_mra,'mra_volume_processed_voxel_size');
niiData_hdr.dime.dim = [3,L,M,volume_slice,1,1,1,1];
niiData_hdr.dime.pixdim = [-1,mra_volume_voxel_processed_size(1),...
                            mra_volume_voxel_processed_size(2),...
                            mra_volume_voxel_processed_size(3),0,0,0,0];
Niidata = struct( 'hdr',niiData_hdr,...
                  'filetype',2,...
                  'fileprefix','',...
                  'machine','',...
                  'ext',[],...
                  'img',volume_toNii,...
                  'untouch',1);
              
save_untouch_nii(Niidata,fpath);
%save_nii(NiiData,fpath);
setappdata(handles.figure_mra,'bSave',true);

% --------------------------------------------------------------------
function m_file_clearInputData_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_clearInputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.figure_mra,'mra_volume_height',0);
setappdata(handles.figure_mra,'mra_volume_width',0);
setappdata(handles.figure_mra,'mra_volume_slice',0);
setappdata(handles.figure_mra,'mra_volume',0);
setappdata(handles.figure_mra,'b_mra_volume' ,false); 
set(handles.slider_axes_input,'Enable' , 'off' );
set(handles.edit_axes_input_slice,'Enable' , 'off' );
set(handles.text_axes_input_slice,'Enable' , 'off' );

axes(handles.axes_input);
show_volume = getappdata(handles.figure_mra,'mra_volume');
imshow(show_volume);

% --------------------------------------------------------------------
function m_file_clearOutputData_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_clearOutputData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.figure_mra,'mra_volume_processed_height',0);
setappdata(handles.figure_mra,'mra_volume_processed_width',0);
setappdata(handles.figure_mra,'mra_volume_processed_slice',0);
setappdata(handles.figure_mra,'mra_volume_processed',0);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,0); 
set(handles.slider_axes_output,'Enable' , 'off' );
set(handles.edit_axes_output_slice,'Enable' , 'off' );
set(handles.text_axes_output_slice,'Enable' , 'off' );

axes(handles.axes_output);
show_volume = getappdata(handles.figure_mra,'mra_volume_processed');
imshow(show_volume);

% --------------------------------------------------------------------
function m_file_exit_Callback(hObject, eventdata, handles)
% hObject    handle to m_file_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m_bChanged = getappdata(handles.figure_mra,'bChanged');
m_b_save = getappdata(handles.figure_mra,'bSave'); 
if(m_bChanged == true && m_b_save == false)
    btnName=questdlg('数据已更新，是否保存到本地磁盘', '提示', '保存', '不保存','保存');
    switch btnName 
        case '保存'
            save_type=questdlg('选择保存方式', '提示', '保存为Tif文件', '保存为Nii文件','保存成Mat文件','保存为Tif文件');
            switch save_type
                case '保存为Nii文件'
                    feval(@m_file_saveNii_Callback,handles.m_file_saveNii,eventdata,handles);
                case '保存为Tif文件'
                    feval(@m_file_saveTif_Callback,handles.m_file_saveTif,eventdata,handles);
                case '保存成Mat文件'
                    feval(@m_file_saveNii_Callback,handles.m_file_saveNii,eventdata,handles);
            end
        case '不保存'
            return;
    end
end
m_b_save = getappdata(handles.figure_mra,'bSave'); 
if(m_b_save == true)
    close(findobj('Tag' , 'figure_mra'));
end

% --------------------------------------------------------------------
function m_image_filter_median_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_filter_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('三维中值滤波');
t_filterMedian_start = clock;

%%% 获取体素数据
volume_pro = getappdata(handles.figure_mra,'mra_volume');

%%%操作
volume_medfilt = medfilt3(volume_pro);

%%%数据存储并显示
[L,M,N] = size(volume_medfilt);
setappdata(handles.figure_mra,'bChanged',true);
setappdata(handles.figure_mra,'mra_volume_processed_height',L);
setappdata(handles.figure_mra,'mra_volume_processed_width',M);
setappdata(handles.figure_mra,'mra_volume_processed_slice',N);
%setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',mra_volume_processed_voxel_size);
setappdata(handles.figure_mra,'mra_volume_processed',volume_medfilt);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,true); 
set(handles.slider_axes_output,'Enable' , 'on' );
set(handles.edit_axes_output_slice,'Enable' , 'on' );
set(handles.text_axes_output_slice,'Enable' , 'on' );
axes(handles.axes_output);
axes_slice = getappdata(handles.figure_mra,'axe_output_slice');
imshow(volume_medfilt(:,:,axes_slice),[]);

%%% end
clear volume_medfilt;
t_filterMedian_end = clock;
disp(['中值滤波过程时间: ' num2str(etime(t_filterMedian_end,t_filterMedian_start))]);


% --------------------------------------------------------------------
function m_image_filter_Anisotropic_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_filter_Anisotropic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('三维各向异性滤波');
t_filterAnisotropic_start = clock;

%%% 获取体素数据
volume_pro = getappdata(handles.figure_mra,'mra_volume');

%%%操作
voxel_spacing = ones(3,1);
volume_anisotropic = anisodiff3D(volume_pro,1,3/44,70,2,voxel_spacing);

%%%数据存储并显示
[L,M,N] = size(volume_anisotropic);
setappdata(handles.figure_mra,'bChanged' ,true);
setappdata(handles.figure_mra,'mra_volume_processed_height',L);
setappdata(handles.figure_mra,'mra_volume_processed_width',M);
setappdata(handles.figure_mra,'mra_volume_processed_slice',N);
%setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',mra_volume_processed_voxel_size);
setappdata(handles.figure_mra,'mra_volume_processed',volume_anisotropic);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,true); 
set(handles.slider_axes_output,'Enable' , 'on' );
set(handles.edit_axes_output_slice,'Enable' , 'on' );
set(handles.text_axes_output_slice,'Enable' , 'on' );
axes(handles.axes_output);
axes_slice = getappdata(handles.figure_mra,'axe_output_slice');
imshow(volume_anisotropic(:,:,axes_slice),[]);

%%% end
clear volume_anisotropic;
t_filterAnisotropic_end = clock;
disp(['各项异性滤波过程时间: ' num2str(etime(t_filterAnisotropic_end,t_filterAnisotropic_start))]);



% --------------------------------------------------------------------
function m_image_hessianEnhance_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_hessianEnhance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('多尺度因子高斯函数卷积与hessian矩阵血管增强');
t_hessianEnhance_start = clock;

%%% 获取体素数据
volume_pro = getappdata(handles.figure_mra,'mra_volume');
mra_volume_voxel_size = getappdata(handles.figure_mra,'mra_volume_voxel_size');

%%%操作
volume_vessel = vesselSegment(volume_pro);
mra_volume_processed_voxel_size = mra_volume_voxel_size;
%%%数据存储并显示
[L,M,N] = size(volume_vessel);
setappdata(handles.figure_mra,'bChanged',true);
setappdata(handles.figure_mra,'mra_volume_processed_height',L);
setappdata(handles.figure_mra,'mra_volume_processed_width',M);
setappdata(handles.figure_mra,'mra_volume_processed_slice',N);
setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',mra_volume_processed_voxel_size);
setappdata(handles.figure_mra,'mra_volume_processed',volume_vessel);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,true); 
set(handles.slider_axes_output,'Enable' , 'on' );
set(handles.edit_axes_output_slice,'Enable' , 'on' );
set(handles.text_axes_output_slice,'Enable' , 'on' );
axes(handles.axes_output);
axes_slice = getappdata(handles.figure_mra,'axe_output_slice');
imshow(volume_vessel(:,:,axes_slice),[]);

%%% end
clear volume_vessel;
t_hessianEnhance_end = clock;
disp(['多尺度因子高斯函数卷积与hessian矩阵血管增强 时间: ' num2str(etime(t_hessianEnhance_end,t_hessianEnhance_start))]);


% --------------------------------------------------------------------
function m_image_vesselPostFilter_Callback(hObject, eventdata, handles)
% hObject    handle to m_image_vesselPostFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('增强后的血管后处理步骤');
t_vesselPostFilter_start = clock;

%%% 获取体素数据
volume_pro = getappdata(handles.figure_mra,'mra_volume');
mra_volume_voxel_size = getappdata(handles.figure_mra,'mra_volume_voxel_size');

%%%操作
volume_vesselPost = vesselPostFilter(volume_pro);
mra_volume_processed_voxel_size = mra_volume_voxel_size;
%%%数据存储并显示
[L,M,N] = size(volume_vesselPost);
setappdata(handles.figure_mra,'bChanged',true);
setappdata(handles.figure_mra,'mra_volume_processed_height',L);
setappdata(handles.figure_mra,'mra_volume_processed_width',M);
setappdata(handles.figure_mra,'mra_volume_processed_slice',N);
setappdata(handles.figure_mra,'mra_volume_processed_voxel_size',mra_volume_processed_voxel_size);
setappdata(handles.figure_mra,'mra_volume_processed',volume_vesselPost);
setappdata(handles.figure_mra,'b_mra_volume_processed' ,true); 
set(handles.slider_axes_output,'Enable' , 'on' );
set(handles.edit_axes_output_slice,'Enable' , 'on' );
set(handles.text_axes_output_slice,'Enable' , 'on' );
axes(handles.axes_output);
axes_slice = getappdata(handles.figure_mra,'axe_output_slice');
imshow(volume_vesselPost(:,:,axes_slice),[]);

%%% end
clear volume_vesselPost;
t_vesselPostFilter_end = clock;
disp(['增强后的血管后处理步骤 时间: ' num2str(etime(t_vesselPostFilter_end,t_vesselPostFilter_start))]);