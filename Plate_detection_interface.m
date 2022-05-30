function varargout = Plate_detection_interface(varargin)
%PLATE_DETECTION_INTERFACE MATLAB code file for Plate_detection_interface.fig
%      PLATE_DETECTION_INTERFACE, by itself, creates a new PLATE_DETECTION_INTERFACE or raises the existing
%      singleton*.
%
%      H = PLATE_DETECTION_INTERFACE returns the handle to a new PLATE_DETECTION_INTERFACE or the handle to
%      the existing singleton*.
%
%      PLATE_DETECTION_INTERFACE('Property','Value',...) creates a new PLATE_DETECTION_INTERFACE using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Plate_detection_interface_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PLATE_DETECTION_INTERFACE('CALLBACK') and PLATE_DETECTION_INTERFACE('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PLATE_DETECTION_INTERFACE.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Plate_detection_interface

% Last Modified by GUIDE v2.5 25-May-2022 01:03:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Plate_detection_interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Plate_detection_interface_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Plate_detection_interface is made visible.
function Plate_detection_interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Plate_detection_interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Plate_detection_interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Plate_detection_interface_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3)
logo = imread('Yasar_logo.png');
axes(handles.axes3)

imshow(logo)
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile({'*.jpg','*.png'},'Dosya Seçimi');
global PlateDetection
PlateDetection=strcat(pathname,filename);
axis off
axes(handles.axes1)
imshow(PlateDetection)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axis off
axes(handles.axes2)
axis off
global PlateDetection
a=imread(PlateDetection);
im = imread(PlateDetection);
imgray = rgb2gray(im); 
imbin = imbinarize(imgray); 
imgraynew = medfilt2(imgray);
im = edge(imgraynew, 'sobel');
im=imdilate(im,strel('diamond',2));
im2=imfill(im,'holes');
im=imopen(im,strel('rectangle',[2 2]));
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    
im = imcrop(imbin, boundingBox);
im = bwareaopen(~im, 500); 
 [h, w] = size(im);
imshow(im);
Iprops=regionprops(im,'BoundingBox','Area', 'Image'); 
count = numel(Iprops);
noPlate=[]; 

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)
       letter=Letter_detection(Iprops(i).Image);  
       noPlate=[noPlate letter] 
   end
end
 
 set(handles.edit3,'visible','on');
 edit3= sprintf('%s', noPlate);
 set(handles.edit3, 'String',edit3);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
