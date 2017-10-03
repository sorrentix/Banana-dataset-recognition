function y = sigmoid( x )
%SIGMOID - funzione sigmoide
%   Questa funzione restituisce il valore della sigmoide all'input x
    y = 1 ./ ( 1 + exp(-x) );
    
return;
end

