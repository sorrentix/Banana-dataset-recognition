function subSet = loadData(numdata,subIndex,k,dataset)
%LOADDATA - carica il dataset e ne estrae un sottoinsieme di elementi
%random
%   La funzione prende in input un interno [numdata] che rappresenta il
%   numero di elementi da estrarre dal dataset in modo random.
%   L'output della funzione [subSet] è un vettore di elementi estratti dal
%   dataset.


%MLB - Prende i primi numdata indici della permutazione random e salva gli
%elementi corrispondenti in subset
for i=1:numdata
    for j=1:size(dataset,2)
        subSet(i,j)= dataset(subIndex(1,i+k),j);
    end
end
return;

end

