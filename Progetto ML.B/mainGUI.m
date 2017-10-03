function varargout = mainGUI(varargin)
% MAINGUI
 % MLB - GUI principale del software
 
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainGUI

% Last Modified by GUIDE v2.5 20-Sep-2016 15:04:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @mainGUI_OutputFcn, ...
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

% --- Executes just before mainGUI is made visible.
function mainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainGUI (see VARARGIN)

% Choose default command line output for mainGUI
handles.output = hObject;
resetGUI(handles);
usoGUI = 1;
modTR = 2;
loadedData=0;
assignin('base','modTR',modTR);
assignin('base','usoGUI',usoGUI);
assignin('base','loadedData',loadedData);
%MLB - Disabilittiamo le schermate per l'apprendimento e la validazioned
set(findall(handles.addestra_rete,'-property','Enable'),'Enable','off');


% Update handles structure
guidata(hObject, handles);
% UIWAIT makes mainGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function features_edit_Callback(hObject, eventdata, handles)
% hObject    handle to features_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of features_edit as text
%        str2double(get(hObject,'String')) returns contents of features_edit as a double


% --- Executes during object creation, after setting all properties.
function features_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to features_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stratiInterni_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stratiInterni_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stratiInterni_edit as text
%        str2double(get(hObject,'String')) returns contents of stratiInterni_edit as a double


% --- Executes during object creation, after setting all properties.
function stratiInterni_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stratiInterni_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function funzioniOutput_edit_Callback(hObject, eventdata, handles)
% hObject    handle to funzioniOutput_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of funzioniOutput_edit as text
%        str2double(get(hObject,'String')) returns contents of funzioniOutput_edit as a double


% --- Executes during object creation, after setting all properties.
function funzioniOutput_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to funzioniOutput_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in creaModifica_button.
function creaModifica_button_Callback(hObject, eventdata, handles)
% hObject    handle to creaModifica_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%MLB - prendiamo i parametri dalla GUI per la creazione della rete e
%togliamo gli spazi
netGUI.features = get(handles.features_edit,'String');
netGUI.interni = regexprep(get(handles.stratiInterni_edit,'String'),'\s','');
netGUI.funzioni = regexprep(get(handles.funzioniOutput_edit,'String'),'\s','');
netGUI.err= regexprep(get(handles.err_edit,'String'),'\s','');

%MLB - validiamo i parametri tramite il metodo checkRete 
[check, c1,c2,c3] = checkRete(netGUI,handles);
disp(check);
disp(c1);
disp(c2);
disp(c3);
%MLB - Se il controllo è andato a buon fine, creiamo la rete e abilitiamo
%la schermata per l'addestramento
if (check)
    clear net;

    net = newNet(c1,c2,c3,matlabFunction(sym(netGUI.err)));%sym, se algebricamente non cambia nulla, inverte l ordine delle variabili e dei parametri da passargli tenendo un ordine alfabetico/
    assignin('base','net',net);
    helpdlg('Rete creata/modificata con successo!','RETE CREATA/MODIFICATA');
    loadedData=evalin('base','loadedData');
    usoGUI = evalin('base','usoGUI');
    if ~(loadedData==1 && usoGUI == 1)
       set(findall(handles.addestra_rete,'-property','Enable'),'Enable','on');
    else
       set(handles.ok_btn_tr,'Enable','on');
    end
    set(handles.file_browse_tr,'Enable','inactive');
    
end

% --- Executes on button press in browse_btn_vs.
function browse_btn_vs_Callback(hObject, eventdata, handles)
% hObject    handle to browse_btn_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sample_vs_Callback(hObject, eventdata, handles)
% hObject    handle to sample_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sample_vs as text
%        str2double(get(hObject,'String')) returns contents of sample_vs as a double


% --- Executes during object creation, after setting all properties.
function sample_vs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok_btn_vs.
function ok_btn_vs_Callback(hObject, eventdata, handles)
% hObject    handle to ok_btn_vs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ok_btn_tr.
function ok_btn_tr_Callback(hObject, eventdata, handles)
% hObject    handle to ok_btn_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% disp(get(handles.sample_tr,'String'));

%MLB - prendiamo il dataset dal workspace, usiamo il workspace SOLO per
%comunicare tra le callback della GUI
dataset = evalin('base','dataset');
usoGUI = evalin('base','usoGUI');
loadedData=evalin('base','loadedData');

%MLB - verifichiamo che nel sample indicato dall'utente non ci siano più 
%elementi di quanti ce ne sono nel dataset
[checkTr,numeroEpoche] = checkTraining(handles,dataset);
if(checkTr)
    %MLB -  randperm prende una permutazione random degli indici degli elementi
    %del dataset
    disp (num2str(usoGUI));
    if ~(loadedData==1 && usoGUI == 1)
    
        subIndex = randperm(size(dataset,1));%TODO Possibile ottimizzazione del procedimento

        subsetTR=loadData(str2double(get(handles.sample_tr,'String')),subIndex,0,dataset);
        subsetVS=loadData(str2double(get(handles.sample_vs,'String')),subIndex,str2double(get(handles.sample_tr,'String')),dataset);
        subsetTS=loadData(str2double(get(handles.sample_vs,'String')),subIndex,2*str2double(get(handles.sample_vs,'String')),dataset);
        %MLB - salva il trainingset nel workspace
        loadedData=1;
        assignin('base','loadedData',loadedData);
        assignin('base','trainingset',subsetTR);
        assignin('base','validationset',subsetVS);
        assignin('base','testset',subsetTS);
    else
         subsetTR=evalin('base','trainingset');
         subsetVS=evalin('base','validationset');
         subsetTS=evalin('base','testset');
    end
    modTR=evalin('base','modTR');
    %MLB - carica la rete dal workspace
    net=evalin('base','net');
    gradient = evalin('base','gradient');
    %MLB - esegue la modalità d'apprendimento selezionata
    switch modTR
        case 1
            [net,gradient]=online(numeroEpoche,subsetTR, subsetVS,subsetTS, net, gradient);
        case 2
           [net,gradient]=batch(numeroEpoche,subsetTR, subsetVS,subsetTS, net, gradient);
            
    end
    
    assignin('base','gradient',gradient);
    assignin('base','net',net);
    %MLB - ottiene i risultati a partire dallo stato della rete dopo
    %l'apprendimento e dai subset del traning set e del validation set
    [results] = verifyNet(net,subsetTR,subsetVS,subsetTS);
    %MLB - richiama la funzione per mostrare i risultati

    plotResults(results);
    
   
    
    assignin('base','results',results);
    set(findall(handles.addestra_rete,'-property','Enable'),'Enable','off');
end




function sample_tr_Callback(hObject, eventdata, handles)
% hObject    handle to sample_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sample_tr as text
%        str2double(get(hObject,'String')) returns contents of sample_tr as a double


% --- Executes during object creation, after setting all properties.
function sample_tr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sample_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function file_browse_tr_Callback(hObject, eventdata, handles)
% hObject    handle to file_browse_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_browse_tr as text
%        str2double(get(hObject,'String')) returns contents of file_browse_tr as a double


% --- Executes during object creation, after setting all properties.
function file_browse_tr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_browse_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse_button_tr.
function browse_button_tr_Callback(hObject, eventdata, handles)
% hObject    handle to browse_button_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

net=evalin('base','net');
%MLB - apriamo una finestra per il browse del file
filePath=uigetfile;
set(handles.file_browse_tr,'String',filePath);

%MLB - carica il file nella variabile b
b = load(filePath);
%MLB - prendiamo il nome esterno della struttura (e.g. bananaData)
x=fieldnames(b);
%MLB - prendiamo i campi all'interno della struttura con nome x
dataset = getfield(b,x{1});

%MLB - se il numero di features corrisponde al numero di features
%all'interno del file (-1 perchè nel file c'è anche il tag)
if((size(dataset,2))-size(net.W{1,end},1) == str2double(get(handles.features_edit,'String')))
    assignin('base','dataset',dataset);
    set(handles.limit_tr,'String',strcat('< ',num2str(size(dataset,1))));
    set(handles.limit_vs,'String',strcat('< ',num2str(size(dataset,1))));
    set(handles.file_browse_tr,'String','FILE CARICATO','fontweight','bold');
    set(handles.file_browse_tr,'BackGroundColor',[0.1 0.6 0.1]);
    set(handles.file_browse_tr,'ForegroundColor','white');
    
else
  errordlg('Numero di features o targets non compatibili con i dati del file!','ERRORE','modal');
  set(handles.file_browse_tr,'BackGroundColor','red');
end



function err_edit_Callback(hObject, eventdata, handles)
% hObject    handle to err_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of err_edit as text
%        str2double(get(hObject,'String')) returns contents of err_edit as a double


% --- Executes during object creation, after setting all properties.
function err_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to err_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_epoche_edit_Callback(hObject, eventdata, handles)
% hObject    handle to num_epoche_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_epoche_edit as text
%        str2double(get(hObject,'String')) returns contents of num_epoche_edit as a double


% --- Executes during object creation, after setting all properties.
function num_epoche_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_epoche_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in modalita.
function modalita_Callback(hObject, eventdata, handles)
% hObject    handle to modalita (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Determine the selected data set.

%MLB - Attiviamo la modailità di esecuzione in base alla scelta
%      scelta effettuata dall'utente.usoGUI = evalin('base','usoGUI');
val = get(hObject,'Value');

switch val;
case 2 %MLB - Modalità Studio.
   usoGUI = 0;
case 1 %MLB - Modalità Libera.
   usoGUI = 1;
end
assignin('base','usoGUI',usoGUI);

% Save the handles structure.
guidata(hObject,handles);


% --- Executes on selection change in modalita_tr.
function modalita_tr_Callback(hObject, eventdata, handles)
% hObject    handle to modalita_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modalita_tr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modalita_tr

% Hint: get(hObject,'Value') returns toggle state of modalita
modTR = evalin('base','modTR');
val = get(hObject,'Value');

%MLB - Attiviamo la modailità di apprentimento in base alla scelta
%      scelta effettuata dall'utente.      
switch val;
case 2 
   modTR = 1; %MLB - Modalità BATCH
case 1 
   modTR = 2; %MLB - Modalità ONLINE
end
assignin('base','modTR',modTR);


% Save the handles structure.
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function modalita_tr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modalita_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
