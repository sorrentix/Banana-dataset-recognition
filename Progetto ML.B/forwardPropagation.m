function [ y,a ] = forwardPropagation( net,x )
%FORWARDPROPAGATION - funzione per la forwardPropagation dell'elemento x
%(oppure dell'insieme x) nella rete net.
%   La funzione prende in input una rete net e un elemento\insieme x e simula la
%   rete net su x. 
%   La funzione restituisce in output due vettori a e y che rappresentano
%   rispettivamente i valori di input ed output per ogni nodo di ogni livello
    [N d]= size(x);
     
    a = cell(size(net.W,1),size(net.W,2));
    y = cell(size(net.W,1),size(net.W,2));
    
   %MLB - Prendiamo x e lo diamo in pasto alla rete, salvando i
   %valori di input ed output per ogni nodo di ogni livello
   a{1} = (net.W{1} * x')'+ repmat(net.B{1},N,1);
   y{1} = net.F{1,1}(a{1});
   
   for k=2: size(net.W,2)
    a{k} = (net.W{k}*y{k-1}')' + repmat(net.B{k},N,1);
    y{k}= net.F{k}(a{k});
   end
  
return;
end

