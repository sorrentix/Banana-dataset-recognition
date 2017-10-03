function [ dw, db ] = backPropagation( x_t,net )
%BACKPROPAGATION - Funzione di backPropagation per l'addestramento della
%rete
%   La funzione applica il processo di addestramento tramite
%   backPropagation alla rete in ingresso.
%   Prende in input un elemento del training set (x_t) e una rete (net).
%   La funzione restituisce in output i vettori dw e db che rappresentano
%   rispettivamente le derivate dei pesi e dei bias ottenuti con il
%   processo di backpropagation che punta alla minimizzazione della
%   funzione di errore.
    
%MLB - Prende solo le features dall'elemento escludendo il tag di classificazione e li salva in x
    x = x_t(:,1:end-size(net.W{1,end},1));
    targ = x_t(:,size(x,2)+1:end);

   
    %MLB - eseguiamo la forwardPropagation sull'elemento e salva input ed
    %output dei nodi (i.e. a,y)
    [y,a] = forwardPropagation(net,x);

    %MLB - dim = numero di strati
    dim = size(net.W,2);
    
    %MLB - inizializzazione per velocizzare l'esecuzione del programma

    dw = cell(1,dim);
    db = cell(1,dim);

    
    %MLB - Calcoliamo il delta k, ovvero la derivata della funzione di
    %errore rispetto agli input dei nodi di output
    derr= net.dE(y{dim},targ);

    if nargin(net.dF{1,end}) == 0
        delta_k = derr .* net.dF{1,end}();
    else
        delta_k = derr .* net.dF{1,end}(a{dim});
    end
    delta=delta_k;
    %MLB - Calcoliamo le derivate dei bias e dei pesi per l'ultimo strato
    %di nodi. Questi saranno poi usati nella discesa del gradiente in modo
    %da aggiornare correttamente i pesi e minimizzare l'errore di classificazione
    db{dim}=sum(delta_k);
    dw{dim}= delta_k' * y{dim-1}; 

    %MLB - Ripetiamo il procedimento appena descritto per tutti gli strati interni
    for k=dim-1:-1:1
        
        delta_j =net.dF{k}(a{k}) .* (delta * net.W{1,k+1} );
        db{k} = sum(delta_j);

        if k > 1
            dw{k}= (delta_j' * y{k-1});
        else
            dw{k}=(delta_j' * x);
        end
        delta=delta_j;
   end

    return;
end

