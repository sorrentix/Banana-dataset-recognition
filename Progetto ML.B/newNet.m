function net = newNet( numFeatures, infoStrati, funOutput, funErr )
%NEWNET - funzione per la creazione di una nuova rete
%   La funzione prende in input:
%       - numFeatures = numero di features del dataset o nodi di input della rete
%       - infoStrati = vettore contenente il numero di strati (i.e.
%         size(infoStrati)) e il numero di nodi per ogni strato
%       - funOutput = vettore contenente le funzioni di output dei vari
%         strati della rete
%       - funErr = variabile contenente la funzione di errore che la rete
%         deve minimizzare
%   La funzione restituisce in output una rete inizializzata con valori
%   random per i pesi.
gradient.RHO=1.1;
gradient.MU =0.1;
gradient.SIGMA = 0.5;
gradient.ETA=0.1;

    %MLB - Creiamo delle variabili simboliche per le derivate delle
    %funzioni di output e di errore
    syms x;
    syms y;
    syms z;
    
    %MLB - Se il numero di funzioni di output è diverso dal numero di
    %strati, allora ci sono esattamente due funzioni. La prima viene
    %replicata per tutti i nodi degli strati interni, la seconda assegnata a tutti i
    %nodi dell'ultimo strato della rete
    if (size(funOutput,2)~=size(infoStrati,2))
         funzinterna=funOutput{1};
         funzoutput=funOutput{2};
         
         for i=1:size(infoStrati,2)-1
             funOutput{i}=funzinterna;
             
         end
         funOutput{size(infoStrati,2)}=funzoutput;
    end
    
    %MLB - Per ogni strato assegnamo valori random  a pesi e bias di ogni
    %strato, assegnamo la funzione corrispondente e la derivata della
    %funzione corrispondente ad ogni strato
    for i=1:size(infoStrati,2)
        if i == 1
            gradient.errorVariationW{i}=zeros(infoStrati(i),numFeatures);
            net.W{i} = 2*(rand(infoStrati(i),numFeatures))-1;
        else
            gradient.errorVariationW{i}=zeros(infoStrati(i),infoStrati(i-1));
            net.W{i} = 2*(rand(infoStrati(i),infoStrati(i-1)))-1;
        end   
        gradient.errorVariationB{i}=zeros(1,infoStrati(i));
        
        net.B{i} = (2*rand(1, infoStrati(i)))-1;
        net.F{i} = funOutput{i};
        f= net.F{i}(x);
        net.dF{i} = matlabFunction(diff(f,x));
    end
    %MLB - assegna alla rete la funzione d'errore e la sua derivata
    net.E = funErr;
    e = net.E(y,z);
    net.dE = matlabFunction(diff(e));
assignin('base','gradient',gradient);
return;
end

