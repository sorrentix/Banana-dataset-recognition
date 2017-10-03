function [check, numeroEpoche] = checkTraining( h, dataset)
%CHECKTRAINING - Funzione di supporto alla GUI per verificare che i dati
%specificati per l'apprendimento siano coerenti.
%La funzione prende in ingresso un handler h per la gestione della gui e il
%dataset per effettuare opportunamente i controlli.

    %MLB - inizializziamo le variabili per ritornarle
    check=1;
    
    %MLB - Creiamo la stringa per l'eventuale finestra di dialogo di errore 
    errore='Sono stati riscontrati i seguenti errori : \n';
    
    
    if str2double(get(h.sample_tr,'String')) < size(dataset,1) && str2double(get(h.sample_tr,'String')) > 0
        set(h.sample_tr,'BackgroundColor','white');
    else
        errore = strcat(errore,' - Errore specificare un numero di elementi valido per il Training set \n');
        set(h.sample_tr,'BackgroundColor','red');
        check = 0;
    end
    
    if str2double(get(h.sample_vs,'String')) < size(dataset,1) && str2double(get(h.sample_vs,'String')) > 0
        set(h.sample_vs,'BackgroundColor','white');
    else
        errore = strcat(errore,' - Errore specificare un numero di elementi valido per il Validation set \n');
        set(h.sample_vs,'BackgroundColor','red');
        check = 0;
    end
    
    checkNumeroEpoche = regexprep(get(h.num_epoche_edit,'String'),'\s','');
    numeroEpoche = str2double(checkNumeroEpoche);
    if (isempty(regexp(checkNumeroEpoche,'^\d*$','ONCE')) || (numeroEpoche) <= 0)
        errore = strcat(errore,' - Inserire un valore intero maggiore di 0 per le epoche.\n');
        set(h.num_epoche_edit,'BackgroundColor','red');
        check = 0;
    else
         set(h.num_epoche_edit,'BackgroundColor','white');
    end
    
    %MLB - Se c'è stato un qualsiesi errore mostriamo una dialog di errore
    %con una stringa che indica le correzioni da effettuare
    if(check == 0)
        errordlg(sprintf(errore),'ERRORE','modal');
    end
    return;
end