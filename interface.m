function varargout = interface(varargin)
% INTERFACE M-file for interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interface

% Last Modified by GUIDE v2.5 25-Aug-2011 13:22:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interface_OpeningFcn, ...
                   'gui_OutputFcn',  @interface_OutputFcn, ...
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


% --- Executes just before interface is made visible.
function interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interface (see VARARGIN)

% Choose default command line output for interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in btnLoad.
function btnLoad_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global processedData;
    global fs;
    global bits;
    global numChannels;
    global numData;

    file = uigetfile('*.wav');
    if ~isequal(file, 0)
        %Get audio information
        [data,fs,bits] = wavread(file);

        %message for retroalimentation
        msg = sprintf('*Fichero %s cargado con exito\n* Bits: %i bits\n*Frecuencia: %i Hz\n', file,bits,fs);
        set(handles.txtResult,'String',msg);
        
        %set to array information of wav data file 
        [numData numChannels]= size(data);

        %Copy to procesed data to global var 
        processedData = data;

        %Update axis 
        UpdateAxis(handles);

        %Enable buttons
        set(handles.btnSave,'Enable','on');
        set(handles.btnPlay,'Enable','on');
        set(handles.btnZoomIn,'Enable','on');
        set(handles.btnZoomOut,'Enable','on');
        set(handles.btnEffect1,'Enable','on');
        set(handles.btnEffect2,'Enable','on');
        
    end


% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in btnPlay.
function btnPlay_Callback(hObject, eventdata, handles)
% hObject    handle to btnPlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    %Get global variables
    global processedData;
    global fs;

    %Play sound
    soundsc(processedData,fs);
    

% --- Executes on button press in btnZoomIn.
function btnZoomIn_Callback(hObject, eventdata, handles)
% hObject    handle to btnZoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnZoomOut.
function btnZoomOut_Callback(hObject, eventdata, handles)
% hObject    handle to btnZoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnEffect1.
function btnEffect1_Callback(hObject, eventdata, handles)
% hObject    handle to btnEffect1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btnEffect2.
function btnEffect2_Callback(hObject, eventdata, handles)
% hObject    handle to btnEffect2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function txtResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnZoomOut.
function btnZoomOut_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnZoomOut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over btnZoomIn.
function btnZoomIn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to btnZoomIn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function UpdateAxis(handles)
    global processedData;
    global numData;
    

    %Plot audio
    axes(handles.axesLeft);
    cla;
    plot(processedData(:,1));
    set(handles.axesLeft,'YTick',[]);
    set(handles.axesLeft,'XTick',[]);

    axes(handles.axesRight);
    cla;
    plot(processedData(:,2));
    set(handles.axesRight,'YTick',[]);
    set(handles.axesRight,'XTick',[]);
    


