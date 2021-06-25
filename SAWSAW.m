function varargout = SAWSAW(varargin)
% SAWSAW MATLAB code for SAWSAW.fig
%      SAWSAW, by itself, creates a new SAWSAW or raises the existing
%      singleton*.
%
%      H = SAWSAW returns the handle to a new SAWSAW or the handle to
%      the existing singleton*.
%
%      SAWSAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAWSAW.M with the given input arguments.
%
%      SAWSAW('Property','Value',...) creates a new SAWSAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAWSAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAWSAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAWSAW

% Last Modified by GUIDE v2.5 25-Jun-2021 20:34:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAWSAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SAWSAW_OutputFcn, ...
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


% --- Executes just before SAWSAW is made visible.
function SAWSAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAWSAW (see VARARGIN)

% Choose default command line output for SAWSAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAWSAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAWSAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_push.
function pb_push_Callback(hObject, eventdata, handles)
opts = detectImportOptions('DataRumah.xlsx');
opts.SelectedVariableNames = [3,4,5,6,7,8];
data = readmatrix('DataRumah.xlsx',opts);
set(handles.uitable1,'data',data);
% hObject    handle to pb_push (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_clear.
function pb_clear_Callback(hObject, eventdata, handles)
data='';
set(handles.uitable1,'data',data);
% hObject    handle to pb_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pb_proses.
function pb_proses_Callback(hObject, eventdata, handles)
w = [0.3, 0.2, 0.23, 0.1, 0.07, 0.1];
k = [0,1,1,1,1,1];
raw = xlsread('DataRumah.xlsx','C2:H1011');

[m,n]=size (raw); 
R=zeros (m,n); 
%Y=zeros (m,n);
for j=1:n
    if k(j)==1
        R(:,j)=raw(:,j)./max(raw(:,j));
    else
        R(:,j)=min(raw(:,j))./raw(:,j);
    end
end

for i=1:m
    V(i)= sum(w.*R(i,:));
end

rank = sort(V,'descend');

for i=1:20
    hasil(i) = rank(i);
end

opts2 = detectImportOptions('DataRumah.xlsx'); %mendeteksi file DATA RUMAH.xlsx
opts2.SelectedVariableNames = [2]; %memilih hanya kolom Nama Rumah

namaRumah = readmatrix('DataRumah.xlsx',opts2);

for i=1:20
 for j=1:m
   if(hasil(i) == V(j))
    sorting(i) = namaRumah(j);
    break
   end
 end
end

sorting = sorting';

set(handles.uitable2, 'data', sorting); 
% hObject    handle to pb_proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
