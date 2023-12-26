function [Y, A, Z] = forward_pass(X, W, W0, Sigmas)
%FORWARD_PASS This function calculate the forward pass of the network with
%   inputs:
%       o X (NxM) The input data
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the
%       layers
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o Y (PxM) The output of the network, result of the activation
%       function of the last layer
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contain the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer

l = size(W,1);
A = cell(l+1,1);
A{1} = X;
Z = cell(l,1);


for j = 1:l

    Z{j} =  W0{j} + W{j} * A{j} ;

    A{j+1} = forward_activation(Z{j},Sigmas{j});

end

Y = A{l+1};

end