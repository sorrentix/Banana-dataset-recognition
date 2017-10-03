function [check,features,stratiInterni,funzioni] = checkRete( reteGUI, h )
%CHECKRETE - funzione per il controllo di coerenza dei dati dalla GUI
%   La funzione effettua vari controlli di coerenza per la GUI descritta
%   nel file mainGUI.m
%   Prende in input una rete e un oggetto handles per refereziare i campi
%   della GUI.
%   Restituisce in output:
%       - check = variabile booleana che consente di capire se ci sono stati errori
%       - features = numero di features della rete
%       - stratiInterni = vettore degli strati interni
%       - funzioni = vettore contenente le funzioni di output dei vari
%         strati

    %MLB - inizializziamo le variabili per ritornarle
    check=1;
    features=2;
    stratiInterni=[10,1];
    funzioni={@tanh};
    
    %MLB - Creiamo la stringa per l'eventuale finestra di dialogo di errore 
    errore='Sono stati riscontrati i seguenti errori : \n';
    
    %MLB - Controllo che nel campo features siano stati inseriti caratteri numerici
    if (isempty(regexp(reteGUI.features,'^\d*$','ONCE')) || (str2double(reteGUI.features)) <= 0)
         check=0;
         errore=strcat(errore,'  - Inserire un valore intero maggiore di 0 per le features.\n');
         set(h.features_edit,'BackgroundColor','red');
    else
         set(h.features_edit,'BackgroundColor','white');
         features = str2double(reteGUI.features);
    end

    %MLB - creiamo un vettore di numeri a partire dalla stringa
    stratiInterni = str2double(regexp(reteGUI.interni,'\,','SPLIT'));
    %MLB - Controlliamo che l'input nel campo degli strati interni rispetti la
    %formattazione richiesta.(e.g. num,num) e ci siano almeno due strati
    if (isempty(regexp(reteGUI.interni,'^\d+(,\d+)*$','ONCE')) || (size(stratiInterni,2) <= 1))
        check=0;
        errore=strcat(errore,'  - Rispettare la formattazione richiesta usando numeri interi separati da virgole per gli strati interni.\n');
        set(h.stratiInterni_edit,'BackgroundColor','red');
    else
        set(h.stratiInterni_edit,'BackgroundColor','white');
    end
    %MLB - Controlliamo che l'input nel campo delle funzioni di output ripsetti la 
    %formattazione richiesta. (e.g. tanh,sigmoid)
    if isempty(regexp(reteGUI.funzioni,'^[a-zA-Z_]+(,[a-zA-Z_]+)*$','ONCE'))
        check=0;
        errore=strcat(errore,'  - Rispettare la formattazione richiesta indicando le funzioni separate da virgole per gli strati interni.\n');
        set(h.funzioniOutput_edit,'BackgroundColor','red');
    else
        set(h.funzioniOutput_edit,'BackgroundColor','white');
        funzioni=regexp(reteGUI.funzioni,'\,','SPLIT');
        s = size(funzioni,2);
        %MLB - Nel caso in cui non ci siano errori di formattazione,
        %controlliamo che il numero di funzioni di output sia 1 o uguale al
        %numero di strati interni inseriti -1
        if(check == 1 &&( s ~= 2 && s ~= (size(regexp(reteGUI.interni,'\,','SPLIT'),2))))
            check=0;
            errore=strcat(errore,'  - Il numero di funzioni deve essere uguale a 2 o al numero di strati.\n');
            set(h.funzioniOutput_edit,'BackgroundColor','red');
        else
            set(h.funzioniOutput_edit,'BackgroundColor','white');
            %MLB - per ogni funzione inserita andiamo a controllare che sia
            %una funzione valida (built in o file.m)
            for k=1:size(funzioni,2)
                if (exist(funzioni{k}) ~= 2 && exist(funzioni{k}) ~= 5) 
                    check=0;
                    errore=strcat(errore,'  - Una delle funzioni inserite non è valida.\n');
                    set(h.funzioniOutput_edit,'BackgroundColor','red');
                    break;
                else
                     set(h.funzioniOutput_edit,'BackgroundColor','white');
                end
            end
            %MLB - concateniamo alle funzioni inserite come stringhe la @
            %in modo da renderle puntatori a funzione
            for t=1:size(funzioni,2)
                funzioni{t}=str2func(strcat('@',funzioni{t}));
            end
           
         end
    end
    %MLB - Controlliamo che il campo per la funzione di errore non sia
    %vuoto
    if isempty(reteGUI.err)
        check=0;
        errore=strcat(errore,'  - Inserire una funzione di errore valida.\n');
        set(h.err_edit,'BackgroundColor','red');
    else
        set(h.err_edit,'BackgroundColor','white');
    end
    %MLB - Se c'è stato un qualsiesi errore mostriamo una dialog di errore
    %con una stringa che indica le correzioni da effettuare
    if(check == 0)
        errordlg(sprintf(errore),'ERRORE','modal');
    end
end
