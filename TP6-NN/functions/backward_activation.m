function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function


if strcmp(Sigma, "sigmoid")

    dZ = exp(-Z)./ (1+exp(-Z)).^2;
    
end

if strcmp(Sigma, "tanh")

   dZ = sech(Z).^2;

end

if strcmp(Sigma, "relu")

    dZ = double(Z > 0);

end

if strcmp(Sigma, "leakyrelu")

    dZ = zeros(size(Z));     

    dZ(Z > 0) = 1;         

    dZ(Z <= 0) = 0.01;       

      
end
end
