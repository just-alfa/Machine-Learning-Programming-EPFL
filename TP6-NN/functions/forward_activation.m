function [A] = forward_activation(Z, Sigma)
%FORWARD_ACTIVATION Compute the value A of the activation function given Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%
%   outputs:
%       o A (NXM) value of the activation function

if strcmp(Sigma, "sigmoid")
    A = 1 ./ (1 + exp(-Z));
end
if strcmp(Sigma, "tanh")
    A =  tanh(Z);
end
if strcmp(Sigma, "relu")
    A = max(0*Z,Z);
end
if strcmp(Sigma, "leakyrelu")
    A = max(0.01*Z,Z);
end
if strcmp(Sigma,"softmax")
    DELTA = max(Z);
    A = exp(Z-DELTA) ./ sum(exp(Z-DELTA));
end
end