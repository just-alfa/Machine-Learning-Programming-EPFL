function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    


PXYT = zeros(1, size(X, 2));
y_est = zeros(length(out), size(X, 2));
var_est = zeros(length(out), length(out), size(X, 2));


N = length(in);
MuX = Mu(1:N, :);
MuY = Mu(N+1:end, :);
SXX = Sigma(1:N, 1:N, :);
SYY = Sigma(N+1:end, N+1:end, :);
SXY = Sigma(1:N, N+1:end, :);
SYX = Sigma(N+1:end, 1:N, :);


for a = 1:size(X, 2)
    summ = 0;
    for b = 1:size(Mu, 2)
        PXYT(a) = PXYT(a) + Priors(b) * gaussPDF(X(:, a), MuX(:, b), SXX(:, :, b));
    end
    for b = 1:size(Mu, 2)
        var_CD = SYY(:, :, b) - SYX(:, :, b) / SXX(:, :, b) * SXY(:, :, b);
        beta = Priors(b) * gaussPDF(X(:, a), MuX(:, b), SXX(:, :, b));
        h = MuY(:, b) + SYX(:, :, b) / SXX(:, :, b) * (X(:, a) - MuX(:, b));
        weighted_h = beta * h / PXYT(a);
        y_est(:, a) = y_est(:, a) + weighted_h;
        summ = summ + beta * (h .^ 2 + var_CD) / PXYT(a);
    end
    var_est(:, :, a) = summ - (y_est(:, a) .^ 2);
end
end
