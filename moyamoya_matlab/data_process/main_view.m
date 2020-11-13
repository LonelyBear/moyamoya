function varargout = main_view(varargin)
% MAIN_VIEW MATLAB code for main_view.fig
%      MAIN_VIEW, by itself, creates a new MAIN_VIEW or raises the existing
%      singleton*.
%
%      H = MAIN_VIEW returns the handle to a new MAIN_VIEW or the handle to
%      the existing singleton*.
%
%      MAIN_VIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_VIEW.M with the given input arguments.
%
%      MAIN_VIEW('Property','Value',...) creates a new MAIN_VIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_view_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_view_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_view

% Last Modified by GUIDE v2.5 06-Jan-2018 14:42:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_view_OpeningFcn, ...
                   'gui_OutputFcn',  @main_view_OutputFcn, ...
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


% --- Executes just before main_view is made visible.
function main_view_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_view (see VARARGIN)

% Choose default command line output for main_view
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_view wait for user response (see UIRESUME)
% uiwait(handles.figure_main);


% --- Outputs from this function are returned to the command line.
function varargout = main_view_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in option_button_swi.
function option_button_swi_Callback(hObject, eventdata, handles)
% hObject    handle to option_button_swi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = swi_view;


% --- Executes on button press in option_button_mra.
function option_button_mra_Callback(hObject, eventdata, handles)
% hObject    handle to option_button_mra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = mra_view;

% --- Executes on button press in option_button_render.
function option_button_render_Callback(hObject, eventdata, handles)
% hObject    handle to option_button_render (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = render_view;

% --- Executes on button press in option_button_registration.
function option_button_registration_Callback(hObject, eventdata, handles)
% hObject    handle to option_button_registration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = registration_view;