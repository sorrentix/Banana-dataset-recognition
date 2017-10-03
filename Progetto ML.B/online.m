function [net,gradient] = online( numeroEpoche,subsetTR, subsetVS,subsetTS,net,gradient )
%ONLINE
% MLB - La funzione effettua un apprendimento online della rete e la testa
% su Validation Set e Test Set.
% Input : 
%   - numeroEpoche : numero delle epoche;
%   - subsetTR : il training set;
%   - subsetVS : il validation set;
%   - subsetTS : il test set;
%   - net : la rete;
%   - gradient : la struttura gradient;
%
% Output : 
%   - net : la rete aggiornata;
%   - gradient : la struttura gradient aggiornata;


    
        
    %MLB - eseguiamo l'addestramento della rete su ogni nodo del trainingset 
    
    %MLB - inizializzazione delle varibili necessarie
    h=waitbar(0, sprintf('%s',[ num2str(0) '/' num2str(numeroEpoche) ]), 'Name','Apprendimento in corso...' );
    erroreTotaleTR = zeros(1,numeroEpoche);
    erroreTotaleVS = zeros(1,numeroEpoche);
    consecutiveOverfitting = 0; 
    numFeatures = size(subsetTR(:,1:end-size(net.W{1,end},1)),2);
    numTargets = numFeatures+1; 
    %MLB - inizio dell'apprendimento
    for contaEpoca=1:numeroEpoche
        
        waitbar(contaEpoca/numeroEpoche,h, sprintf('%s',[ num2str(contaEpoca) '/' num2str(numeroEpoche) ' Epoche']) );
        
        
        gradient.ETA = 0.1;
        %MLB - apprendimento sulla singola epoca
        for k=1:size(subsetTR,1)
            [dw, db]=backPropagation(subsetTR(k,1:end),net);
            [net, gradient] = gradientDescent(dw,db,net,gradient);        
        end
        
        %MLB - Calcolo dell'errore sul tr
        erroreSommatoTR = 0;
        
            y = forwardPropagation(net,subsetTR(:,1:numFeatures));
            erroreSommatoTR = sum(net.E(y{size(net.W,2)},subsetTR(:,numTargets:end)));
        
            erroreTotaleTR(contaEpoca) = sum(erroreSommatoTR);
            
        if contaEpoca>1 && (erroreTotaleTR(contaEpoca)-erroreTotaleTR(contaEpoca-1) > 0)
            gradient.ETA= gradient.ETA * gradient.SIGMA;
        else
            gradient.ETA= gradient.ETA * gradient.RHO; 
        end
        
        %MLB - Calcolo dell'errore sul vs
        erroreSommatoVS = 0;
        y = forwardPropagation(net,subsetVS(:,1:numFeatures));
        erroreSommatoVS = sum( net.E(y{size(net.W,2)},subsetVS(:,numTargets:end)));
        erroreTotaleVS(contaEpoca) = sum(erroreSommatoVS);
            
         if contaEpoca > 20 && erroreTotaleTR(contaEpoca)/size(subsetTR,1) < erroreTotaleVS(contaEpoca)/size(subsetVS,1)  && erroreTotaleVS(contaEpoca) - erroreTotaleVS(contaEpoca-1) > 0 && erroreTotaleTR(contaEpoca) - erroreTotaleTR(contaEpoca-1) < 0
            consecutiveOverfitting = consecutiveOverfitting+1;
        else
            consecutiveOverfitting = 0;
        end
        if  consecutiveOverfitting > 15
            uiwait(helpdlg('Apprendimento terminato causa overfitting.','modal'));
            break;
        end
        
    end
    delete(h);
    %MLB - Stampa dei risultati
    plots(subsetTR, subsetVS,subsetTS, erroreTotaleTR, erroreTotaleVS, contaEpoca,'online',net);
    
end

