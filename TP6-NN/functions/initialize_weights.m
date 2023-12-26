function [W, W0] = initialize_weights(LayerSizes, type)
%INITIALIZE_WEIGHTS Initialize the wieghts of the network according to the
%desired type of initialization
%   inputs:
%       o LayerSizes{L+1x1} Cell array containing the sizes of each layers.
%       Also contains the size of A0 input layer
%       o type (string) type of the desired initialization
%       ('random' or 'zeros')
%
%   outputs:
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers

l = length(LayerSizes) -1; 
W0 = cell(l,1);
W = cell(l,1);

for k = 1 : l

if strcmp(type,"random")

    W0{k} = randn(LayerSizes{k+1},1);   

    W{k} = randn(LayerSizes{k+1},LayerSizes{k});  

end 

if strcmp(type, "zeros")

    W0{k} = zeros(LayerSizes{k+1},1);  

    W{k} = zeros(LayerSizes{k+1},LayerSizes{k});


end

end