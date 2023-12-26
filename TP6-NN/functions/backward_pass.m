function [dZ, dW, dW0] = backward_pass(dE, W, A, Z, Sigmas)
%BACKWARD_PASS Perform a backward propogation through
%   inputs:
%       o dE (PxM) The derivative dE/dZL
%       o W {Lx1} cell array containing the weight matrices for all the
%       layers 
%       o b {Lx1} cell array containing the bias matrices for all the
%       layers
%       o A {L+1x1} cell array containing the results of the activation
%       functions at each layer. Also contains the input layer A0.
%       o Z {Lx1} cell array containing the Z values at each layer
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o dZ {Lx1} cell array containing the derivatives dE/dZl values at
%       each layer
%       o dW {Lx1} cell array containing the derivatives of the weights at
%       each layer
%       o dW0 {Lx1} cell array containing the derivatives of the bias at
%       each layer

l = length(W);
m =size(dE,2);
dW = cell(l,1);
dW0 = cell(l,1);
dZ = cell(l,1);

dZ{l} = dE;

for j = l-1 : -1 : 1

    deriv = backward_activation(Z{j}, Sigmas{j});

    dZ{j} = (W{j + 1}' * dZ{j + 1}) .* deriv;

end

for j = 1:l

    dW{j} = (1/m) * dZ{j} * A{j}';

    dW0{j} = mean(dZ{j},2);

end


end