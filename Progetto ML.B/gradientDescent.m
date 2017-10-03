function [ net, gradient ] = gradientDescent( dw,db,net,gradient )
%GRADIENTDESCENT
% MLB - Funzione per la discesa del gradiente con momento.
% Input :
%   - dw = derivate dell'errore rispetto ai pesi;
%   - db = derivate dell'errore rispetto ai bias;
%   - net = la rete;
%   - gradient = la struttura gradient;
% Output :
%   - net = la rete aggiornata;
%   - gradient = la struttura gradient;

   errorVariationW = cell(1,size(net.W,2));
   errorVariationB = cell(1,size(net.W,2));

   for k=1:size(net.W,2)
       errorVariationW{k} =-(gradient.ETA .* dw{k}) + (gradient.MU .* gradient.errorVariationW{k});
       
       net.W{k} = net.W{k}+errorVariationW{k};
       gradient.errorVariationW{k} = errorVariationW{k};
       
       errorVariationB{k} =-(gradient.ETA .* db{k}) + (gradient.MU .* gradient.errorVariationB{k});
       net.B{k} =  net.B{k}+errorVariationB{k};
       gradient.errorVariationB{k} = errorVariationB{k};
   end


return;
end

