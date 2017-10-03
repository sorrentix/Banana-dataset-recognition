function [ results ] = verifyNet( net, subsetTR, subsetVS, subsetTS )
%VERIFYNET 
%   MLB - La funzione a partire dallo stato della rete dopo l'apprendimento
%   e dai subset del validation set e del training set restituisce una
%   serie di statistiche utili a valutare l'apprendimento effettuato.
% Riceve in input :
%   - la rete;
%   - il subset del Training Set
%   - il subset del Validation Set
% Restitusce in output :
%   - la struttura 'result' contenente tutte le statistiche sulla rete
    N = size(net.W,2);
    %MLB - Inizializza la struttura result
    results.tpTR=0;
    results.tnTR=0;
    results.fpTR=0;
    results.fnTR=0;
    
    results.tpVS=0;
    results.tnVS=0;
    results.fpVS=0;
    results.fnVS=0;
    
    results.tpTS=0;
    results.tnTS=0;
    results.fpTS=0;
    results.fnTS=0;
    %MLB - Ottiene le  informazioni dalla rete e dal target per poter
    %effettuare dei confronti nodo per nodo
    numFeatures = size(subsetTR(:,1:end-size(net.W{1,end},1)),2);
    numTargets = numFeatures+1;
    [y, a] = forwardPropagation(net,subsetTR(:,1:numFeatures));
    TargetTR = subsetTR(:,numTargets:end);
    yTR=y{N};
    
    %MLB - Valuta nodo per nodo confrontando con il training set :
    % - true positive;
    % - true negative;
    % - false positive;
    % - false negative;
    
    
    for k=1:size(subsetTR,1)
        if and((yTR(k) >= 0.5), (TargetTR(k) == 1))
            results.tpTR = results.tpTR+1;
        elseif and((yTR(k) < 0.5), (TargetTR(k) == 0))
            results.tnTR = results.tnTR+1;
        elseif and((yTR(k) < 0.5), (TargetTR(k) == 1))
            results.fnTR = results.fnTR+1;
        elseif and((yTR(k) >= 0.5), (TargetTR(k) == 0))
            results.fpTR=results.fpTR+1;
        end
    end

   %MLB - Ottiene le  informazioni dalla rete e dal target per poter
    %effettuare dei confronti nodo per nodo
    [y, a] = forwardPropagation(net,subsetVS(:,1:numFeatures));
    TargetVS=subsetVS(:,numTargets:end);
    yVS=y{N};
    %MLB - Valuta nodo per nodo confrontando con il validation set :
    % - true positive;
    % - true negative;
    % - false positive;
    % - false negative;
    for k=1:size(subsetVS,1)
        if and((yVS(k) >= 0.5), (TargetVS(k) == 1))
            results.tpVS = results.tpVS+1;
        elseif and((yVS(k) < 0.5), (TargetVS(k) == 0))
            results.tnVS = results.tnVS+1;
        elseif and((yVS(k) < 0.5), (TargetVS(k) == 1))
            results.fpVS = results.fpVS+1;
        elseif and((yVS(k) >= 0.5), (TargetVS(k) == 0))
            results.fnVS=results.fnVS+1;
        end
    end
    
    

    TargetTS=subsetTS(:,numTargets:end);
    yTS=evalin('base','yTS');
   %MLB - Valuta nodo per nodo confrontando con il test set :
    % - true positive;
    % - true negative;
    % - false positive;
    % - false negative;
    
    for k=1:size(subsetTS,1)
        if and((yTS(k) >= 0.5), (TargetTS(k) == 1))
            results.tpTS = results.tpTS+1;
        elseif and((yTS(k) < 0.5), (TargetTS(k) == 0))
            results.tnTS = results.tnTS+1;
        elseif and((yTS(k) < 0.5), (TargetTS(k) == 1))
            results.fpTS = results.fpTS+1;
        elseif and((yTS(k) >= 0.5), (TargetTS(k) == 0))
            results.fnTS=results.fnTS+1;
        end
    end
    
    %MLB - A partire dai risultati ottenuti calcola sia per il validation
    %set che per il training set :
    % - precision;
    % - recall;
    % - specificity;
    % - accuracy;
    
    results.precisionTR   = (results.tpTR+1) / (results.tpTR + results.fpTR+1);
    results.recallTR      = (results.tpTR+1) / (results.tpTR + results.fnTR+1);
    results.specificityTR = (results.tnTR+1) / (results.tnTR + results.fpTR+1);
    results.accuracyTR    = (results.tpTR + results.tnTR+1) / (results.tpTR + results.fpTR + results.tnTR + results.fnTR+1);

    
    results.precisionVS   = (results.tpVS+1) / (results.tpVS + results.fpVS+1);
    results.recallVS      = (results.tpVS+1)/ (results.tpVS + results.fnVS+1);
    results.specificityVS = (results.tnVS+1) / (results.tnVS + results.fpVS+1);
    results.accuracyVS    = (results.tpVS + results.tnVS+1) / (results.tpVS + results.fpVS + results.tnVS + results.fnVS+1);

    results.precisionTS   = (results.tpTS+1) / (results.tpTS + results.fpTS+1);
    results.recallTS      = (results.tpTS+1)/ (results.tpTS + results.fnTS+1);
    results.specificityTS = (results.tnTS+1) / (results.tnTS + results.fpTS+1);
    results.accuracyTS    = (results.tpTS + results.tnTS+1) / (results.tpTS + results.fpTS + results.tnTS + results.fnTS+1);
    
    return;
end

